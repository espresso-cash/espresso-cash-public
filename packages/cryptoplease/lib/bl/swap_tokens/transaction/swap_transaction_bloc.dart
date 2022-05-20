import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/swap_tokens/swap_exception.dart';
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
        super(
          const SwapTransactionState.idle(),
        ) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final JupiterAggregatorClient _jupiterClient;
  final MyAccount _myAccount;
  final SolanaClient _solanaClient;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        swap: (e) => _onSwap(e, emit),
      );

  Future<void> _onSwap(SwapEvent swapEvent, _Emitter emit) async {
    try {
      emit(const SwapTransactionState.preparing());

      final publicKey = _myAccount.publicKey.toBase58();

      final transaction = await _jupiterClient.getSwapTransactions(
        route: swapEvent.jupiterRoute,
        userPublicKey: publicKey,
      );

      await _maybeExecuteTx(
        tx: transaction.setupTransaction,
        onSetup: () => emit(const SwapTransactionState.settingUp()),
        onError: (e) => throw SwapExcetion(
          SwapFailReason.setupFailed,
          exception: e,
        ),
      );

      await _maybeExecuteTx(
        tx: transaction.swapTransaction,
        onSetup: () => emit(const SwapTransactionState.swapping()),
        onError: (e) => throw SwapExcetion(
          SwapFailReason.swapFailed,
          exception: e,
        ),
      );

      await _maybeExecuteTx(
        tx: transaction.cleanupTransaction,
        onSetup: () => emit(const SwapTransactionState.cleaningUp()),
        onError: (e) => throw SwapExcetion(
          SwapFailReason.cleanUpFailed,
          exception: e,
        ),
      );

      emit(
        const SwapTransactionState.finished(),
      );
    } on SwapExcetion catch (e) {
      emit(
        SwapTransactionState.failed(e.reason, e.exception),
      );
    } on Exception catch (e) {
      emit(
        SwapTransactionState.failed(SwapFailReason.unknown, e),
      );
    }
  }

  Future<void> _maybeExecuteTx({
    required String? tx,
    required VoidCallback onSetup,
    required ValueSetter<Exception> onError,
  }) async {
    try {
      if (tx == null) return;
      onSetup();

      final decoded = base64Decode(tx);
      final byteArray = ByteArray(decoded);
      final compiled = CompiledMessage.fromSignedTransaction(byteArray);
      final message = Message.decompile(compiled);
      final recent = await _solanaClient.rpcClient.getRecentBlockhash(
        commitment: Commitment.processed,
      );
      final recompiled = message.compile(recentBlockhash: recent.blockhash);
      final wallet = _myAccount.wallet;

      final signedTx = SignedTx(
        messageBytes: recompiled.data,
        signatures: [await wallet.sign(recompiled.data)],
      );

      final signature = signedTx.encode();

      final x = await _solanaClient.rpcClient.sendTransaction(
        signature,
        commitment: Commitment.processed,
      );

      print(x);
    } on Exception catch (e) {
      onError(e);
    }
  }
}
