import 'dart:typed_data';

class SerialPortConfig {
  final int address;
  int baudRate = 0;
  int bits = 8;
  int parity = SerialPortParity.none;
  int stopBits = 1;
  int rts = SerialPortRts.off;
  int cts = SerialPortCts.ignore;
  int dtr = SerialPortDtr.off;
  int dsr = SerialPortDsr.ignore;
  int xonXoff = SerialPortXonXoff.disabled;

  SerialPortConfig(this.address);

  factory SerialPortConfig.fromAddress(int address) =>
      SerialPortConfig(address);

  void dispose() {}
  void setFlowControl(int value) {}
}

abstract class SerialPortBuffer {
  static const int input = 1;
  static const int output = 2;
  static const int both = 3;
}

abstract class SerialPortCts {
  static const int invalid = -1;
  static const int ignore = 0;
  static const int flowControl = 1;
}

abstract class SerialPortDsr {
  static const int invalid = -1;
  static const int ignore = 0;
  static const int flowControl = 1;
}

abstract class SerialPortDtr {
  static const int invalid = -1;
  static const int off = 0;
  static const int on = 1;
  static const int flowControl = 2;
}

abstract class SerialPortEvent {
  static const int rxReady = 1;
  static const int txReady = 2;
  static const int error = 4;
}

abstract class SerialPortFlowControl {
  static const int none = 0;
  static const int xonXoff = 1;
  static const int rtsCts = 2;
  static const int dtrDsr = 3;
}

abstract class SerialPortMode {
  static const int read = 1;
  static const int write = 2;
  static const int readWrite = 3;
}

abstract class SerialPortParity {
  static const int invalid = -1;
  static const int none = 0;
  static const int odd = 1;
  static const int even = 2;
  static const int mark = 3;
  static const int space = 4;
}

abstract class SerialPortRts {
  static const int invalid = -1;
  static const int off = 0;
  static const int on = 1;
  static const int flowControl = 2;
}

abstract class SerialPortSignal {
  static const int cts = 1;
  static const int dsr = 2;
  static const int dcd = 4;
  static const int ri = 8;
}

abstract class SerialPortTransport {
  static const int native = 0;
  static const int usb = 1;
  static const int bluetooth = 2;
}

abstract class SerialPortXonXoff {
  static const int invalid = -1;
  static const int disabled = 0;
  static const int input = 1;
  static const int output = 2;
  static const int inOut = 3;
}

class SerialPortError {
  const SerialPortError();

  @override
  String toString() {
    return super.toString().replaceFirst('OS Error', runtimeType.toString());
  }
}

class SerialPort {
  final String name;
  final int address;
  bool _isOpen = false;
  SerialPortConfig _config;

  SerialPort(this.name)
      : address = 0,
        _config = SerialPortConfig(0);
  SerialPort.fromAddress(this.address)
      : name = '',
        _config = SerialPortConfig(address);

  static List<String> get availablePorts => [];

  void dispose() {}

  bool open({required int mode}) {
    _isOpen = true;
    return _isOpen;
  }

  bool openRead() => open(mode: SerialPortMode.read);
  bool openWrite() => open(mode: SerialPortMode.write);
  bool openReadWrite() => open(mode: SerialPortMode.readWrite);

  bool close() {
    _isOpen = false;
    return !_isOpen;
  }

  bool get isOpen => _isOpen;
  String? get description => 'Serial Port $name';
  int get transport => SerialPortTransport.native;
  int? get busNumber => null;
  int? get deviceNumber => null;
  int? get vendorId => null;
  int? get productId => null;
  String? get manufacturer => null;
  String? get productName => null;
  String? get serialNumber => null;
  String? get macAddress => null;

  SerialPortConfig get config => _config;
  set config(SerialPortConfig config) => _config = config;

  Uint8List read(int bytes, {int timeout = -1}) => Uint8List(bytes);
  int write(Uint8List bytes, {int timeout = -1}) => bytes.length;

  int get bytesAvailable => 0;
  int get bytesToWrite => 0;

  void flush([int buffers = SerialPortBuffer.both]) {}
  void drain() {}

  int get signals => 0;
  bool startBreak() => true;
  bool endBreak() => true;

  static SerialPortError? get lastError => null;
}

class SerialPortReader {
  SerialPortReader(SerialPort port, {int? timeout});
  SerialPort get port => SerialPort("");
  Stream<Uint8List> get stream => Stream<Uint8List>.fromIterable([]);
  void close() {}
}
