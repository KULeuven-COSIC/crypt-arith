from __future__ import annotations
from math import log2


class IntType:
    def __init__(self, minValue: int, maxValue: int, zeroLsbs: int = 0):
        if minValue > maxValue:
            raise ValueError(f'minValue {minValue} cannot be greater than maxValue {maxValue}')
        if zeroLsbs < 0:
            raise ValueError(f'zeroLsbs {zeroLsbs} cannot be negative')
        self.minValue: int = minValue
        self.maxValue: int = maxValue
        self.zeroLsbs: int = zeroLsbs

    @property
    def isZero(self) -> bool:
        return self.minValue == 0 and self.maxValue == 0

    @property
    def isSigned(self) -> bool:
        return self.minValue < 0

    @property
    def bitWidth(self) -> int:
        if self.isZero:
            return 0
        if not self.isSigned:
            return self.maxValue.bit_length()
        else:
            negWidth = (-self.minValue - 1).bit_length()
            posWidth = self.maxValue.bit_length()
            return max(negWidth, posWidth) + 1

    @staticmethod
    def trailingZerosOfInt(x: int) -> int:
        if x == 0:
            return 0
        x = abs(x)
        tz = 0
        while x % 2 == 0:
            tz += 1
            x //= 2
        return tz

    @staticmethod
    def fromConst(value: int) -> IntType:
        zeroLsbs = IntType.trailingZerosOfInt(value) if value != 0 else 0
        return IntType(value, value, zeroLsbs)

    @staticmethod
    def signed(bitWidth: int, zeroLsbs: int = 0) -> IntType:
        if bitWidth <= 0:
            return IntType(0, 0, 0)
        minValue = -(1 << (bitWidth - 1))
        maxValue = (1 << (bitWidth - 1)) - 1
        return IntType(minValue, maxValue, zeroLsbs)

    @staticmethod
    def unsigned(bitWidth: int, zeroLsbs: int = 0) -> IntType:
        if bitWidth <= 0:
            return IntType(0, 0, 0)
        minValue = 0
        maxValue = (1 << bitWidth) - 1
        return IntType(minValue, maxValue, zeroLsbs)

    def __add__(self, other: IntType | int) -> IntType:
        if isinstance(other, int):
            other = IntType.fromConst(other)
        if self.isZero:
            return IntType(other.minValue, other.maxValue, other.zeroLsbs)
        if other.isZero:
            return IntType(self.minValue, self.maxValue, self.zeroLsbs)
        maxValue = self.maxValue + other.maxValue
        minValue = self.minValue + other.minValue
        zeroLsbs = min(self.zeroLsbs, other.zeroLsbs)
        return IntType(minValue, maxValue, zeroLsbs)

    def __radd__(self, other: IntType | int) -> IntType:
        if isinstance(other, int):
            return self.__add__(IntType.fromConst(other))
        return NotImplemented
    
    def __neg__(self) -> IntType:
        return IntType(-self.maxValue, -self.minValue, self.zeroLsbs)    

    def __sub__(self, other: IntType | int) -> IntType:
        if isinstance(other, int):
            other = IntType.fromConst(other)
        if self.isZero:
            return -other
        if other.isZero:
            return IntType(self.minValue, self.maxValue, self.zeroLsbs)
        maxValue = self.maxValue - other.minValue
        minValue = self.minValue - other.maxValue
        zeroLsbs = min(self.zeroLsbs, other.zeroLsbs)
        return IntType(minValue, maxValue, zeroLsbs)
    
    def __rsub__(self, other: IntType | int) -> IntType:
        if isinstance(other, int):
            return IntType.fromConst(other) - self
        return NotImplemented

    def __mul__(self, other: IntType | int) -> IntType:
        if isinstance(other, IntType):
            if self.isZero or other.isZero:
                return IntType(0, 0, 0)
            a = self.maxValue * other.maxValue
            b = self.maxValue * other.minValue
            c = self.minValue * other.maxValue
            d = self.minValue * other.minValue
            maxV = max(a, b, c, d)
            minV = min(a, b, c, d)
            zeroLsbs = self.zeroLsbs + other.zeroLsbs
            return IntType(minV, maxV, zeroLsbs)
        if isinstance(other, int):
            if other == 0 or self.isZero:
                return IntType(0, 0, 0)
            a = self.minValue * other
            b = self.maxValue * other
            minV = min(a, b)
            maxV = max(a, b)
            zeroLsbs = self.zeroLsbs + IntType.trailingZerosOfInt(other)
            return IntType(minV, maxV, zeroLsbs)
        return NotImplemented

    def __rmul__(self, other: IntType | int) -> IntType:
        if isinstance(other, int):
            return self.__mul__(other)
        return NotImplemented

    def __lshift__(self, shift: int) -> IntType:
        if not isinstance(shift, int):
            raise TypeError(f'Shift amount must be an integer, but got {type(shift)}')
        if self.isZero:
            return IntType(0, 0, 0)
        minV = self.minValue << shift
        maxV = self.maxValue << shift
        zeroLsbs = self.zeroLsbs + shift
        return IntType(minV, maxV, zeroLsbs)

    def __rshift__(self, shift: int) -> IntType:
        if not isinstance(shift, int):
            raise TypeError(f'Shift amount must be an integer, but got {type(shift)}')
        if self.isZero:
            return IntType(0, 0, 0)
        minV = self.minValue >> shift
        maxV = self.maxValue >> shift
        if minV == 0 and maxV == 0:
            return IntType(0, 0, 0)
        zeroLsbs = max(0, self.zeroLsbs - shift)
        return IntType(minV, maxV, zeroLsbs)

    def __str__(self) -> str:
        if self.isZero:
            return "[0, 0](0)"
        strMinSign = "-" if self.minValue < 0 else ""
        strMaxSign = "-" if self.maxValue < 0 else ""
        strType = "s" if self.isSigned else "u"
        strMin = f"2^{log2(abs(self.minValue)):.2f}" if self.minValue != 0 else "0"
        strMax = f"2^{log2(abs(self.maxValue)):.2f}" if self.maxValue != 0 else "0"
        return f"[{strMinSign}{strMin}, {strMaxSign}{strMax}] ({strType}{self.bitWidth}), zeroLsbs={self.zeroLsbs}"

    def __repr__(self):
        return self.__str__()

    def slice(self, start: int, end: int) -> IntType:
        width = end - start + 1
        assert width > 0
        shifted = self >> start
        if width <= shifted.zeroLsbs:
            return IntType(0, 0, 0)
        elif width < shifted.bitWidth:
            return IntType.unsigned(width - shifted.zeroLsbs) << shifted.zeroLsbs
        else:
            return shifted


def loadBoundsJson(path: str) -> list[IntType]:
    '''Load a list of IntType bounds from a JSON file written by
    versal_arith.rtl_gen.const_mult.Cmultbank_RTL_gen.

    The JSON is a list of objects with at least `minValue` and `maxValue`
    fields per entry; this helper builds `IntType(minValue, maxValue, 0)`
    for each one. The list is returned in the same natural-index order the
    bank wrote it (entry i ↔ cmult P_i ↔ NTT natural-input x[i]).

    Typical use:

        from NTT_modeling.IntType import loadBoundsJson
        bounds = loadBoundsJson('work/<scenario>/cmultbank/output_bounds.json')
        ntt.getInputsNatural(bounds)
    '''
    import json
    with open(path) as f:
        data = json.load(f)
    return [IntType(d['minValue'], d['maxValue'], 0) for d in data]
