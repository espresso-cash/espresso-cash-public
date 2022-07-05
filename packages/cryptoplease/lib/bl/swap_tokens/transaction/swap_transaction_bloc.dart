import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/swap_tokens/swap_exception.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'swap_transaction_bloc.freezed.dart';
part 'swap_transaction_event.dart';
part 'swap_transaction_state.dart';

typedef _Event = SwapTransactionEvent;
typedef _State = SwapTransactionState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SwapTransactionBloc
    extends Bloc<SwapTransactionEvent, SwapTransactionState> {
  SwapTransactionBloc({
    required SolanaClient solanaClient,
    required JupiterAggregatorClient jupiterAggregatorClient,
    required MyAccount myAccount,
  })  : _solanaClient = solanaClient,
        _jupiterClient = jupiterAggregatorClient,
        _myAccount = myAccount,
        super(const SwapTransactionState.idle()) {
    on<_Event>(_eventHandler, transformer: droppable());
  }

  final JupiterAggregatorClient _jupiterClient;
  final MyAccount _myAccount;
  final SolanaClient _solanaClient;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        swapRequested: (e) => _onSwapRequested(e, emit),
        retryRequested: (e) => _onRetryRequested(e, emit),
      );

  Future<void> _onSwapRequested(SwapRequested event, _Emitter emit) async {
    if (state is! Idle) return;

    try {
      emit(const SwapTransactionState.preparing());

      final publicKey = _myAccount.publicKey.toBase58();

      final transaction = await _jupiterClient.getSwapTransactions(
        route: event.jupiterRoute,
        userPublicKey: publicKey,
      );

      await _executeTransactions(tx: transaction, emit: emit);
    } on Exception catch (e) {
      emit(SwapTransactionState.failed(SwapException.other(e)));
    }
  }

  Future<void> _onRetryRequested(RetryRequested _, _Emitter emit) async =>
      state.maybeMap(
        failed: (e) => e.error.maybeMap(
          setupFailed: (s) => _executeTransactions(tx: s.tx, emit: emit),
          swapFailed: (s) => _executeTransactions(
            tx: s.tx,
            emit: emit,
            skipSetup: true,
          ),
          cleanupFailed: (s) => _executeTransactions(
            tx: s.tx,
            emit: emit,
            skipSetup: true,
            skipSwap: true,
          ),
          orElse: ignore,
        ),
        orElse: ignore,
      );

  Future<void> _executeTransactions({
    required JupiterSwapTransactions tx,
    required _Emitter emit,
    bool skipSetup = false,
    bool skipSwap = false,
  }) async {
    try {
      await _maybeExecuteTx(
        tx: skipSetup ? null : tx.setupTransaction,
        onSetup: () => emit(SwapTransactionState.settingUp(tx)),
        onError: (e) => throw SwapException.setupFailed(tx, e),
      );

      await _maybeExecuteTx(
        tx: skipSwap ? null : tx.swapTransaction,
        onSetup: () => emit(SwapTransactionState.swapping(tx)),
        onError: (e) => throw SwapException.swapFailed(tx, e),
      );

      await _maybeExecuteTx(
        tx: tx.cleanupTransaction,
        onSetup: () => emit(SwapTransactionState.cleaningUp(tx)),
        onError: (e) => throw SwapException.cleanupFailed(tx, e),
      );

      emit(const SwapTransactionState.finished());
    } on SwapException catch (e) {
      emit(SwapTransactionState.failed(e));
    }
  }

  Future<String?> _maybeExecuteTx({
    required String? tx,
    required VoidCallback onSetup,
    required ValueSetter<Exception> onError,
  }) async {
    try {
      if (tx == null) return null;
      onSetup();

      final decoded = base64Decode(tx);
      final byteArray = ByteArray(decoded);
      final compiled = CompiledMessage.fromSignedTransaction(byteArray);
      final message = Message.decompile(compiled);
      final recent = await _solanaClient.rpcClient.getRecentBlockhash();
      final recompiled = message.compile(recentBlockhash: recent.blockhash);
      final wallet = _myAccount.wallet;

      final signedTx = SignedTx(
        messageBytes: recompiled.data,
        signatures: [await wallet.sign(recompiled.data)],
      );

      final transaction = signedTx.encode();

      final signature = await _solanaClient.rpcClient.sendTransaction(
        transaction,
        preflightCommitment: Commitment.confirmed,
      );

      await _solanaClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
        timeout: const Duration(minutes: 1),
      );

      return signature;
    } on Exception catch (e) {
      onError(e);
    }
  }
}
