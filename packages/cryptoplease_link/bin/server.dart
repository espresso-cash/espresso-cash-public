import 'dart:io' as io;

import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/handlers/association_handlers.dart';
import 'package:cryptoplease_link/src/handlers/moonpay_handler.dart';
import 'package:cryptoplease_link/src/handlers/solana_handler.dart';
import 'package:cryptoplease_link/src/payments/handler.dart';
import 'package:cryptoplease_link/src/tokens.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:solana/solana.dart';

Future<void> main() async {
  final port = int.parse(io.Platform.environment['PORT'] ?? '8080');
  final solanaHandler = createSolanaHandler(tokens: tokens);

  final devnetClient = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );
  final devnetPlatform =
      await Ed25519HDKeyPair.fromMnemonic(devnetPlatformMnemonic);

  final mainnetClient = SolanaClient(
    rpcUrl: Uri.parse(mainnetRpcUrl),
    websocketUrl: Uri.parse(mainnetWsUrl),
  );
  final mainnetPlatform =
      await Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);

  final cascade = Cascade()
      .add(_staticHandler)
      .add(
        await paymentHandler(
          subDomain: 'devnet',
          client: devnetClient,
          mint: devnetUsdc,
          platform: devnetPlatform,
        ),
      )
      .add(
        await paymentHandler(
          subDomain: 'mainnet',
          client: mainnetClient,
          mint: mainnetUsdc,
          platform: mainnetPlatform,
        ),
      )
      .add(
        await moonpayHandler(),
      )
      .add(_router)
      .add(solanaHandler);

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
