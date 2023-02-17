import 'package:solana/solana.dart';

const devnetRpcUrl = 'http://127.0.0.1:8899';
const devnetWebsocketUrl = 'ws://127.0.0.1:8900';

SolanaClient createTestSolanaClient() => SolanaClient(
      rpcUrl: Uri.parse(devnetRpcUrl),
      websocketUrl: Uri.parse(devnetWebsocketUrl),
    );
