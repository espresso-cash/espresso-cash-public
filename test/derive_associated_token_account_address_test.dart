import 'package:solana/src/util/derive_associated_token_account_address.dart';
import 'package:test/test.dart';

void main() {
  test('Correctly derives an associated token address', () async {
    final String derived = await deriveAssociatedTokenAddress(
      walletAddress: '9k4R4yZcS8j1BoRTA3C75sQUjW5i8x8sDaaoNQDNXjfC',
      mintAddress: 'BgLR7yanLaAHR58MHUTLXw7A7jhu9KSd3NaxkHsuQtQH',
    );
    expect(derived, equals('J5StdYSj2m2Tk1Un67AmKqBKHBenrLSp2xd8NwxSybUG'));
  });
}
