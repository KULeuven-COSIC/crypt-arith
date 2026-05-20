from __future__ import annotations

import os
from dataclasses import dataclass, field
from typing import Dict, List, Tuple, Optional

import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

from bit import Bit


@dataclass
class Column:
    """
    Represents one column in a bit heap.

    This class tracks:
      - all bits currently in the column (free + locked)
      - which of those are locked
      - which are free (derived from all - locked)
      - bits scheduled to appear in the next round
      - bits in the next round that can be cascaded via LOOKAHEAD8

    Each bit is a Bit instance with a unique uid. UIDs are monotonically
    increasing within each list.
    """
    index: int
    _all_bits: List[Bit] = field(default_factory=list, repr=True)
    _locked_bits: List[Bit] = field(default_factory=list, repr=True)
    _all_bits_next_round: List[Bit] = field(default_factory=list, repr=True)
    _number_of_cascade_bits: int = field(default=0, repr=True)

    # ---------- Derived properties (automatically synchronized) ----------
    @property
    def all_bits(self) -> List[Bit]:
        return list(self._all_bits)

    @property
    def locked_bits(self) -> List[Bit]:
        return list(self._locked_bits)

    @property
    def free_bits(self) -> List[Bit]:
        # All bits minus the ones that are locked, preserving order of _all_bits
        locked_uids = set(b.uid for b in self._locked_bits)
        return [b for b in self._all_bits if b.uid not in locked_uids]

    @property
    def number_of_bits(self) -> int:
        return len(self._all_bits)

    @property
    def number_of_locked_bits(self) -> int:
        return len(self._locked_bits)

    @property
    def number_of_free_bits(self) -> int:
        return self.number_of_bits - self.number_of_locked_bits

    @property
    def number_of_bits_next_round(self) -> int:
        return len(self._all_bits_next_round)

    @property
    def all_bits_next_round(self) -> List[Bit]:
        return list(self._all_bits_next_round)

    @property
    def number_of_cascade_bits(self) -> int:
        return int(self._number_of_cascade_bits)

    @property
    def have_cascade_bits(self) -> bool:
        if self._number_of_cascade_bits > 0:
            return True
        else:
            return False


    # ---------------------------- Core operations ---------------------------
    def __repr__(self) -> str:
        all_uids = [b.uid for b in self._all_bits]
        free_uids = [b.uid for b in self.free_bits]
        locked_uids = [b.uid for b in self._locked_bits]
        next_uids = [b.uid for b in self._all_bits_next_round]
        return (
            f"Column(index={self.index})\n"
            f"  Number of Bits: {self.number_of_bits}\n"
            f"  All Bits: {all_uids}\n"
            f"  Number of Free Bits: {self.number_of_free_bits}\n"
            f"  Free Bits: {free_uids}\n"
            f"  Number of Locked Bits: {self.number_of_locked_bits}\n"
            f"  Locked Bits: {locked_uids}\n"
            f"  Number of Bits Next Round: {self.number_of_bits_next_round}\n"
            f"  All Bits Next Round: {next_uids}\n"
        )

    def _next_uid(self, pool: List[Bit]) -> int:
        """Return the next uid to use for a given pool (current or next round)."""
        return (pool[-1].uid + 1) if pool else 0

    def add_bits(self, n: int) -> None:
        """
        Add `n` new FREE bits to the current round of this column.
        New bit uids continue from the current max of _all_bits.
        """
        if n <= 0:
            return
        start = self._next_uid(self._all_bits)
        self._all_bits.extend(Bit(uid=start + i) for i in range(n))

    def add_bit(self, bit: Bit) -> None:
        """Add a single Bit with metadata to this column, assigning it a uid."""
        bit.uid = self._next_uid(self._all_bits)
        self._all_bits.append(bit)

    def lock_bits(self, n: int, cascade: bool) -> None:
        """
        Lock the first `n` FREE bits (assignment to a counter).
        Raises ValueError if n is not positive.
        Gives warning if there are less free bits than n
        """
        free = self.free_bits
        if n <= 0:
            raise ValueError(f"Cannot lock {n} bits, the number should be positive.")
        if (n > len(free)) and (not(n == len(free) + 1 and cascade)):
            print(f"WARNING: lock {n} bits but {len(free)} free bits available; rest should be filled with zeroes.")
        if cascade:
            self._number_of_cascade_bits -= 1
            del self._all_bits_next_round[-1]
            n = len(free) if n > len(free) else n-1
            if n:
                self._locked_bits.extend(free[:n])
        else:
            n = len(free) if n > len(free) else n
            self._locked_bits.extend(free[:n])

    def add_bits_next_round(self, n: int, cascade: bool) -> None:
        """
        Stage `n` new bits to appear in the NEXT round for this column.
        """
        if n <= 0:
            return
        start = self._next_uid(self._all_bits_next_round)
        self._all_bits_next_round.extend(Bit(uid=start + i) for i in range(n))
        if cascade:
            self._number_of_cascade_bits += 1

    def advance_round(self) -> Tuple[List[int], List[int]]:
        """
        Finalize the round, carrying over any remaining FREE bits into next round.
        Also appends those carried bits (with fresh uids) into the next-round list.

        Returns:
            (indexes_old, indexes_new)
              - indexes_old: free-bit uids from the OLD round
              - indexes_new: the corresponding NEW uids assigned in next round

        This is useful for generating Verilog assignments like:
            assign next_round[new_idx] = current_round[old_idx];
        """
        # Map remaining free bits to fresh uids in next round
        free = self.free_bits
        indexes_old = [b.uid for b in free]
        if free:
            start = self._next_uid(self._all_bits_next_round)
            indexes_new = list(range(start, start + len(free)))
            self._all_bits_next_round.extend(Bit(uid=start + i) for i in range(len(free)))
        else:
            indexes_new = []

        # Commit: next round becomes current; reset locks, cascading and staging
        self._all_bits = self._all_bits_next_round
        self._locked_bits.clear()
        self._all_bits_next_round = []
        self._number_of_cascade_bits = 0

        return indexes_old, indexes_new

    def clear_cascade_bits(self):
        self._number_of_cascade_bits = 0


class BitHeap:
    """
    Represents the whole bit-heap across columns and rounds.

    Attributes
    ----------
    height : int
        logical height in y direction, equal to the maximum column height when the bitheap gets initialized
    width : int
        the effective number of columns so far during the compression process
        the new carry out of MSB might increase the number of columns
    heap : List[Column]
        the actual bitheap, consisting of a list of Column instances
    """

    def __init__(self, n: int, preallocate: int = 0) -> None:
        """
        Parameters
        ----------
        n : int
            number of columns at initialization
            can be extended later
        preallocate : int
            extra columns can also be pre-allocated at initialization
        """
        if n < 0 or preallocate < 0:
            raise ValueError("n and preallocate must be non-negative.")
        self.height: int = n
        self.width: int = n
        cap = n + preallocate
        self.heap: list[Column] = [Column(i) for i in range(cap)]

    # ------------------------- private functions -------------------------

    def _ensure_capacity(self, upto_index_inclusive: int) -> None:
        """make sure the width of the bitheap covers all bits during the compression process"""
        if upto_index_inclusive < len(self.heap):
            return
        old_len = len(self.heap)
        new_len = upto_index_inclusive + 1
        self.heap.extend(Column(i) for i in range(old_len, new_len))

    def _update_width_from_next_round(self) -> None:
        """
        according to the non-empty columns in the next round, update the width of the bitheap
        index of any column with number_of_bits_next_round > 0 should be included within the new width
        """
        max_used: Optional[int] = None
        for col in self.heap:
            if col.number_of_bits_next_round > 0:
                max_used = col.index if max_used is None else max(max_used, col.index)
        if max_used is not None:
            self.width = max(self.width, max_used + 1)

    # ------------------------- public API -------------------------

    def __repr__(self) -> str:
        header = f"BitHeap(height={self.height}, width={self.width})\n"
        body = "".join(repr(self.heap[i]) for i in range(self.width))
        return header + body

    def add_bits(self, column_index: int, n: int) -> None:
        """add n free bits to target column"""
        if n <= 0:
            return
        self._ensure_capacity(column_index)
        self.heap[column_index].add_bits(n)
        self.width = max(self.width, column_index + 1)
        self.height = max(self.height, self.heap[column_index].number_of_bits)

    def add_bit(self, column_index: int, bit: Bit) -> None:
        """Add a single Bit with metadata to target column."""
        self._ensure_capacity(column_index)
        self.heap[column_index].add_bit(bit)
        self.width = max(self.width, column_index + 1)
        self.height = max(self.height, self.heap[column_index].number_of_bits)

    @classmethod
    def from_descriptor(cls, desc: list, preallocate: int = 0) -> 'BitHeap':
        """Create a BitHeap from a column descriptor list.

        Each element of desc is: [col_index, (signal_name, signal_index, neg, cnst), ...]

        Parameters
        ----------
        desc : list
            Column descriptors. signal_name=None gets a default name.
            signal_index=None means a 1-bit signal (no Verilog index).
            cnst=True means the bit is constant 1'b1.
        preallocate : int
            Extra columns to pre-allocate beyond the max column index.
        """
        max_col = max(entry[0] for entry in desc) if desc else 0
        bh = cls(max_col + 1, preallocate)
        for entry in desc:
            col_idx = entry[0]
            for sig_tuple in entry[1:]:
                signal_name, signal_index, neg, cnst = sig_tuple
                if signal_name is None:
                    signal_name = f"col{col_idx}"
                if signal_index is None:
                    signal_index = -1
                bit = Bit(signal_name=signal_name, signal_index=signal_index,
                          complemented=neg, is_constant=cnst)
                bh.add_bit(col_idx, bit)
        return bh

    def lock_bits(self, column_index: int, n: int, cascade: bool) -> None:
        """lock first few bits in target column"""
        self._ensure_capacity(column_index)
        self.heap[column_index].lock_bits(n, cascade)

    def add_bits_next_round(self, column_index: int, n: int, cascade: bool) -> None:
        """add n new bits for next round to target column"""
        if n <= 0:
            return
        self._ensure_capacity(column_index)
        self.heap[column_index].add_bits_next_round(n, cascade)
        self.width = max(self.width, column_index + 1)

    def clear_cascade_bits(self):
        """clear cascade bits in all columns"""
        for col in self.heap:
            col.clear_cascade_bits()

    def check_last_layer(self, threshold: int = 4) -> tuple[bool, int]:
        """
        check if the quaternary adder for terminal addition can be applied, criteria: free bits <= threshold。
        threshold = 4 here (quaternary adder)
        """
        start_column = 0
        for i in range(self.width):
            if self.heap[i].number_of_free_bits > 1:
                start_column = i
                break
        i = 0
        for col in range(start_column, self.width):
            if i <= 1:
                if self.heap[col].number_of_free_bits > threshold + 1:
                    return False, start_column
            else:
                if self.heap[col].number_of_free_bits > threshold:
                    return False, start_column
            i += 1
        return True, start_column

    def is_finished(self) -> bool:
        """each column has and only has exactly 1 free bit"""
        for i in range(self.width):
            if self.heap[i].number_of_free_bits != 1:
                return False
        return True

    def average_height(self) -> float:
        """average number of free bits over all columns"""
        if self.width == 0:
            return 0.0
        height_sum = sum(self.heap[i].number_of_free_bits for i in range(self.width))
        return height_sum / self.width

    def advance_round(self) -> Dict[int, Tuple[List[int], List[int]]]:
        """
        Update the whole bitheap to go to next round of compression: for each column, run Column.advance_round()

        Returns
        -------
        assign_map : Dict[int, (indexes_old, indexes_new)]
            key of the dictionary is the column index
            value of the dictionary is the bit index before and after going to the next round
            used to generate the assignment statement in RTL code
        """
        self._update_width_from_next_round()

        assign_map: Dict[int, Tuple[List[int], List[int]]] = {}
        for idx in range(self.width):
            assign_map[idx] = self.heap[idx].advance_round()

        # update the height after going to the new round of compression
        if self.width:
            self.height = max(self.heap[i].number_of_bits for i in range(self.width))

        return assign_map

    # ------------------------- bitheap visualization -------------------------

    def visualize(self, filename: str, use_next_round: bool = False) -> None:
        """
        visualize bit-heap

        Parameters
        ----------
        filename : str
            the path for the output figure
        use_next_round : bool
            True: plot the new bits for the next round
            False: plot bits for current round
        """
        x_plot: List[int] = []
        y_plot: List[int] = []

        def bit_count(col: Column) -> int:
            return col.number_of_bits_next_round if use_next_round else col.number_of_bits

        for i in range(self.width):
            for j in range(bit_count(self.heap[i])):
                x_plot.append(i)
                y_plot.append(j)

        fig, ax = plt.subplots(figsize=(max(6, self.width), max(4, min(12, self.height))))
        ax.scatter(x_plot, y_plot, s=30, marker='o')
        ax.invert_xaxis()
        ax.xaxis.set_major_locator(ticker.MultipleLocator(1))
        ax.set_xlim(self.width - 0.5, -0.5)
        ax.set_ylim(-0.5, max(y_plot, default=0) + 0.5)
        ax.tick_params(axis='x', length=0)
        ax.set_aspect('equal')
        ax.set_yticks([])
        ax.set_xlabel('')
        ax.set_ylabel('')
        for spine in ['top', 'right', 'left', 'bottom']:
            ax.spines[spine].set_visible(False)
        plt.tight_layout()
        fig_dir = "bitheap_visualization"
        os.makedirs(fig_dir, exist_ok=True)
        fig_path = os.path.join(fig_dir, filename)
        plt.savefig(fig_path, dpi=300, bbox_inches='tight')
        plt.close(fig)