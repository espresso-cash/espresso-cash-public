import 'package:cryptoplease_link/src/handlers/common_link_handler.dart';
import 'package:dfunc/dfunc.dart';
import 'package:shelf/shelf.dart';

Future<Response> Function(Request) createSolanaHandler({
  required Map<String, String> tokens,
}) =>
    (Request request) async {
      final host = request.requestedUri.host;
      if (host == 'solana1.cryptoplease.link' ||
          host == 'solana2.cryptoplease.link') {
        return _solanaShareableHandler(request);
      } else if (host == 'solanapay.cryptoplease.link') {
        return _solanaPayHandler(request, tokens);
      }

      return Response.badRequest(body: 'Wrong host');
    };

Future<Response> _solanaShareableHandler(Request request) => commonHandler(
      request,
      templateName: 'solana-shareable',
      updateData: identity,
    );

Future<Response> _solanaPayHandler(
  Request request,
  Map<String, String> tokens,
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
      'recipient': request.url.path.replaceAll('/', ''),
    },
  );
}
