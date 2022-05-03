import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/bl/wallet/wallet.dart';
import 'package:cryptoplease/config.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/solana.dart';

import 'repository.dart';

void main() {
  test('Creates wallet from key parts', () async {
    const part1 = 'HxcWVVxoBQkcQbLaz9KE4K';
    const part2 = '77euQgeKbKxaBqVi1pQRFk';

    final wallet = await walletFromParts(
      firstPart: part1,
      secondPart: part2,
    );

    expect(wallet.address, '4zFNyiDY2uwqmd8NcHftRj3DKD7ueee13ENEpsR8wfdF');
  });

  group('Process incoming payments', () {
    final solanaClient = SolanaClient(
      rpcUrl: Uri.parse(solanaRpcUrl),
      websocketUrl: Uri.parse(solanaWebSocketUrl),
    );
    final balancesBloc = BalancesBloc(
      solanaClient: solanaClient,
      tokens: TokenList(),
    );
    late Wallet sourceWallet;
    late Wallet targetWallet;
    late OutgoingTransferSplitKey payment;

    Future<void> receivePayment(
      SplitKeyIncomingPaymentBloc bloc,
      Wallet target, {
      bool startWithAddingFirstPart = true,
    }) async {
      final parts = splitKey(payment.privateKey);

      if (startWithAddingFirstPart) {
        bloc.add(
          SplitKeyIncomingPaymentEvent.firstPartAdded(
            firstPart: SplitKeyIncomingFirstPart(
              keyPart: parts.first,
              tokenAddress: Token.sol.address,
            ),
          ),
        );
      }

      bloc
        ..add(
          SplitKeyIncomingPaymentEvent.secondPartAdded(
            value: SplitKeySecondLink(key: parts.last),
          ),
        )
        ..add(
          SplitKeyIncomingPaymentEvent.paymentRequested(
            recipient: target.address,
          ),
        );
      await bloc.stream.firstWhere(
        (s) =>
            s is PaymentSuccess ||
            s is PaymentSecondPartReady &&
                s.processingState.maybeMap(error: T, orElse: F),
      );
    }

    setUpAll(() async {
      sourceWallet = await Wallet.random();

      await solanaClient.requestAirdrop(
        lamports: lamportsPerSol,
        address: sourceWallet.publicKey,
      );
    });

    setUp(() async {
      targetWallet = await Wallet.random();

      payment = await OutgoingTransfer.createSplitKeyTransfer(
        amount: lamportsPerSol ~/ 100,
        tokenAddress: Token.sol.address,
        tokenType: OutgoingTransferTokenType.fungibleToken,
      );

      await solanaClient.transferLamports(
        destination:
            (await createKeyPairFromPrivateKey(payment.privateKey.unlock))
                .publicKey,
        lamports: payment.amount,
        source: sourceWallet,
        commitment: Commitment.finalized,
      );
    });

    test(
      'Gets payment',
      () async {
        final bloc = SplitKeyIncomingPaymentBloc(
          solanaClient: solanaClient,
          repository: MemorySplitKeyIncomingRepository(),
          balancesBloc: balancesBloc,
        );
        await receivePayment(bloc, targetWallet);

        expect(bloc.state, const SplitKeyIncomingPayment.success());

        final lamports = await solanaClient.rpcClient.getBalance(
          targetWallet.address,
          commitment: Commitment.confirmed,
        );
        expect(lamports, 9995000);
      },
      timeout: const Timeout(Duration(minutes: 1)),
      tags: 'solana',
    );

    test(
      'Gets payment if first part is saved in repository',
      () async {
        final repository = MemorySplitKeyIncomingRepository();
        await repository.save(
          SplitKeyIncomingFirstPart(
            keyPart: splitKey(payment.privateKey).first,
            tokenAddress: Token.sol.address,
          ),
        );
        final bloc = SplitKeyIncomingPaymentBloc(
          solanaClient: solanaClient,
          repository: repository,
          balancesBloc: balancesBloc,
        );
        await receivePayment(
          bloc,
          targetWallet,
          startWithAddingFirstPart: false,
        );

        expect(bloc.state, const SplitKeyIncomingPayment.success());

        final lamports = await solanaClient.rpcClient.getBalance(
          targetWallet.address,
          commitment: Commitment.confirmed,
        );
        expect(lamports, 9995000);
      },
      timeout: const Timeout(Duration(minutes: 1)),
      tags: 'solana',
    );

    test(
      'Gives error when requested second time',
      () async {
        final bloc = SplitKeyIncomingPaymentBloc(
          solanaClient: solanaClient,
          repository: MemorySplitKeyIncomingRepository(),
          balancesBloc: balancesBloc,
        );
        await receivePayment(bloc, targetWallet);
        await receivePayment(bloc, targetWallet);

        final state = bloc.state as PaymentSecondPartReady;
        expect(
          state.processingState.maybeMap(
            error: (s) => s.e,
            orElse: () => null,
          ),
          isA<ErrorConsumed>(),
        );

        final lamports = await solanaClient.rpcClient.getBalance(
          targetWallet.address,
          commitment: Commitment.confirmed,
        );
        expect(lamports, 9995000);
      },
      timeout: const Timeout(Duration(minutes: 1)),
      tags: 'solana',
    );

    test(
      'Gives error when requested by someone else',
      () async {
        final bloc = SplitKeyIncomingPaymentBloc(
          solanaClient: solanaClient,
          repository: MemorySplitKeyIncomingRepository(),
          balancesBloc: balancesBloc,
        );
        await receivePayment(bloc, sourceWallet);
        await receivePayment(bloc, targetWallet);

        final state = bloc.state as PaymentSecondPartReady;
        expect(
          state.processingState.maybeMap(
            error: (s) => s.e,
            orElse: () => null,
          ),
          isA<ErrorConsumed>(),
        );

        final lamports = await solanaClient.rpcClient.getBalance(
          targetWallet.address,
          commitment: Commitment.confirmed,
        );
        expect(lamports, 0);
      },
      timeout: const Timeout(Duration(minutes: 1)),
      tags: 'solana',
    );
  });
}
