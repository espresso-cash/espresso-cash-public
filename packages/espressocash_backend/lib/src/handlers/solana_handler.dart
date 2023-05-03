import 'package:dfunc/dfunc.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/handlers/common_link_handler.dart';
import 'package:shelf/shelf.dart';

Future<Response> Function(Request) createSolanaHandler({
  required Map<String, String> tokens,
  required String network,
}) =>
    (Request request) async {
      final host = request.requestedUri.host;
      if (host == link1Host ||
          host == link2Host ||
          host == espressocashLinkHost) {
        return _solanaShareableHandler(request);
      } else if (host == solanaPayHost || host == solanaPayEspressoCashHost) {
        return _solanaPayHandler(request, tokens, network);
      }

      return Response.notFound(null);
    };

Future<Response> _solanaShareableHandler(Request request) => commonHandler(
      request,
      templateName: 'solana-shareable',
      updateData: identity,
    );

Future<Response> _solanaPayHandler(
  Request request,
  Map<String, String> tokens,
  String network,
) {
  final tokenParam = request.url.queryParameters['spl-token'];
  final token = tokenParam == null ? 'SOL' : tokens[tokenParam] ?? '';

  final amount = request.url.queryParameters['amount'];

  return commonHandler(
    request,
    templateName: 'solana-pay',
    updateData: (data) => <String, dynamic>{
      ...data,
      'token': token,
      'amount': amount,
      'network': network,
      'recipient': request.url.path.replaceAll('/', ''),
    },
  );
}
