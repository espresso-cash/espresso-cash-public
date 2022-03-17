export 'open_connection_unsupported.dart'
    if (dart.library.ffi) 'open_connection_native.dart'
    if (dart.library.html) 'open_connection_web.dart';
