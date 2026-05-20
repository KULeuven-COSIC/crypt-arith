from __future__ import annotations
from .Port import Port, SimpleInputPort, SimpleOutputPort
from .ButterflyScheme import ButterflyScheme, GoldilocksSlice64
from .IntType import IntType
from .utils import nafTerms, nafTermsCount, nafTermsMaxPower


class Butterfly():
    def __init__(self, name: str = "Undefined Butterfly", butterflyType: str = "CT", scheme: ButterflyScheme | None = None, twiddle: int | list[tuple[int, int]] | Port | None = None):
        self.name: str = name
        self.butterflyType: str = butterflyType
        self.inputPortA: Port | None = SimpleInputPort(name=f'{name} Input Port A')
        self.inputPortB: Port | None = SimpleInputPort(name=f'{name} Input Port B')
        self.outputPortA: Port | None = SimpleOutputPort(name=f'{name} Output Port A')
        self.outputPortB: Port | None = SimpleOutputPort(name=f'{name} Output Port B')
        if isinstance(twiddle, Port):
            self.twiddlePort = twiddle
            self.twiddle = None
        elif isinstance(twiddle, int) or isinstance(twiddle, list):
            self.twiddlePort = None
            self.twiddle = twiddle
        elif twiddle is None:
            self.twiddlePort: Port | None = None
            self.twiddle: int | list[tuple[int, int]] | None = None
        else:
            raise TypeError(f"twiddle must be int, list[tuple[int, int]] (NAF) or Port, got {type(twiddle)} instead")
        self.scheme: ButterflyScheme | None = scheme
            

    def initializeInputs(self, inputA: IntType | list[int], inputB: IntType | list[int]) -> None:
        if isinstance(inputA, IntType) and isinstance(self.inputPortA, SimpleInputPort):
            self.inputPortA.pull(inputA)
        elif isinstance(inputA, list) and isinstance(self.inputPortA, SimpleInputPort):
            if not all(isinstance(x, int) for x in inputA):
                raise TypeError(f'all elements of inputA must be int when passing a test-vector batch')
            self.inputPortA.testVector = inputA
        else:
            raise TypeError(f'inputA must be either an IntType or a list of integers, but got {type(inputA)}')
        if isinstance(inputB, IntType) and isinstance(self.inputPortB, SimpleInputPort):
            self.inputPortB.pull(inputB)
        elif isinstance(inputB, list) and isinstance(self.inputPortB, SimpleInputPort):
            if not all(isinstance(x, int) for x in inputB):
                raise TypeError(f'all elements of inputB must be int when passing a test-vector batch')
            self.inputPortB.testVector = inputB
        else:
            raise TypeError(f'inputB must be either an IntType or a list of integers, but got {type(inputB)}')
        

    def connectInTo(self, connectATo: tuple[Butterfly, str], connectBTo: tuple[Butterfly, str]) -> None:
        if not isinstance(connectATo, tuple):
            raise TypeError(f"connectATo must be a tuple, got {type(connectATo)} instead")
        if not isinstance(connectBTo, tuple):
            raise TypeError(f"connectBTo must be a tuple, got {type(connectBTo)} instead")
        targetButterflyA, targetPortA = connectATo
        targetButterflyB, targetPortB = connectBTo
        if not isinstance(targetButterflyA, Butterfly) or not isinstance(targetPortA, str):
            raise TypeError(f"connectA shoud be (Butterfly, str), got ({type(targetButterflyA)}, {type(targetPortA)}) instead")
        if not isinstance(targetButterflyB, Butterfly) or not isinstance(targetPortB, str):
            raise TypeError(f"connectB shoud be (Butterfly, str), got ({type(targetButterflyB)}, {type(targetPortB)}) instead")
        if targetPortA == 'A' or targetPortA == 'a':
            self.inputPortA.connect(targetButterflyA.outputPortA)
        elif targetPortA == 'B' or targetPortA == 'b':
            self.inputPortA.connect(targetButterflyA.outputPortB)
        else:
            raise ValueError(f"the second element of connectATo must be either 'a', 'A', 'b' or 'B'")
        if targetPortB == 'A' or targetPortB == 'a':
            self.inputPortB.connect(targetButterflyB.outputPortA)
        elif targetPortB == 'B' or targetPortB == 'b':
            self.inputPortB.connect(targetButterflyB.outputPortB)
        else:
            raise ValueError(f"the second element of connectBTo must be either 'a', 'A', 'b' or 'B'")


    def compute(self) -> None:
        '''Run scheme on whichever input mode(s) are populated. If both inputPortA.bound and inputPortB.bound are set, run propagateBound() and write outputPort.bound. If both inputPortA.testVector and inputPortB.testVector are set, run propagateValue() and write outputPort.testVector. Both can run in the same call when both modes are populated.'''
        if self.scheme is None:
            raise ValueError(f"{self.name}: no scheme assigned")
        aBound = self.inputPortA.bound
        bBound = self.inputPortB.bound
        aVec = self.inputPortA.testVector
        bVec = self.inputPortB.testVector

        boundReady = aBound is not None and bBound is not None
        valueReady = aVec is not None and bVec is not None

        if not boundReady and not valueReady:
            raise ValueError(f"{self.name}: both input ports must have either bound or testVector populated before compute")

        if self.twiddle is not None:
            self.scheme.twiddle = self.twiddle
        elif self.twiddlePort is not None:
            self.scheme.twiddle = self.twiddlePort.bound
        else:
            raise ValueError(f"{self.name}: cannot compute scheme as it has no twiddle value or port available")

        if boundReady:
            self.scheme.aIn = aBound
            self.scheme.bIn = bBound
            aOutBound, bOutBound = self.scheme.propagateBound()
            self.outputPortA.bound = aOutBound
            self.outputPortB.bound = bOutBound

        if valueReady:
            self.scheme.aIn = aVec
            self.scheme.bIn = bVec
            # Use the input bound's bitWidth so propagateValue slices on the same
            # hardware-register width that propagateBound assumed; otherwise unreduced
            # results can differ from the predicted range by multiples of q.
            self.scheme.aInBitWidth = aBound.bitWidth if aBound is not None else None
            self.scheme.bInBitWidth = bBound.bitWidth if bBound is not None else None
            aOutVec, bOutVec = self.scheme.propagateValue()
            self.outputPortA.testVector = aOutVec
            self.outputPortB.testVector = bOutVec

        if self.outputPortA.isConnected:
            self.outputPortA.push()
        if self.outputPortB.isConnected:
            self.outputPortB.push()