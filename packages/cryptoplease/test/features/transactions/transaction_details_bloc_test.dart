import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/features/transactions/bl/details/transaction_details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/dto.dart' show ConfirmationStatus;
import 'package:solana/solana.dart';

import '../../utils.dart';

void main() {
  final SolanaClient solanaClient = createTestSolanaClient();

  group('With transaction:', () {
    late final String signature;

    setUpAll(() async {
      final senderWallet = await Wallet.random();
      final testWallet = await Wallet.random();

      await solanaClient.requestAirdrop(
        address: senderWallet.publicKey,
        lamports: lamportsPerSol,
        commitment: Commitment.confirmed,
      );

      final instruction = SystemInstruction.transfer(
        fundingAccount: senderWallet.publicKey,
        recipientAccount: testWallet.publicKey,
        lamports: 5000000,
      );

      signature = await solanaClient.rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [senderWallet],
        commitment: Commitment.confirmed,
      );
      await solanaClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.confirmed,
      );
    });

    blocTest<TransactionDetailsBloc, TransactionDetailsState>(
      'loads transaction',
      build: () => TransactionDetailsBloc(solanaClient.rpcClient),
      act: (bloc) =>
          bloc.add(TransactionDetailsEvent.load(transactionHash: signature)),
      expect: () => [
        const TypeMatcher<TransactionDetailsReady>()
            .having((s) => s.signature, 'signature', signature)
            .having((s) => s.status, 'status', TransactionStatus.confirmed),
      ],
      wait: const Duration(seconds: 5),
      tags: 'solana',
    );
  });

  group('Without transaction:', () {
    const nonExistingHash =
        '3md5MKEe9RX6R1G3ttYN57k4fM1TP8mDdo2MJNrz7DrkqfQH36BezxRfDYi3evSA2Egf2S5RdSLasqPuwhmQKhja';

    blocTest<TransactionDetailsBloc, TransactionDetailsState>(
      'gives error when loading transaction that does not exist',
      build: () => TransactionDetailsBloc(solanaClient.rpcClient),
      act: (bloc) => bloc.add(
        const TransactionDetailsEvent.load(transactionHash: nonExistingHash),
      ),
      expect: () => [
        const TransactionDetailsState.error(TransactionDetailsError.notFound),
      ],
      wait: const Duration(seconds: 5),
      tags: 'solana',
    );
  });
}
