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

      final setupTxId = await _maybeExecuteTx(
        tx: transaction.setupTransaction,
        onSetup: () => emit(const SwapTransactionState.settingUp()),
        onError: (e) => throw SwapException(
          SwapFailReason.setupFailed,
          exception: e,
        ),
      );

      final swapTxId = await _maybeExecuteTx(
        tx: transaction.swapTransaction,
        onSetup: () => emit(const SwapTransactionState.swapping()),
        onError: (e) => throw SwapException(
          SwapFailReason.swapFailed,
          exception: e,
        ),
      );

      final cleanupTxId = await _maybeExecuteTx(
        tx: transaction.cleanupTransaction,
        onSetup: () => emit(const SwapTransactionState.cleaningUp()),
        onError: (e) => throw SwapException(
          SwapFailReason.cleanUpFailed,
          exception: e,
        ),
      );

      emit(
        SwapTransactionState.finished(
          setupTxId: setupTxId,
          swapTxId: swapTxId ?? '',
          cleanupTxId: cleanupTxId,
        ),
      );
    } on SwapException catch (e) {
      emit(
        SwapTransactionState.failed(e.reason, e.exception),
      );
    } on Exception catch (e) {
      emit(
        SwapTransactionState.failed(SwapFailReason.unknown, e),
      );
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
        commitment: Commitment.confirmed,
      );

      await _solanaClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
      );

      return signature;
    } on Exception catch (e) {
      onError(e);
    }
  }
}
