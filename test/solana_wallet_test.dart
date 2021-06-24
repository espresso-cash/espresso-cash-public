import 'package:solana/src/wallet.dart';
import 'package:test/test.dart';

const mnemonic =
    'hold whisper gorilla trophy ethics tiger rapid any devote verify test off foam park place rent essay hedgehog sick enlist chunk reveal control still';

void main() {
  group('Solana wallet is built correctly', () {
    test('It creates a wallet with the correct parameters (account 0)',
        () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic);
      expect(wallet.address, 'HcAd4GJD5BEB9xtp7kos2xAyvHMJnCQV4gWhqCMveEKH');
    });
    test('Default wallet has the same address as zeroth account', () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic, walletIndex: 0);
      expect(wallet.address, 'HcAd4GJD5BEB9xtp7kos2xAyvHMJnCQV4gWhqCMveEKH');
    });
    test('It creates a wallet with the correct parameters (account 1)',
        () async {
      final wallet = await SolanaWallet.fromMnemonic(mnemonic, walletIndex: 1);
      expect(wallet.address, '7RfUugqC39pioyMB7E6JmFyWb4sLynKVscdPjVrW4xJa');
    });
  });
}
