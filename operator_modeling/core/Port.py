from __future__ import annotations
from abc import ABC, abstractmethod
import warnings
from .IntType import IntType
from .Signal import Signal


class Port(ABC):
    def __init__(self, name: str = 'Undefined Port'):
        self.name: str = name
        self.connectedPort: list[Port] = []

    @property
    def isConnected(self) -> bool:
        return bool(self.connectedPort)

    @abstractmethod
    def connect(self, port: Port) -> bool:
        # common checks for both input and output ports
        # call this method before connecting 
        # use the return value to determine whether to proceed with the connection in the subclass method
        if port is self:
            raise ValueError('Cannot connect a port to itself')
        if port in self.connectedPort:
            warnings.warn(f'The specified port {port.name} is already connected to this port, nothing to connect')
            return False
        return True

    @abstractmethod
    def disconnectPort(self, port: Port) -> bool:
        # common checks for both input and output ports
        # call this method before disconnecting
        # use the return value to determine whether to proceed with the disconnection in the subclass method
        if not self.isConnected:
            warnings.warn('This port is not connected to any port, nothing to disconnect')
            return False
        if port not in self.connectedPort:
            warnings.warn(f'The specified port {port.name} is not connected to this port, nothing to disconnect')
            return False
        return True

    @abstractmethod
    def disconnectPorts(self, ports: list[Port]) -> list[Port]:
        # common checks for both input and output ports
        # call this method before disconnecting
        if not self.isConnected:
            warnings.warn('This port is not connected to any port, nothing to disconnect')
            return []
        if len(ports) == 0:
            warnings.warn('The list of ports to disconnect is empty, nothing to disconnect')
            return []
        portsToDisconnect = [p for p in ports if p in self.connectedPort]
        for p in ports:
            if p not in portsToDisconnect:
                warnings.warn(f'The specified port {p.name} is not connected to this port and will be ignored')        
        if len(portsToDisconnect) == 0:
            warnings.warn('None of the ports specified is connected to this port, nothing to disconnect')
        return portsToDisconnect
    
    @abstractmethod
    def disconnectAllPorts(self) -> bool:
        # common checks for both input and output ports
        # call this method before disconnecting
        if not self.isConnected:
            warnings.warn('This port is not connected to any port, nothing to disconnect')
            return False
        return True


class SignalCarryingPort(Port):
    '''A port whose payload is a single `Signal`, with legacy field access.

    A wire carries a bound and, optionally, a batch of values drawn from it.
    Holding them as one `Signal` rather than two independent fields means the
    pair is replaced whole, so a wire can never sit in a half-updated state
    where the bound has moved on and the values have not.

    `.bound` and `.testVector` remain readable and writable as separate
    attributes, because plenty of code — inside this package and in the
    top-level harnesses — touches them directly. Writing either rebuilds the
    `Signal`, so the two views stay consistent; the immutability belongs to the
    `Signal` object, not to the slot holding it.

    Writing `.bound` on a port with no signal yet creates one. Writing
    `.testVector` first is also allowed, and parks the values against a
    placeholder zero bound until a real one arrives — which mirrors what the
    two separate fields used to permit.
    '''

    def __init__(self, name='Undefined Port', bound: IntType | None = None,
                 testVector: list[int] | None = None):
        super().__init__(name)
        self.signal: Signal | None = None
        if bound is not None or testVector is not None:
            self.signal = Signal(bound if bound is not None else IntType(0, 0, 0),
                                 testVector)

    @property
    def bound(self) -> IntType | None:
        return self.signal.bound if self.signal is not None else None

    @bound.setter
    def bound(self, value: IntType | None) -> None:
        if value is None:
            self.signal = None if self.signal is None else self.signal.withBound(IntType(0, 0, 0))
            return
        self.signal = (Signal(value) if self.signal is None
                       else self.signal.withBound(value))

    @property
    def testVector(self) -> list[int] | None:
        return self.signal.values if self.signal is not None else None

    @testVector.setter
    def testVector(self, value: list[int] | None) -> None:
        self.signal = (Signal(IntType(0, 0, 0), value) if self.signal is None
                       else self.signal.withValues(value))


class SimpleInputPort(SignalCarryingPort):
    def __init__(self, name = 'Undefined Port', bound: IntType | None = None, testVector: list[int] | None = None):
        super().__init__(name, bound, testVector)

    def connect(self, port: Port) -> bool:
        connectionFlag = super().connect(port)
        if not connectionFlag:
            return False
        if isinstance(port, SimpleOutputPort):
            if self.isConnected:
                raise ValueError('Input ports can only be connected to one output port\n ' \
                f'Currently connected to: {self.connectedPort[0].name}\n' \
                'Please disconnect the current connection before connecting to a new port')
            else:
                self.connectedPort.append(port)
                port.connectedPort.append(self)
                return True
        else:
            raise TypeError('Input ports can only be connected to output ports')

    def disconnectPort(self, port: Port) -> bool:
        # the return value of this method is to indicate whether the disconnection is successful
        disconnectionFlag = super().disconnectPort(port)
        if not disconnectionFlag:
            return False
        self.connectedPort.remove(port)
        port.connectedPort.remove(self)
        return True
    
    def disconnectPorts(self, ports: list[Port]) -> list[Port]:
        # the return value of this method is the list of ports that are successfully disconnected
        portsToDisconnect = super().disconnectPorts(ports)
        if not portsToDisconnect:
            return []
        for port in portsToDisconnect:
            self.connectedPort.remove(port)
            port.connectedPort.remove(self)
        return portsToDisconnect
    
    def disconnectAllPorts(self) -> bool:
        # the return value of this method is to indicate whether the disconnection is successful
        disconnectionAllFlag = super().disconnectAllPorts()
        if not disconnectionAllFlag:
            return False
        for port in self.connectedPort:
            port.connectedPort.remove(self)
        self.connectedPort.clear()
        return True
    
    def pull(self, bound: IntType | None = None) -> None:
        # this method is to pull the data type information from the connected output port to this input port
        # if bound is provided, it will be used as the bound for this input port, otherwise the bound of the connected output port will be used
        if bound is not None:
            self.bound = bound
            return
        if not self.isConnected:
            raise ValueError('Cannot pull data type information because this input port is not connected to any output port and no bound was provided')
        if len(self.connectedPort) > 1:
            raise ValueError('Cannot pull data type information because this input port is connected to multiple output ports, please check the connections')
        outputPort = self.connectedPort[0]
        if not isinstance(outputPort, SimpleOutputPort):
            raise TypeError('Connected port is not an output port, cannot pull data type information')
        self.bound = outputPort.bound


class SimpleOutputPort(SignalCarryingPort):
    def __init__(self, name = 'Undefined Port', bound: IntType | None = None, testVector: list[int] | None = None):
        super().__init__(name, bound, testVector)

    def connect(self, port: Port) -> bool:
        connectionFlag = super().connect(port)
        if not connectionFlag:
            return False
        if isinstance(port, SimpleInputPort):
            if port.isConnected:
                raise ValueError('Input ports can only be connected to one output port.\n ' \
                f'Target input port {port.name} is already connected to: {port.connectedPort[0].name}.\n' \
                'Please disconnect that input port before connecting this output port to it.')
            self.connectedPort.append(port)
            port.connectedPort.append(self)
            return True
        else:
            raise TypeError('Output ports can only be connected to input ports')

    def disconnectPort(self, port: Port) -> bool:
        # the return value of this method is to indicate whether the disconnection is successful
        disconnectionFlag = super().disconnectPort(port)
        if not disconnectionFlag:
            return False
        self.connectedPort.remove(port)
        port.connectedPort.remove(self)
        return True
    
    def disconnectPorts(self, ports: list[Port]) -> list[Port]:
        # the return value of this method is the list of ports that are successfully disconnected
        portsToDisconnect = super().disconnectPorts(ports)
        if not portsToDisconnect:
            return []
        for port in portsToDisconnect:
            self.connectedPort.remove(port)
            port.connectedPort.remove(self)
        return portsToDisconnect
    
    def disconnectAllPorts(self) -> bool:
        disconnectionAllFlag = super().disconnectAllPorts()
        if not disconnectionAllFlag:
            return False
        for port in self.connectedPort:
            port.connectedPort.remove(self)
        self.connectedPort.clear()
        return True
    
    def push(self) -> IntType | None:
        '''Copy this port's payload to every input port it drives.

        The whole `Signal` moves at once — bound and values together, either of
        which may be absent. That atomicity is the point: a downstream port can
        never end up holding a fresh bound beside a stale batch of values, which
        is the state that used to arise when the two fields were copied
        independently.
        '''
        if not self.isConnected:
            return self.bound
        for inputPort in self.connectedPort:
            if not isinstance(inputPort, SimpleInputPort):
                raise TypeError('Connected port is not an input port, cannot push data type information')
            inputPort.signal = self.signal
        return self.bound
    