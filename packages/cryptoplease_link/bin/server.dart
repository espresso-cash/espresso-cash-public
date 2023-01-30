import 'dart:io' as io;

import 'package:cryptoplease_link/src/handlers/association_handlers.dart';
import 'package:cryptoplease_link/src/handlers/solana_handler.dart';
import 'package:cryptoplease_link/src/moonpay/handler.dart';
import 'package:cryptoplease_link/src/payments/handler.dart';
import 'package:cryptoplease_link/src/swap/handler.dart';
import 'package:cryptoplease_link/src/tokens.dart';
import 'package:sentry/sentry.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future<void> main() async {
  await Sentry.init((options) {
    options
      ..dsn = io.Platform.environment['SENTRY_DSN']
      ..tracesSampleRate = 1.0;
  });

  final port = int.parse(io.Platform.environment['PORT'] ?? '8080');
  final network = io.Platform.environment['SOLANA_RPC_URL'] ?? '';
  final solanaHandler = createSolanaHandler(tokens: tokens, network: network);

  final errorReporter = createMiddleware(
    errorHandler: (error, stacktrace) async {
      await Sentry.captureException(error, stackTrace: stacktrace);
      Error.throwWithStackTrace(error, stacktrace);
    },
  );

  final cascade = Cascade() //
      .add(_staticHandler)
      .add(_apiV1)
      .add(_wellKnown)
      .add(solanaHandler);

  final server = await shelf_io.serve(
    logRequests().addMiddleware(errorReporter).addHandler(cascade.handler),
    io.InternetAddress.anyIPv4,
    port,
  );

  // ignore: avoid_print, for debugging
  print('Serving at http://${server.address.host}:${server.port}');
}

final _staticHandler = shelf_static.createStaticHandler('public');

final _wellKnown = shelf_router.Router()
  ..get('/.well-known/assetlinks.json', assetLinksHandler)
  ..get('/.well-known/apple-app-site-association', appAssociationsHandler);

final _apiV1 = shelf_router.Router()
  ..mount(
    '/api/v1',
    Cascade() //
        .add(paymentHandler())
        .add(addFundsHandler())
        .add(addSwapHandler())
        .handler,
  );
