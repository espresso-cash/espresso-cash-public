import 'package:connectrpc/http2.dart' if (dart.library.js) 'package:connectrpc/web.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc.dart'
    if (dart.library.js) 'package:connectrpc/protocol/grpc_web.dart'
    as protocol;
import 'package:ec_client_dart/src/grpc/interceptor.dart';

protocol.Transport createTransport({required String baseUrl, String token = ''}) =>
    protocol.Transport(
      baseUrl: baseUrl,
      codec: const ProtoCodec(),
      statusParser: const StatusParser(),
      httpClient: createHttpClient(),
      interceptors: [if (token.isNotEmpty) createAuthInterceptor(token)],
    );
