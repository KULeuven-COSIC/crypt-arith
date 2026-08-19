from __future__ import annotations
import random
from math import log2
from .Butterfly import Butterfly
from .ButterflyScheme import ButterflyScheme
from .NTTScheme import (FullyPipelinedGrid, NTTScheme, butterflyToMems,
                        memToButterfly)
from ..core.Operator import Operator
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.utils import bitReverse
from ..core.IntType import IntType

# versal_arith path was added to sys.path by the .ButterflyScheme import above
# (see ButterflyScheme.py for the on-demand append). Both the
# pipeline spec dataclass and the rtl_gen ntt generator are imported through it.
from ntt_spec import NTTOperatorSpec, InterStageWire




class FullyPipelinedNTT(Operator):
    '''An NTT pipeline: natural-order inputs and outputs over a butterfly network.

    The network itself belongs to the **scheme** (`FullyPipelinedGrid`), which
    builds it, wires it, and owns the stride and bit-reversal rules. This class
    is the operator around it: natural-order I/O, the spec, and RTL emission.

    That split is what lets a second architecture exist. A four-step or
    iterative NTT is a different `NTTScheme`, not a different class here.

    The constructor is unchanged, and so is `setScheme` — but `setScheme` is now
    for *overriding* the butterfly schemes, not for supplying them. The grid
    builds its own, which removes the identical `log2(n) x n/2` comprehension
    that every caller used to write out by hand.
    '''

    def __init__(self, name: str, n: int, q: int, butterflyType: str, twiddles: list[list[int | list[tuple[int, int]]]], negacyclic: bool = False,
                 scheme: 'NTTScheme | None' = None):
        super().__init__(name)
        self.scheme = scheme if scheme is not None else FullyPipelinedGrid(
            name=name, n=n, q=q, butterflyType=butterflyType,
            twiddles=twiddles, negacyclic=negacyclic)
        # Validation now lives in NTTScheme.__init__, which raises on a bad n,
        # q, butterflyType or twiddles shape before any grid is built.
        self._buildPortTables()

    # ------------------------------------------------------------------
    # Natural-order port tables
    # ------------------------------------------------------------------

    def _buildPortTables(self) -> None:
        '''Work out, once, which butterfly port each natural index reaches.

        Two steps, both of which the scheme already knows how to answer:
        turn the natural index into a memory slot (`inputNaturalToMemory` —
        bit-reversed for CT, identity for GS), then turn the memory slot into a
        butterfly and a port letter (`memToButterfly` at the scheme's boundary
        stride). For n = 8:

            GS                                  CT
            x[0] -> mem 0 -> butterfly 0 A      x[0] -> mem 0 -> butterfly 0 A
            x[1] -> mem 1 -> butterfly 1 A      x[1] -> mem 4 -> butterfly 2 A
            x[4] -> mem 4 -> butterfly 0 B      x[4] -> mem 1 -> butterfly 0 B

        That answer used to be re-derived from scratch in five places here and
        one in `verification`, each re-deriving the stride and re-applying the
        bit reversal. Now it is a list, and those places read the list. The
        scheme's four topology methods, which nothing called, are what build it.
        '''
        n = self.n
        L = len(self.butterflies)
        scheme = self.scheme

        self._inputPortsNatural: list = [None] * n
        self._outputPortsNatural: list = [None] * n
        # Per stage-0 / final-stage butterfly, the natural index on each port.
        # This is exactly what the RTL spec's inputWiring / outputWiring are.
        self._inputWiring: list[list[int | None]] = [[None, None] for _ in range(n // 2)]
        self._outputWiring: list[list[int | None]] = [[None, None] for _ in range(n // 2)]

        # Memory order too, because `getInputs` / `getOutputs` are indexed that
        # way. Same ports, different index; both tables are views on the grid.
        self._inputPortsMemory: list = [None] * n
        self._outputPortsMemory: list = [None] * n

        inStride = scheme.inputStride()
        for i in range(n):
            m = scheme.inputNaturalToMemory(i)
            p, side = memToButterfly(m, inStride)
            bfly = self.butterflies[0][p]
            port = bfly.inputPortA if side == 'A' else bfly.inputPortB
            self._inputPortsNatural[i] = port
            self._inputPortsMemory[m] = port
            self._inputWiring[p][0 if side == 'A' else 1] = i

        # The scheme gives memory -> natural on the output side; invert it
        # explicitly rather than leaning on bitReverse being its own inverse.
        naturalOfMemory = [scheme.outputMemoryToNatural(m) for m in range(n)]
        if sorted(naturalOfMemory) != list(range(n)):
            raise ValueError(
                f'{self.name}: scheme.outputMemoryToNatural is not a permutation'
            )
        memoryOfNatural = [0] * n
        for m, k in enumerate(naturalOfMemory):
            memoryOfNatural[k] = m

        outStride = scheme.outputStride()
        for k in range(n):
            m = memoryOfNatural[k]
            p, side = memToButterfly(m, outStride)
            bfly = self.butterflies[L - 1][p]
            port = bfly.outputPortA if side == 'A' else bfly.outputPortB
            self._outputPortsNatural[k] = port
            self._outputPortsMemory[m] = port
            self._outputWiring[p][0 if side == 'A' else 1] = k

        for i, port in enumerate(self._inputPortsNatural):
            if port is None:
                raise ValueError(f'{self.name}: natural input {i} reaches no port')
        for k, port in enumerate(self._outputPortsNatural):
            if port is None:
                raise ValueError(f'{self.name}: natural output {k} reaches no port')

    @property
    def inputPorts(self) -> list:
        '''The stage-0 butterfly input ports, in natural order x[0]..x[n-1].

        These are the butterflies' own ports, not copies — so connecting an
        upstream operator here and calling its `compute()` drives the pipeline
        directly, with nothing to copy across afterwards.
        '''
        return list(self._inputPortsNatural)

    @property
    def outputPorts(self) -> list:
        '''The final-stage butterfly output ports, in natural order.'''
        return list(self._outputPortsNatural)

    # The scheme is the single source of truth for topology; these read through
    # to it so existing callers — including three that index `inst.butterflies`
    # directly — keep working unchanged.
    @property
    def butterflies(self) -> list[list[Butterfly]]:
        return self.scheme.butterflies

    @property
    def n(self) -> int:
        return self.scheme.n

    @property
    def q(self) -> int:
        return self.scheme.q

    @property
    def butterflyType(self) -> str:
        return self.scheme.butterflyType

    @property
    def twiddles(self):
        return self.scheme.twiddles

    @property
    def negacyclic(self) -> bool:
        return self.scheme.negacyclic

    def _drivePorts(self, ports: list, values, label: str) -> None:
        '''Write a list of bounds or of value batches onto `ports`, positionally.

        The single place either index order lands on the grid; `getInputs` hands
        it the memory-order table and `getInputsNatural` the natural-order one.
        '''
        if not isinstance(values, list):
            raise TypeError(f'{label} must be a list, got {type(values)}')
        if len(values) != self.n:
            raise ValueError(f'{label} must have length n={self.n}, got {len(values)}')

        if all(isinstance(v, list) for v in values):
            batchSize = len(values[0]) if values else 0
            if any(len(v) != batchSize for v in values):
                raise ValueError('all test-vector batches must have the same length; got mixed lengths in inputs')
            for v in values:
                if not all(isinstance(e, int) for e in v):
                    raise TypeError('all elements of a test-vector batch must be int')
            for port, v in zip(ports, values):
                port.testVector = v
        elif all(isinstance(v, IntType) for v in values):
            for port, v in zip(ports, values):
                port.bound = v
        else:
            raise TypeError('inputs must be either list[IntType] or list[list[int]]')

    def getInputs(self, inputs: list[IntType] | list[list[int]]) -> None:
        '''Drive the first-stage butterfly input ports from `inputs`. The list is indexed by NTT memory position, in the layout the chosen scheme expects: bit-reversed natural order for CT (e.g. n=8: [x[0], x[4], x[2], x[6], x[1], x[5], x[3], x[7]]) and natural order for GS (e.g. n=8: [x[0], x[1], ..., x[7]]). Each first-stage butterfly's two memory slots are looked up via butterflyToMems and pulled from `inputs`.'''
        self._drivePorts(self._inputPortsMemory, inputs, 'inputs')

    def getInputsNatural(self, x: list[IntType] | list[list[int]]) -> None:
        '''Drive the first-stage inputs from a list given in NATURAL order x[0], x[1], ..., x[n-1]. Auto-permutes into the pipeline's memory layout: bit-reverses for CT (which expects bit-reversed memory at input) or passes through for GS (already natural at input).'''
        self._drivePorts(self._inputPortsNatural, x, 'x')

    def getOutputsNatural(self) -> list[IntType] | list[list[int]]:
        '''Return the final-stage outputs in NATURAL order Y[0], Y[1], ..., Y[n-1] (or x[0], ..., x[n-1] for INTT). Auto-permutes from the pipeline's memory layout: pass-through for CT (output is already natural) or bit-reverses for GS (output is bit-reversed in memory).'''
        return [p.bound if p.bound is not None else p.testVector
                for p in self._outputPortsNatural]

    def setScheme(self, schemes: list[list[ButterflyScheme]]) -> None:
        '''Attach a ButterflyScheme to every butterfly. `schemes` is shaped log2(n) x n/2, mirroring the butterfly grid: schemes[layerIndex][butterflyIndex] is assigned to self.butterflies[layerIndex][butterflyIndex].scheme.'''
        if not isinstance(schemes, list):
            raise TypeError(f'schemes must be a list of layer lists, got {type(schemes)}')
        L = len(self.butterflies)
        if len(schemes) != L:
            raise ValueError(f'schemes must have {L} layers (log2(n)), got {len(schemes)}')
        halfN = self.n // 2
        for layerIndex, layer in enumerate(schemes):
            if not isinstance(layer, list):
                raise TypeError(f'schemes[{layerIndex}] must be a list, got {type(layer)}')
            if len(layer) != halfN:
                raise ValueError(f'schemes[{layerIndex}] must have n/2={halfN} entries, got {len(layer)}')
            for butterflyIndex, scheme in enumerate(layer):
                if not isinstance(scheme, ButterflyScheme):
                    raise TypeError(f'schemes[{layerIndex}][{butterflyIndex}] must be a ButterflyScheme, got {type(scheme)}')
                self.butterflies[layerIndex][butterflyIndex].scheme = scheme

    def compute(self) -> None:
        '''Walk the pipeline stage by stage, calling each butterfly's compute(). Each butterfly pulls input bounds from its input ports (driven by getInputs() for stage 0, or by upstream butterflies' compute() pushes for later stages), runs its scheme, and pushes its output bounds onto downstream input ports. By the time stage s runs, stage s-1 has already populated all stage-s input ports.'''
        for layer in self.butterflies:
            for bfly in layer:
                bfly.compute()

    def getOutputs(self) -> list[IntType] | list[list[int]]:
        '''Return the final-layer outputs in NTT memory-position order. Mirror of getInputs: outputs[m] is the value at memory slot m. Auto-dispatches per-port: if outputPort.bound is set it's used; otherwise outputPort.testVector. Result is None for any slot whose owning butterfly has not had compute() run yet. Return type is list[IntType] in bound mode and list[list[int]] in value-batch mode (mixed populations follow per-port).'''
        return [p.bound if p.bound is not None else p.testVector
                for p in self._outputPortsMemory]

    def showBounds(self) -> None:
        '''Print a per-stage summary of output bounds: max bitWidth across the stage's butterflies, plus a representative IntType (the widest one). Quick at-a-glance view of how bounds evolve through the pipeline. Run after compute().'''
        print(f'=== Bounds for {self.name} (n={self.n}, {self.butterflyType}) ===')
        for s, layer in enumerate(self.butterflies):
            widest: IntType | None = None
            maxWidth = -1
            for bfly in layer:
                for bound in (bfly.outputPortA.bound, bfly.outputPortB.bound):
                    if bound is None:
                        continue
                    if bound.bitWidth > maxWidth:
                        maxWidth = bound.bitWidth
                        widest = bound
            if widest is None:
                print(f'Layer {s}: <no bounds — has compute() been run?>')
            else:
                print(f'Layer {s}: max bitWidth = {maxWidth}, e.g. {widest}')

    def saveBoundsToXlsx(self, path: str = 'NTT_bounds.xlsx', sheetName: str | None = None) -> None:
        '''Record the full per-butterfly per-stage output bound table to xlsx. Layout: row 1 holds "Layer 1".."Layer L" headers plus a trailing "<TYPE> BOUNDS" label; rows 2..n+1 hold per-port bounds in physical order (butterfly p port A on row 2+2p, port B on row 3+2p). Each cell contains str(bound) using IntType.__str__. Sheet name defaults to self.name so multiple NTT instances can record to the same workbook without colliding. If the file exists, the named sheet is replaced and other sheets are preserved; otherwise a new workbook is created.'''
        from ..core.utils import saveXlsxSheet
        if sheetName is None:
            sheetName = self.name
        L = len(self.butterflies)

        headers = [f'Layer {i + 1}' for i in range(L)] + [f'{self.butterflyType} BOUNDS']
        rows: list[list[str]] = []
        for p in range(self.n // 2):
            aRow, bRow = [], []
            for layerIdx in range(L):
                bfly = self.butterflies[layerIdx][p]
                aBound = bfly.outputPortA.bound
                bBound = bfly.outputPortB.bound
                aRow.append(str(aBound) if aBound is not None else '')
                bRow.append(str(bBound) if bBound is not None else '')
            rows.append(aRow)
            rows.append(bRow)

        saveXlsxSheet(path, sheetName, rows, headers=headers)

    def getOperatorInterface(self, name: str) -> NTTOperatorSpec:
        '''Build an NTTOperatorSpec describing the entire pipeline at RTL granularity.

        Walks the populated grid (compute() must already have been run with input
        bounds loaded so every input/output port has a bound), invokes each
        butterfly's scheme.getOperatorInterface to get its ButterflyOperatorSpec,
        and precomputes the wiring tables that map natural-order x[i] inputs to
        first-stage butterfly ports (inputWiring), inter-layer connections
        (interStageWiring via butterflyToMems + memToButterfly), and final-stage
        butterfly ports back to natural-order y[i] outputs (outputWiring).

        Per-butterfly module names are namespaced by the NTT's top name as
        <name>_btf_L<s>_p<p>, so two NTT instances with the same n /
        butterflyType but different `name` produce non-colliding butterfly
        modules — required when integrating multiple NTTs into one Vivado
        project. The short `btf` abbreviation (vs full `Butterfly`) keeps
        the resulting module + instance identifiers short enough to dodge a
        Vivado xelab false-positive multi-driver bug that fires on full
        449-butterfly elaboration when individual identifiers grow past
        ~50 characters. Standalone build_butterfly.py keeps its own
        Butterfly_n<N>_<TYPE>_L<s>_p<p> shape — single-module compiles do
        not trigger that pathology.

        Consumed by versal_arith.rtl_gen.ntt.NTT_RTL_gen, which composes the
        per-butterfly RTL into a full pipeline wrapper.
        '''
        n = self.n
        L = len(self.butterflies)
        if L != int(log2(n)):
            raise ValueError(f'butterfly grid layer count {L} does not match log2(n)={int(log2(n))}')
        for s in range(L):
            if len(self.butterflies[s]) != n // 2:
                raise ValueError(f'butterflies[{s}] has {len(self.butterflies[s])} entries, expected {n // 2}')

        # Per-natural-input widths come from each stage-0 butterfly port's bound. Filled
        # below after `inputWiring` is computed. Each stage-0 butterfly's two input ports
        # must have a bound set (by getInputsNatural + compute()).
        for p in range(n // 2):
            for portName, port in (('A', self.butterflies[0][p].inputPortA),
                                   ('B', self.butterflies[0][p].inputPortB)):
                if port.bound is None:
                    raise ValueError(f'butterflies[0][{p}].inputPort{portName}.bound is None — call compute() with bounds first')

        # Per-butterfly ButterflyOperatorSpec collection.
        butterflySpecs: list[list] = []
        for s in range(L):
            layerSpecs = []
            for p in range(n // 2):
                bfly = self.butterflies[s][p]
                if bfly.scheme is None:
                    raise ValueError(f'butterflies[{s}][{p}].scheme is None — call setScheme() before getOperatorInterface()')
                if bfly.inputPortA.bound is None or bfly.inputPortB.bound is None:
                    raise ValueError(f'butterflies[{s}][{p}].inputPort{{A,B}}.bound is None — call compute() with bounds first')
                # The scheme's aIn/bIn may have been left as testVectors by the last compute()
                # call (when both bounds and values were loaded). Reset to bounds so
                # getOperatorInterface inspects the right state.
                bfly.scheme.aIn = bfly.inputPortA.bound
                bfly.scheme.bIn = bfly.inputPortB.bound
                if bfly.twiddle is not None:
                    bfly.scheme.twiddle = bfly.twiddle
                elif bfly.twiddlePort is not None:
                    bfly.scheme.twiddle = bfly.twiddlePort.bound
                else:
                    raise ValueError(f'butterflies[{s}][{p}] has no twiddle assigned')
                butterflyName = f'{name}_btf_L{s}_p{p}'
                layerSpecs.append(bfly.scheme.getOperatorInterface(name=butterflyName))
            butterflySpecs.append(layerSpecs)

        # Stage-0 and final-stage routing in natural-order space, straight off
        # the tables built in `_buildPortTables` — the same tables `inputPorts` /
        # `outputPorts` expose, so the spec and the port view can never disagree
        # about which natural index sits on which butterfly port. Widths are read
        # per natural index from that index's own port, assuming no uniformity.
        inputWiring: list[tuple[int, int]] = [tuple(w) for w in self._inputWiring]
        inputBitWidthsNatural: list[int] = [0] * n
        inputIsSignedNatural: list[bool] = [False] * n
        for i, port in enumerate(self._inputPortsNatural):
            inputBitWidthsNatural[i] = port.bound.bitWidth
            inputIsSignedNatural[i] = port.bound.isSigned

        outputWiring: list[tuple[int, int]] = [tuple(w) for w in self._outputWiring]
        outputBitWidthsNatural: list[int] = [0] * n
        outputIsSignedNatural: list[bool] = [False] * n
        for k, port in enumerate(self._outputPortsNatural):
            if port.bound is None:
                raise ValueError(
                    f'natural output {k} has no bound — call compute() with bounds first'
                )
            outputBitWidthsNatural[k] = port.bound.bitWidth
            outputIsSignedNatural[k] = port.bound.isSigned

        # Inter-stage wiring for layers 1..L-1. Replicates the connection logic from
        # FullyPipelinedNTT.__init__ (see NTT.py:299-323): use this layer's stride
        # to find the butterfly's memory positions, then the previous layer's
        # stride to find which upstream butterfly+port produced each position.
        interStageWiring: list[list[tuple[InterStageWire, InterStageWire]]] = []
        for s in range(1, L):
            if self.butterflyType == 'CT':
                strideThis = 1 << s
                stridePrev = strideThis >> 1
            else:
                strideThis = 1 << (L - s - 1)
                stridePrev = strideThis << 1
            layerWiring: list[tuple[InterStageWire, InterStageWire]] = []
            for p in range(n // 2):
                mA, mB = butterflyToMems(p, strideThis)
                pA, portA = memToButterfly(mA, stridePrev)
                pB, portB = memToButterfly(mB, stridePrev)
                layerWiring.append((InterStageWire(src_p=pA, src_port=portA),
                                    InterStageWire(src_p=pB, src_port=portB)))
            interStageWiring.append(layerWiring)

        return NTTOperatorSpec(
            name=name,
            n=n,
            butterflyType=self.butterflyType,
            negacyclic=self.negacyclic,
            q=self.q,
            butterflySpecs=butterflySpecs,
            inputBitWidthsNatural=inputBitWidthsNatural,
            inputIsSignedNatural=inputIsSignedNatural,
            outputBitWidthsNatural=outputBitWidthsNatural,
            outputIsSignedNatural=outputIsSignedNatural,
            inputWiring=inputWiring,
            outputWiring=outputWiring,
            interStageWiring=interStageWiring,
        )

    def _extractGoldensNatural(self) -> tuple[list[list[int]], list[list[int]]]:
        '''Walk the populated grid and return (goldenXNatural, goldenYNatural),
        each shape (testSize x n). Inputs come from stage-0 input ports'
        testVector (set by getInputsNatural([batches])); outputs come from
        final-layer output ports' testVector (set by compute()). The
        natural ↔ memory permutation reuses the same mapping that
        getInputsNatural / getOutputsNatural use. Precondition: every relevant
        port has a testVector populated (call getInputsNatural([list[int]]*n)
        and compute() before invoking this).'''
        n = self.n
        inputByNatural = [p.testVector for p in self._inputPortsNatural]
        outputByNatural = [p.testVector for p in self._outputPortsNatural]

        for i in range(n):
            if inputByNatural[i] is None:
                raise ValueError(
                    f'natural-input index {i}: stage-0 butterfly port has no testVector. '
                    f'Call getInputsNatural([list[int]]*n) + compute() before emitRtl.'
                )
            if outputByNatural[i] is None:
                raise ValueError(
                    f'natural-output index {i}: final-layer butterfly port has no testVector. '
                    f'Call compute() with values loaded before emitRtl.'
                )

        testSize = len(inputByNatural[0])
        for i in range(n):
            if len(inputByNatural[i]) != testSize:
                raise ValueError(
                    f'inconsistent batch length on natural-input index {i}: '
                    f'len={len(inputByNatural[i])}, expected {testSize}'
                )
            if len(outputByNatural[i]) != testSize:
                raise ValueError(
                    f'inconsistent batch length on natural-output index {i}: '
                    f'len={len(outputByNatural[i])}, expected {testSize}'
                )

        goldenXNatural = [[inputByNatural[i][b] for i in range(n)] for b in range(testSize)]
        goldenYNatural = [[outputByNatural[i][b] for i in range(n)] for b in range(testSize)]
        return goldenXNatural, goldenYNatural

    # --- Operator contract ------------------------------------------------

    def areaCost(self) -> tuple[int, int]:
        '''`(LUT, DSP)` summed over the grid, via the scheme.'''
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        '''Pipeline registers between the natural inputs and outputs.'''
        return self.scheme.latency(pipelineStages)

    # `Operator.emitRtl`'s template does not fit this operator: it passes a
    # single `pipeline_stages` int where an NTT needs one per layer, and it
    # samples its own test data where an NTT takes goldens from the already
    # populated grid. `emitRtl` below overrides it, so these three hooks exist
    # only to satisfy the ABC and should never be reached.

    def _generatorTarget(self) -> tuple[str, str, str]:
        raise NotImplementedError(
            f'{self.name}: the NTT emits through its own emitRtl, which takes '
            f'pipeline_stages_per_layer; the Operator template does not apply.'
        )

    def _prepareTestData(self, spec, test_size: int, seed: int | None,
                         **kwargs) -> dict:
        raise NotImplementedError(
            f'{self.name}: NTT goldens come from the populated grid via '
            f'_extractGoldensNatural, not from sampling here.'
        )

    def _generatorKwargs(self, data: dict) -> dict:
        raise NotImplementedError(
            f'{self.name}: the NTT emits through its own emitRtl.'
        )

    def emitRtl(self,
                topName: str,
                run_dir,
                pipeline_stages_per_layer = 1,
                gen_testbench: bool = True,
                visualization: bool = False,
                sanity_check_size: int = 8,
                backend: str = 'hw') -> dict:
        '''Emit RTL for the entire NTT/INTT pipeline. Precondition: setScheme
        was called, getInputsNatural([bounds]) + compute() populated the bound
        path. When gen_testbench=True, also requires getInputsNatural([batches])
        + compute() so every input/output port has a testVector — the goldens
        come from the populated instance, not internal sampling.

        `pipeline_stages_per_layer` is either an int (broadcast to every layer)
        or a list of length log2(n).

        `backend` selects the RTL flavor:
          - 'hw'  (default): optimized Versal compressor-tree generator
            (`rtl_gen.ntt.NTT_RTL_gen`). Per-butterfly `.sv` files, full
            `xdc_generated/` directory, bit-heap intermediate `.txt` files.
          - 'sim': behavioral simulation-only generator
            (`sim_rtl_gen.ntt.NTT_SimRTL_gen`). All butterfly modules
            concatenated into a single `<topName>_butterflies.sv`; no
            `xdc_generated/`, no bit-heap files. Testvectors are
            byte-identical to the hw backend.

        Files land in `<run_dir>/RTL_generated/`, `<run_dir>/xdc_generated/`
        (hw only), `<run_dir>/testvectors/` (when gen_testbench),
        `<run_dir>/manifest.json`.

        A local sanity check (off when sanity_check_size <= 0) round-trips the
        first `sanity_check_size` testvector lines to confirm the on-disk hex
        matches what propagateValue produces.'''
        import os as _os
        from pathlib import Path as _Path

        L = len(self.butterflies)
        if isinstance(pipeline_stages_per_layer, int):
            pipeline_stages_per_layer = [pipeline_stages_per_layer] * L
        if len(pipeline_stages_per_layer) != L:
            raise ValueError(
                f'pipeline_stages_per_layer must have length log2(n)={L}, '
                f'got {len(pipeline_stages_per_layer)}'
            )

        run_dir = _Path(run_dir)
        run_dir.mkdir(parents=True, exist_ok=True)

        spec = self.getOperatorInterface(name=topName)

        goldenXNatural = None
        goldenYNatural = None
        testSize = 0
        if gen_testbench:
            goldenXNatural, goldenYNatural = self._extractGoldensNatural()
            testSize = len(goldenXNatural)

        if backend == 'sim':
            from sim_rtl_gen.ntt import NTT_SimRTL_gen as _gen
        elif backend == 'hw':
            from rtl_gen.ntt import NTT_RTL_gen as _gen
        else:
            raise ValueError(f"backend must be 'hw' or 'sim', got {backend!r}")

        saved = _os.getcwd()
        _os.chdir(str(run_dir))
        try:
            manifest = _gen(
                spec=spec,
                pipeline_stages_per_layer=list(pipeline_stages_per_layer),
                gen_testbench=gen_testbench,
                test_size=testSize,
                visualization=visualization,
                golden_x_natural=goldenXNatural,
                golden_y_natural=goldenYNatural,
            )
        finally:
            _os.chdir(saved)

        if gen_testbench and sanity_check_size > 0:
            _sanityCheckNttTestvectors(self, run_dir, spec, sanity_check_size)

        return manifest


def _sanityCheckNttTestvectors(inst: 'FullyPipelinedNTT', run_dir, spec, sample_size: int = 8) -> None:
    '''Decode the first `sample_size` lines of x_in.txt and y_out.txt, drive
    the decoded x batch through the populated instance, and confirm each
    natural-output slot matches mod 2^slot_width. Catches twos-complement
    encoding bugs locally before any remote sim. Mirrors
    `scripts/build_ntt.py::sanity_check_ntt`.'''
    from pathlib import Path as _Path
    n = inst.n
    L = len(inst.butterflies)
    inWidths = list(spec.inputBitWidthsNatural)
    inSigned = list(spec.inputIsSignedNatural)
    outWidths = list(spec.outputBitWidthsNatural)
    tv = _Path(run_dir) / 'testvectors'

    def _readHex(path, nLines):
        with path.open() as f:
            return [int(line.strip(), 16) for _, line in zip(range(nLines), f) if line.strip()]

    xPacked = _readHex(tv / 'x_in.txt', sample_size)
    yPacked = _readHex(tv / 'y_out.txt', sample_size)
    nLines = min(len(xPacked), len(yPacked))
    if nLines == 0:
        raise RuntimeError('emitRtl sanity-check: no testvectors loaded from disk')

    def _decodePerSlotSigned(packed):
        out = []
        offset = 0
        for w, signed in zip(inWidths, inSigned):
            v = (packed >> offset) & ((1 << w) - 1)
            if signed and (v >> (w - 1)):
                v -= (1 << w)
            out.append(v)
            offset += w
        return out

    def _decodePerSlotUnsigned(packed):
        out = []
        offset = 0
        for w in outWidths:
            v = (packed >> offset) & ((1 << w) - 1)
            out.append(v)
            offset += w
        return out

    xDecoded = [_decodePerSlotSigned(p) for p in xPacked[:nLines]]
    yDecoded = [_decodePerSlotUnsigned(p) for p in yPacked[:nLines]]

    inputBoundsByNatural = [p.bound for p in inst.inputPorts]

    nInputs = [[xDecoded[b][i] for b in range(nLines)] for i in range(n)]
    inst.getInputsNatural(inputBoundsByNatural)
    inst.getInputsNatural(nInputs)
    inst.compute()

    pipelineOutNatural = [p.testVector for p in inst.outputPorts]

    mismatches = 0
    for b in range(nLines):
        for i in range(n):
            expected = pipelineOutNatural[i][b] & ((1 << outWidths[i]) - 1)
            actual = yDecoded[b][i]
            if expected != actual:
                mismatches += 1
                if mismatches <= 5:
                    print(f'[emitRtl] sanity-check mismatch batch={b} idx={i}: '
                          f'expected {expected:x}, got {actual:x}')
    if mismatches > 0:
        raise RuntimeError(
            f'emitRtl sanity-check FAILED: {mismatches} mismatches out of '
            f'{nLines * n} slots — twos-complement encoding bug?'
        )
    print(f'[emitRtl] sanity-check OK: {nLines} batches × {n} slots = {nLines * n} OK')


class FullyPipelinedINTT(FullyPipelinedNTT):
    '''Inverse fully-pipelined NTT. Identical to FullyPipelinedNTT in wiring, scheme attachment, compute pipeline, and output reporting; the inverse-ness lives entirely in the twiddles passed in (use calculateInttTwiddles to generate them with w^(-1) or psi^(-1) as the base). The 1/n scaling factor at the end of the inverse transform is intentionally omitted here; apply it externally if needed.'''
    pass
