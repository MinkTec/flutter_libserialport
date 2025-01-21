export 'package:libserialport/libserialport.dart'
  if (dart.library.html) './flutter_libserialport_web.dart'
  if (dart.library.io) 'package:libserialport/libserialport.dart';
