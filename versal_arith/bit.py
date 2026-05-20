"""Bit class for bitheap representation.

Each bit in the bitheap carries metadata about its source signal,
complementation, and constant status. The uid field provides a
unique integer index for internal bitheap bookkeeping.
"""

from __future__ import annotations
from dataclasses import dataclass


@dataclass
class Bit:
    """A single bit in the bitheap with source metadata.

    Attributes
    ----------
    signal_name : str
        Verilog signal name this bit originates from (e.g., "in_col0").
    signal_index : int
        Bit position within the source signal.
    complemented : bool
        True if this bit should be complemented (~) before use.
    is_constant : bool
        True if this bit is a constant 1'b1.
    uid : int
        Internal unique index for bitheap bookkeeping.
    """
    signal_name: str = ""
    signal_index: int = 0
    complemented: bool = False
    is_constant: bool = False
    uid: int = 0

    def __repr__(self) -> str:
        if self.is_constant:
            return f"Bit(1'b1, uid={self.uid})"
        comp = "~" if self.complemented else ""
        if self.signal_name:
            return f"Bit({comp}{self.signal_name}[{self.signal_index}], uid={self.uid})"
        return f"Bit(uid={self.uid})"
