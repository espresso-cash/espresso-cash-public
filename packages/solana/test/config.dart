import 'dart:io';

import 'package:solana/solana.dart';

final devnetRpcUrl =
    Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';
final devnetWebsocketUrl =
    Platform.environment['DEVNET_WEBSOCKET_URL'] ?? 'ws://127.0.0.1:8900';

SolanaClient createTestSolanaClient({bool useLocal = true}) => SolanaClient(
      rpcUrl: Uri.parse(
        useLocal ? devnetRpcUrl : 'https://api.devnet.solana.com',
      ),
      websocketUrl: Uri.parse(
        useLocal ? devnetWebsocketUrl : 'wss://api.devnet.solana.com',
      ),
    );
