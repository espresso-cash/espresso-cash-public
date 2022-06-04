import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/solana_helpers.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/config.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = SplitKeyIncomingPaymentEvent;
typedef _State = SplitKeyIncomingPayment;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SplitKeyIncomingPaymentBloc extends Bloc<_Event, _State> {
  SplitKeyIncomingPaymentBloc({
    required SolanaClient solanaClient,
    required SplitKeyIncomingRepository repository,
    required BalancesBloc balancesBloc,
  })  : _solanaClient = solanaClient,
        _repository = repository,
        _balancesBloc = balancesBloc,
        super(const SplitKeyIncomingPayment.none()) {
    on<_Event>(_handler, transformer: sequential());
  }

  final SolanaClient _solanaClient;
  final SplitKeyIncomingRepository _repository;
  final BalancesBloc _balancesBloc;

  _EventHandler get _handler => (e, emit) => e.map(
        firstPartAdded: (e) => _onFirstPartAdded(e, emit),
        secondPartAdded: (e) => _onSecondPartAdded(e, emit),
        paymentRequested: (e) => _onPaymentRequested(e, emit),
        cleared: (e) => _onCleared(e, emit),
      );

  Future<void> _onFirstPartAdded(FirstPartAdded event, _Emitter emit) async {
    emit(
      SplitKeyIncomingPayment.firstPartReady(
        firstPart: event.firstPart.keyPart,
        tokenAddress: event.firstPart.tokenAddress,
      ),
    );
    await _repository.save(event.firstPart);
  }

  Future<void> _onSecondPartAdded(SecondPartAdded event, _Emitter emit) async {
    final updated = await state.map(
      none: (s) async {
        final existing = await _repository.watch().first;
        if (existing == null) return s;

        return SplitKeyIncomingPayment.secondPartReady(
          firstPart: existing.keyPart,
          tokenAddress: existing.tokenAddress,
          secondPart: event.value.key,
        );
      },
      firstPartReady: (s) async => SplitKeyIncomingPayment.secondPartReady(
        firstPart: s.firstPart,
        tokenAddress: s.tokenAddress,
        secondPart: event.value.key,
      ),
      secondPartReady: (s) async => SplitKeyIncomingPayment.secondPartReady(
        firstPart: s.firstPart,
        tokenAddress: s.tokenAddress,
        secondPart: event.value.key,
      ),
      success: (s) async => s,
    );
    emit(updated);
    await _repository.clear();
  }

  Future<void> _onPaymentRequested(
    PaymentRequested event,
    _Emitter emit,
  ) async {
    final state = this.state;
    if (state is! PaymentSecondPartReady) return;

    final firstPart = state.firstPart;
    final secondPart = state.secondPart;

    emit(state.copyWith(processingState: const ProcessingState.processing()));
    final updated = await _processPayment(
      firstPart: firstPart,
      secondPart: secondPart,
      recipient: event.recipient,
      tokenAddress: state.tokenAddress,
    ).foldAsync(
      (e) => state.copyWith(processingState: ProcessingState.error(e)),
      (_) => const SplitKeyIncomingPayment.success(),
    );
    emit(updated);
  }

  Future<void> _onCleared(PaymentCleared _, _Emitter emit) async {
    emit(const SplitKeyIncomingPayment.none());
  }

  AsyncEither<SplitKeyIncomingPaymentError, void> _processPayment({
    required String firstPart,
    required String secondPart,
    required String recipient,
    required String tokenAddress,
  }) async {
    try {
      final wallet = await walletFromParts(
        firstPart: firstPart,
        secondPart: secondPart,
      );

      final solBalance = await _solanaClient.rpcClient.getBalance(
        wallet.address,
        commitment: Commitment.confirmed,
      );

      final int transferAmount;
      final int remainder;
      if (tokenAddress == Token.sol.address) {
        // SOL payment, just transfer all the money minus transaction fee.
        transferAmount = solBalance - lamportsPerSignature;
        remainder = 0;
      } else {
        // SPL payment. Transfer all the money on SPL account and
        // all the money remaining on the SOL account (minus transaction fee).
        final tokenAccounts =
            await _solanaClient.rpcClient.getTokenAccountsByOwner(
          wallet.address,
          TokenAccountsFilter.byMint(tokenAddress),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        );
        final tokenAccount = tokenAccounts.firstOrNull;

        if (tokenAccount == null) {
          return const Either.left(SplitKeyIncomingPaymentError.emptyAccount());
        }

        transferAmount = await _solanaClient.rpcClient
            .getTokenAccountBalance(
              tokenAccount.pubkey,
              commitment: Commitment.confirmed,
            )
            .then((v) => int.parse(v.amount));

        // If recipient has already associated account, then we can
        // transfer all the money from SOL account of this temp wallet
        // to SOL account of the recipient (minus the transaction fee).
        remainder = await _solanaClient.hasAssociatedTokenAccount(
          owner: Ed25519HDPublicKey.fromBase58(recipient),
          mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
        )
            ? solBalance - lamportsPerSignature
            : 0;
      }

      if (transferAmount <= 0) {
        final transactions = await _solanaClient.rpcClient.getTransactionsList(
          wallet.publicKey,
          limit: 1,
          commitment: Commitment.confirmed,
        );
        if (transactions.isEmpty) {
          return const Either.left(SplitKeyIncomingPaymentError.emptyAccount());
        } else {
          return const Either.left(SplitKeyIncomingPaymentError.consumed());
        }
      }

      final message = tokenAddress == Token.sol.address
          ? await _solanaClient.createSolTransfer(
              sender: wallet,
              recipient: Ed25519HDPublicKey.fromBase58(recipient),
              amount: transferAmount + remainder,
            )
          : await _solanaClient.createSplTransfer(
              sender: wallet,
              solanaAddress: Ed25519HDPublicKey.fromBase58(recipient),
              additionalFee: remainder,
              amount: transferAmount,
              tokenAddress: Ed25519HDPublicKey.fromBase58(tokenAddress),
            );
      final signature = await _solanaClient.rpcClient
          .signAndSendTransaction(message, [wallet]);
      await _solanaClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
        timeout: waitForSignatureDefaultTimeout,
      );

      _balancesBloc.add(BalancesEvent.requested(address: recipient));

      return const Either.right(null);
    } on Exception catch (e) {
      return Either.left(SplitKeyIncomingPaymentError.other(e));
    }
  }
}

Future<Wallet> walletFromParts({
  required String firstPart,
  required String secondPart,
}) async {
  final keyPart1 = ByteArray.fromBase58(firstPart).toList();
  final keyPart2 = ByteArray.fromBase58(secondPart).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: keyPart1 + keyPart2);
}
