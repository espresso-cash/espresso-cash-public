import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/list/transactions_bloc.dart';
import 'package:cryptoplease/config.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/dto.dart' show ConfirmationStatus;
import 'package:solana/solana.dart';

void main() {
  final SolanaClient solanaClient = SolanaClient(
    rpcUrl: Uri.parse(solanaRpcUrl),
    websocketUrl: Uri.parse(solanaWebSocketUrl),
  );
  final rpcClient = solanaClient.rpcClient;

  group('TransactionsBloc:', () {
    final List<Transaction> transactions = [];
    late final MyAccount account;

    setUpAll(() async {
      final senderWallet = await Wallet.random();
      final testWallet = await Wallet.random();

      account = MyAccount(firstName: 'Tester', wallet: testWallet);

      await solanaClient.waitForSignatureStatus(
        await rpcClient.requestAirdrop(senderWallet.address, lamportsPerSol),
        status: ConfirmationStatus.finalized,
      );

      final instruction = SystemInstruction.transfer(
        fundingAccount: senderWallet.publicKey,
        recipientAccount: testWallet.publicKey,
        lamports: 500,
      );

      final signature = await solanaClient.rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [senderWallet],
      );
      await solanaClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.finalized,
      );

      transactions.add(
        Transaction.transfer(
          hash: signature,
          senderAddress: senderWallet.address,
          recipientAddress: testWallet.address,
          amount: 500,
          blockTime: DateTime.now(),
        ),
      );
    });

    blocTest<TransactionsBloc, TransactionsState>(
      'loads transactions',
      build: () => TransactionsBloc(
        solanaClient: solanaClient,
        account: account,
        token: Token.sol,
      ),
      act: (bloc) => bloc.add(const TransactionsEvent.loadRequested()),
      expect: () => [
        const TransactionsState(
          loadingState: LoadingState.inProgress(),
          transactions: IListConst([]),
        ),
        _TransactionsStateMatcher(
          TransactionsState(
            loadingState: const LoadingState.success(),
            transactions: IList(transactions),
          ),
        ),
        _TransactionsStateMatcher(
          TransactionsState(
            loadingState: const LoadingState.none(),
            transactions: IList(transactions),
          ),
        ),
      ],
      wait: const Duration(seconds: 5),
      tags: 'solana',
    );
  });
}

class _TransactionsStateMatcher extends Matcher {
  const _TransactionsStateMatcher(this.expected);

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(expected);

  @override
  bool matches(dynamic actual, Map<dynamic, dynamic> _) {
    if (actual is! TransactionsState) return false;

    if (actual.loadingState != expected.loadingState) return false;

    if (actual.transactions.length != expected.transactions.length) {
      return false;
    }

    for (int i = 0; i < actual.transactions.length; i++) {
      final actualTx = actual.transactions[i];
      final expectedTx = expected.transactions[i];

      if (actualTx.hash != expectedTx.hash) return false;

      final areEqual = actualTx.map(
        generic: F,
        transfer: (t) {
          if (expectedTx is! TransferTransaction) return false;

          if (t.recipientAddress != expectedTx.recipientAddress) return false;

          if (t.senderAddress != expectedTx.senderAddress) return false;

          if (t.amount != expectedTx.amount) return false;

          // We don't need to compare other fields, they cannot be easily
          // mocked anyway
          return true;
        },
      );

      if (!areEqual) return false;
    }

    return true;
  }

  final TransactionsState expected;
}
