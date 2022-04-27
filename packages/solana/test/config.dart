import 'dart:io';

import 'package:solana/solana.dart';

final devnetRpcUrl =
    Platform.environment['DEVNET_RPC_URL'] ?? 'https://api.devnet.solana.com';
final devnetWebsocketUrl = Platform.environment['DEVNET_WEBSOCKET_URL'] ??
    'wss://api.devnet.solana.com';

SolanaClient createTestSolanaClient() => SolanaClient(
      rpcUrl: Uri.parse(devnetRpcUrl),
      websocketUrl: Uri.parse(devnetWebsocketUrl),
      timeout: const Duration(minutes: 1),
    );
