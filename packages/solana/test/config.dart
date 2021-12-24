import 'dart:io';

final devnetRpcUrl =
    Platform.environment['DEVNET_RPC_URL'] ?? 'http://api.devnet.solana.com';
final devnetWebsocketUrl = Platform.environment['DEVNET_WEBSOCKET_URL'] ??
    'ws://api.devnet.solana.com';
