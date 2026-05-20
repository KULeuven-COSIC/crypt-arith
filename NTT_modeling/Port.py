from __future__ import annotations
from abc import ABC, abstractmethod
import warnings
from .IntType import IntType


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


class SimpleInputPort(Port):
    def __init__(self, name = 'Undefined Port', bound: IntType | None = None, testVector: list[int] | None = None):
        super().__init__(name)
        self.bound: IntType | None = bound
        self.testVector: list[int] | None = testVector

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


class SimpleOutputPort(Port):
    def __init__(self, name = 'Undefined Port', bound: IntType | None = None, testVector: list[int] | None = None):
        super().__init__(name)
        self.bound: IntType | None = bound
        self.testVector: list[int] | None = testVector

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
        # this method is to push the data type information from this output port to the connected input port; also propagates testVector for value-batch mode (each downstream input port gets both bound and testVector copied; either may be None)
        if not self.isConnected:
            return self.bound
        for inputPort in self.connectedPort:
            if not isinstance(inputPort, SimpleInputPort):
                raise TypeError('Connected port is not an input port, cannot push data type information')
            inputPort.bound = self.bound
            inputPort.testVector = self.testVector
        return self.bound
    