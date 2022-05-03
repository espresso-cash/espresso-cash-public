import 'dart:io' as io;

import 'package:cryptoplease_link/src/handlers/association_handlers.dart';
import 'package:cryptoplease_link/src/handlers/solana_handler.dart';
import 'package:cryptoplease_link/src/tokens.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future<void> main() async {
  final port = int.parse(io.Platform.environment['PORT'] ?? '8080');
  final solanaHandler = createSolanaHandler(tokens: tokens);

  final cascade = Cascade().add(_staticHandler).add(_router).add(solanaHandler);

  final server = await shelf_io.serve(
    logRequests().addHandler(cascade.handler),
    io.InternetAddress.anyIPv4,
    port,
  );

  // ignore: avoid_print, for debugging
  print('Serving at http://${server.address.host}:${server.port}');
}

final _staticHandler = shelf_static.createStaticHandler('public');

final _router = shelf_router.Router()
  ..get('/.well-known/assetlinks.json', assetLinksHandler)
  ..get('/.well-known/apple-app-site-association', appAssociationsHandler);
