from __future__ import annotations
from dataclasses import dataclass, field
from bitheap import BitHeap


@dataclass(eq=False)
class Counter:
    """Template for individual GPC instances.

    Tracks the counter's name, I/O configuration, cascade flags,
    placement column, and LUT cost.
    """
    name: str                                          # name of the counter for human recognition
    inputs: list[int] = field(default_factory=list)    # inputs of the counter, e.g. [1, 5]
    outputs: list[int] = field(default_factory=list)   # outputs of the counter, e.g. [1, 1, 1]
    in_cascade: bool = field(default=False)            # whether this counter is cascaded to another counter via LOOKAHEAD8
    out_cascade: bool = field(default=False)           # whether this counter can be cascaded to another counter via LOOKAHEAD8
    applied_column: int = field(default=0)             # which column this counter is applied at
    LUT_cost: int = field(default=0)

    def __repr__(self):
        return f"Counter(name={self.name}, col={self.applied_column})"

    # ---------------------------- Core operations ---------------------------
    def commit(self, bitheap: BitHeap, check_bound=False):
        """commit the counter to the bitheap"""
        if not check_bound:
            # lock input bits in the bitheap
            for i in range(len(self.inputs)):
                bitheap.lock_bits(self.applied_column+i, self.inputs[len(self.inputs) - 1 - i], True if (self.in_cascade and i == 0) else False)
            # add output bits to the next-round list
            for i in range(len(self.outputs)):
                bitheap.add_bits_next_round(self.applied_column+i, self.outputs[len(self.outputs) - 1 - i], True if (self.out_cascade and i == len(self.outputs) - 1) else False)
        else:
            # lock input bits in the bitheap
            for i in range(len(self.inputs)):
                if self.applied_column + i <= bitheap.width - 1:
                    bitheap.lock_bits(self.applied_column+i, self.inputs[len(self.inputs) - 1 - i], True if (self.in_cascade and i == 0) else False)
            for i in range(len(self.outputs)):
                if self.applied_column + i <= bitheap.width - 1:
                    bitheap.add_bits_next_round(self.applied_column+i, self.outputs[len(self.outputs) - 1 - i], True if (self.out_cascade and i == len(self.outputs) - 1) else False)
