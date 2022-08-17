import 'dart:async';
import 'dart:convert';

import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/usdc_outgoing_transfer/data/usdc_outgoing_transfer_client.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = UsdcOutgoingTransfersEvent;
typedef _State = UsdcOutgoingTransfersState;
typedef _Emitter = Emitter<_State>;

/// This BLoC is responsible for actual sending of outgoing transfers
/// and handling possible errors.
///
/// For creating a transfer see `FtCreateOutgoingTransferBloc`.
class UsdcOutgoingTransfersBloc extends Bloc<_Event, _State> {
  UsdcOutgoingTransfersBloc({
    required OutgoingTransferRepository repository,
    required SolanaClient solanaClient,
    required BalancesBloc balancesBloc,
    required MyAccount account,
    required UsdcOutgoingTransferClient client,
  })  : _repository = repository,
        _solanaClient = solanaClient,
        _balancesBloc = balancesBloc,
        _account = account,
        _client = client,
        super(const UsdcOutgoingTransfersState()) {
    on<_Event>(_handler);
  }

  final OutgoingTransferRepository _repository;
  final SolanaClient _solanaClient;
  final BalancesBloc _balancesBloc;
  final MyAccount _account;
  final UsdcOutgoingTransferClient _client;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        submitted: (event) => _onSubmitted(event, emit),
      );

  Future<void> _onSubmitted(Submitted event, _Emitter emit) async {
    if (state.processingIds.contains(event.id)) return;

    emit(state.addProcessing(event.id).removeError(event.id));

    final payment = await _repository.getById(event.id);
    if (payment.state.map(draft: F, ready: T)) return;

    final splitPayment = payment.map(splitKey: identity, direct: (_) => null);
    if (splitPayment == null) return;

    final newState = await _waitForSignatureOrSend(splitPayment);
    emit(newState.removeProcessing(payment.id));
  }

  Future<_State> _waitForSignatureOrSend(
    OutgoingTransferSplitKey payment,
  ) async {
    try {
      final existingSignature = payment.state.maybeMap(
        draft: (s) => s.signature,
        orElse: () => null,
      );
      final existingTx = payment.state.maybeMap(
        draft: (s) => s.encodedTx,
        orElse: () => null,
      );

      final String encodedTx, signature;

      if (existingSignature == null || existingTx == null) {
        final recipient = await payment.getRecipient();
        final publicKey = recipient.toBase58();

        final createdPayment = await _client.createPayment(
          CreatePaymentRequestDto(
            senderAccount: _account.wallet.address,
            escrowAccount: publicKey,
            amount: payment.amount.toInt(),
          ),
        );

        final message = _decompileMessage(createdPayment);
        final recentBlockhash =
            await _solanaClient.rpcClient.getRecentBlockhash();
        final tx = await signTransaction(
          recentBlockhash,
          message,
          [_account.wallet],
        );

        encodedTx = tx.encode();
        signature = tx.signatures.first.toBase58();

        await _repository.save(
          payment.toDraft(signature: signature, encodedTx: encodedTx),
        );

        await _solanaClient.rpcClient.sendTransaction(encodedTx);
      } else {
        encodedTx = existingTx;
        signature = existingSignature;

        if (!await _solanaClient.isSignatureSubmitted(signature)) {
          // If signature is not yet submitted to network, we try to submit it.
          // [JsonRpcException] will mean that something is wrong with
          // this transaction, so we remove it together with the signature
          // and propagate error to the user.
          //
          // It can be because of:
          // - blockhash is already expired;
          // - we're trying to create associated account, but it already exists;
          //
          // In any case, it's up to user to try creating another transaction.
          try {
            await _solanaClient.rpcClient.sendTransaction(encodedTx);
          } on JsonRpcException {
            await _repository.save(payment.toDraft());
            rethrow;
          }
        }
      }

      await _solanaClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
        timeout: waitForSignatureDefaultTimeout,
      );

      await _repository.save(payment.toReady(signature));

      _balancesBloc.add(BalancesEvent.requested(address: _account.address));

      return state.removeProcessing(payment.id);
    } on Exception catch (e) {
      return state.addError(payment.id, e);
    }
  }

  Message _decompileMessage(CreatePaymentResponseDto payment) {
    final tx = payment.transaction;
    final decoded = base64Decode(tx);
    final byteArray = ByteArray(decoded);
    final compiled = CompiledMessage.fromSignedTransaction(byteArray);

    return Message.decompile(compiled);
  }
}

extension on OutgoingTransfer {
  OutgoingTransfer toDraft({String? signature, String? encodedTx}) => copyWith(
        state: OutgoingTransferState.draft(
          signature: signature,
          encodedTx: encodedTx,
        ),
      );

  OutgoingTransfer toReady(String signature) => copyWith(
        signature: signature,
        state: const OutgoingTransferState.ready(),
      );
}

extension on _State {
  _State addError(String id, Exception error) =>
      copyWith(errors: errors.add(id, error));

  _State removeError(String id) => copyWith(errors: errors.remove(id));

  _State addProcessing(String id) =>
      copyWith(processingIds: processingIds.add(id));

  _State removeProcessing(String id) =>
      copyWith(processingIds: processingIds.remove(id));
}
