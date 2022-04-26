import 'dart:async';

import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/nft/nft_collection/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/solana_helpers.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/config.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = OutgoingTransfersEvent;
typedef _State = OutgoingTransfersState;
typedef _Emitter = Emitter<_State>;

/// This BLoC is responsible for actual sending of outgoing transfers
/// and handling possible errors.
///
/// For creating a transfer see `FtCreateOutgoingTransferBloc`.
class OutgoingTransfersBloc extends Bloc<_Event, _State> {
  OutgoingTransfersBloc({
    required OutgoingTransferRepository repository,
    required SolanaClient solanaClient,
    required BalancesBloc balancesBloc,
    required NftCollectionBloc nftCollectionBloc,
    required MyAccount account,
  })  : _repository = repository,
        _solanaClient = solanaClient,
        _balancesBloc = balancesBloc,
        _nftCollectionBloc = nftCollectionBloc,
        _account = account,
        super(const OutgoingTransfersState()) {
    on<_Event>(_handler);
  }

  final OutgoingTransferRepository _repository;
  final SolanaClient _solanaClient;
  final BalancesBloc _balancesBloc;
  final NftCollectionBloc _nftCollectionBloc;
  final MyAccount _account;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        submitted: (event) => _onSubmitted(event, emit),
      );

  Future<void> _onSubmitted(Submitted event, _Emitter emit) async {
    if (state.processingIds.contains(event.id)) return;

    emit(state.addProcessing(event.id).removeError(event.id));

    final payment = await _repository.getById(event.id);
    if (payment.state.map(draft: F, ready: T)) return;

    final newState = await _waitForSignatureOrSend(payment);
    emit(newState.removeProcessing(payment.id));
  }

  Future<_State> _waitForSignatureOrSend(OutgoingTransfer payment) async {
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
        final message = await _createSignedTx(payment);
        final recentBlockhash =
            await _solanaClient.rpcClient.getRecentBlockhash();
        final tx = await signTransaction(
          recentBlockhash,
          message,
          [_account.wallet],
        );

        encodedTx = tx.encode();
        signature = tx.signatures.first.toBase58();

        await _repository
            .save(payment.toDraft(signature: signature, encodedTx: encodedTx));

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
      switch (payment.tokenType) {
        case OutgoingTransferTokenType.fungibleToken:
          _balancesBloc.add(BalancesEvent.requested(address: _account.address));
          break;
        case OutgoingTransferTokenType.nonFungibleToken:
          _nftCollectionBloc.add(const NftCollectionEvent.updated());
          break;
      }

      return state.removeProcessing(payment.id);
    } on Exception catch (e) {
      return state.addError(payment.id, e);
    }
  }

  Future<Message> _createSignedTx(OutgoingTransfer payment) async =>
      _solanaClient.createTransfer(
        sender: _account.wallet,
        recipient: await payment.getRecipient(),
        tokenAddress: Ed25519HDPublicKey.fromBase58(payment.tokenAddress),
        amount: payment.amount,
        additionalFee: payment.map(
          splitKey: (p) => p.tokenAddress == Token.sol.address
              ? lamportsPerSignature
              : lamportsPerSignature + tokenProgramRent,
          direct: always(0),
        ),
        memo: payment.memo,
        reference: payment.allReferences.map(Ed25519HDPublicKey.fromBase58),
      );
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
