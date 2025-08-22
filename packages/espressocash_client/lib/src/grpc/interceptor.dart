import 'package:connectrpc/connect.dart';

Interceptor createAuthInterceptor(String token) =>
    <I extends Object, O extends Object>(next) => (req) {
      req.headers['Authorization'] = 'Bearer $token';

      return next(req);
    };
