import 'dart:io';

import 'package:solana/src/client.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:test/test.dart';

const _mint = '3i4L7AYcwYQgdipuWCJhf4HgAfUDU21mQtrgxuwHqQwZ';
const _map = <String, String>{
  'PacBWUXCuMxQfK7XVNMSoyRYQCH1ZfmwfJPD6Uzi6pi':
      '3MvNXdZK4GfNgTYCrbrj3q4yxJmRLzYqSrHf1LU87yK3',
  '7vVcBLQwT1rmjiTXhhvmHKfiaCda2giGMeKchc2jwmBN':
      'HJ9iwne7NoJbyENAjrCFuUu46fJgCGTUnHiqZUifiMb',
  '3z99cfKQ2kvKxs79gJon7GeRZ3gtJWfmNG1NkZqFJKQs':
      'DxEGGGc2YfohmGF8w1pudYDs72my4Qk1xFTy5WbAphSD',
  '6pr7pCxXu9cF8oP2ARRhrkDj6ikw6QyJNAZ62gyQmwjZ':
      'CLmiMYTeoqGQHmNu1jBYWtu3hcPr4u32aRWAPQCwCHjP',
};

void main() {
  test('Can generate associated token account address', () async {
    final devnetRpcUrl =
        Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';
    final SolanaClient client = SolanaClient(devnetRpcUrl);
    final token = await SPLToken.fromMint(
      mint: _mint,
      client: client,
    );
    for (final entry in _map.entries) {
      final address = await token.getAssociatedTokenAddress(
        systemAccountAddress: entry.key,
      );
      expect(address, equals(entry.value));
    }
  });
}
