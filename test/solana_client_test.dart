import 'package:bip39/bip39.dart';
import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/solana_wallet.dart';
import 'package:solana_dart/src/types/account_info.dart';
import 'package:solana_dart/src/types/blockhash.dart';
import 'package:solana_dart/src/types/signature_status.dart';
import 'package:solana_dart/src/types/transfer_result.dart';
import 'package:solana_dart/src/types/tx_signature.dart';
import 'package:test/test.dart';

const String _devnetRpcUrl = 'http://127.0.0.1:8899';

void main() {
  group('SolanaClient testsuite', () {
    final SolanaWallet targetWallet = SolanaWallet.fromMnemonic(
      generateMnemonic(),
    );
    final SolanaClient client = SolanaClient(_devnetRpcUrl);
    final SolanaWallet sourceWallet = SolanaWallet.fromMnemonic(
      generateMnemonic(),
    );
    BigInt currentBalance = BigInt.zero;

    test('Can call `requestAirdrop\' and mint a wallet', () async {
      final addedBalance = BigInt.from(100) * LAMPORTS_PER_SOL;
      final TxSignature signature = await client.requestAirdrop(
        sourceWallet.address,
        addedBalance,
        'finalized',
      );
      expect(signature, isNot(null));
      await client.waitForSignatureStatus(
        signature,
        TxStatus.finalized,
      );
      final BigInt balance =
          await client.getBalance(sourceWallet.address, 'finalized');
      // Update the global balance
      currentBalance += addedBalance;
      // Check that it matches
      expect(balance, currentBalance);
    });

    test('Can read the recent blockhash', () async {
      final Blockhash blockHash = await client.getRecentBlockhash();
      expect(blockHash, isNot(null));
      expect(blockHash.blockhash, isNot(null));
      expect(blockHash.blockhash, isNot(''));
      expect(blockHash.feeCalculator, isNot(null));
      expect(blockHash.feeCalculator.lamportsPerSignature, isNot(null));
    });

    test('Can read the balance of an account', () async {
      final BigInt balance = await client.getBalance(sourceWallet.address);
      expect(balance, currentBalance);
    });

    test('Can get all the account information of an account', () async {
      final AccountInfo accountInfo =
          await client.getAccountInfo(sourceWallet.address);
      expect(accountInfo.lamports, currentBalance);
      expect(accountInfo.owner, SOLANA_SYSTEM_PROGRAM_ID);
      expect(accountInfo.executable, false);
    });

    test('Can simulate a transfer transaction', () async {
      final BigInt transferredAmount = BigInt.from(7500);
      final SimulateTxResult transferResult = await client.simulateTransfer(
        sourceWallet,
        targetWallet.address,
        transferredAmount,
      );
      expect(transferResult.err, null);
    });

    test('Can send a transfer transaction and transfer SOL', () async {
      final BigInt transferredAmount = BigInt.from(7500);
      final TxSignature signature = await client.transfer(
        sourceWallet,
        targetWallet.address,
        transferredAmount,
      );
      expect(signature, isNot(null));
      await client.waitForSignatureStatus(
        signature,
        TxStatus.finalized,
      );
      final balance =
          await client.getBalance(targetWallet.address, 'finalized');
      expect(balance, greaterThan(BigInt.zero));
    });
  });
}
