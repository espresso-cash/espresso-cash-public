export 'eth_unsupported.dart'
    if (dart.library.ffi) 'eth_native.dart'
    if (dart.library.html) 'eth_web.dart';
