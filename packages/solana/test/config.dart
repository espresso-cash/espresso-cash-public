import 'dart:io';

final devnetRpcUrl = Platform.environment['DEVNET_RPC_URL'] ??
    'http://cryptoplease.devnet.rpcpool.com';
final devnetWebsocketUrl =
    Platform.environment['DEVNET_WEBSOCKET_URL'] ?? 'ws://127.0.0.1:8900';
