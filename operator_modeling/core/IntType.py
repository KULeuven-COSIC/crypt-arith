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

    @staticmethod
    def union(bounds) -> IntType:
        """Smallest interval containing every bound in `bounds`.

        Needed wherever one wire carries values that came from several different
        sources — a matrix transpose's output lane draws from every input lane,
        so its type has to cover all of them.

        `zeroLsbs` takes the **minimum**, never the maximum. If one source
        guarantees 39 zero low bits and another guarantees none, a wire carrying
        both guarantees none. Claiming more is the failure fixed in ca98a3e: a
        bound asserting zero bits the data does not have makes correct hardware
        fall outside its own predicted interval.
        """
        bounds = list(bounds)
        if not bounds:
            raise ValueError('IntType.union: needs at least one bound')
        for i, b in enumerate(bounds):
            if not isinstance(b, IntType):
                raise TypeError(
                    f'IntType.union: element {i} is {type(b).__name__}, not IntType'
                )
        return IntType(min(b.minValue for b in bounds),
                       max(b.maxValue for b in bounds),
                       min(b.zeroLsbs for b in bounds))

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
    '''Load per-port IntType bounds from a constant-multiplier bank's side-car.

    Returns the bounds in the order the bank wrote them
    (entry i ↔ cmult P_i ↔ NTT natural-input x[i]), ready to hand to
    `FullyPipelinedNTT.getInputsNatural`.

    Typical use:

        from operator_modeling.core.IntType import loadBoundsJson
        bounds = loadBoundsJson('work/<scenario>/cmultbank/output_bounds.json')
        ntt.getInputsNatural(bounds)

    Two on-disk formats are accepted.

    **Schema 2** — a dict with `schema: 2` and an `entries` list, written by
    `versal_arith.rtl_gen.const_mult_op.ConstMultBank_RTL_gen` from the model's
    own `IntType`s. Bounds are used verbatim, including `zeroLsbs`, because the
    declared port width *is* the interval-derived width by construction.

    **Schema 1** — a bare list, written by the legacy
    `rtl_gen.const_mult.Cmultbank_RTL_gen`, which sizes ports from `width_a`
    alone via `_output_width`. That formula computes `max_abs.bit_length() + 1`
    where `IntType.bitWidth` computes
    `max((-min-1).bit_length(), max.bit_length()) + 1`; the two differ by one
    exactly when `-prod_min` is a power of two, i.e. for a signed input times a
    positive power-of-two constant. A 25288-combination sweep found the
    generator is **never narrower** and wider on 783 of them.

    Returning the interval-derived width for a schema-1 file would under-size a
    downstream consumer's input port by one bit against the bank's actual
    driver, so the bound is widened on its negative edge until it matches the
    declared `bitWidth`. `maxValue` is left tight, keeping downstream
    propagation as sharp as the data allows. Schema-2 files need none of this.
    '''
    import json
    with open(path) as f:
        data = json.load(f)

    if isinstance(data, dict):
        schema = data.get('schema')
        if schema != 2:
            raise ValueError(
                f'loadBoundsJson({path!r}): unrecognised schema {schema!r} '
                f'(expected 2, or a bare list for the legacy format)'
            )
        return [
            IntType(d['minValue'], d['maxValue'], d.get('zeroLsbs', 0))
            for d in data['entries']
        ]

    out: list[IntType] = []
    for d in data:
        bound = IntType(d['minValue'], d['maxValue'], 0)
        declared = d.get('bitWidth')
        if declared is not None and declared > bound.bitWidth:
            if bound.isSigned:
                # Signed bitWidth is max(negWidth, posWidth) + 1, so pushing the
                # negative edge out to -2^(declared-1) forces exactly `declared`
                # and leaves maxValue untouched.
                bound = IntType(-(1 << (declared - 1)), d['maxValue'], 0)
            else:
                bound = IntType(d['minValue'], (1 << declared) - 1, 0)
            if bound.bitWidth != declared:
                raise ValueError(
                    f'loadBoundsJson({path!r}): could not widen entry '
                    f'{d.get("idx")} to declared bitWidth {declared} '
                    f'(got {bound.bitWidth})'
                )
        out.append(bound)
    return out
