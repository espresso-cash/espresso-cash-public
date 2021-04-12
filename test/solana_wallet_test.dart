import 'package:solana/solana.dart';
import 'package:test/test.dart';

const mnemonic =
    'immune music course agent inquiry spatial hospital bind harvest spider torch column';

void main() {
  group('Solana wallet is built correctly', () {
    test('It creates a wallet with the correct parameters (account 0)',
        () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic);
      expect(wallet.address, 'GLwos8Rrtjqxm9JThToeZmj5D68dnnMn7tdjHNn4Urom');
    });
    test('Default wallet has the same address as zeroth account', () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic, account: 0);
      expect(wallet.address, 'GLwos8Rrtjqxm9JThToeZmj5D68dnnMn7tdjHNn4Urom');
    });
    test('It creates a wallet with the correct parameters (account 1)',
        () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic, account: 1);
      expect(wallet.address, '5DZfJ47byxy6oTmNmHCwsX6t21z9MsFaXZRNSfx7e8ER');
    });
  });
}
