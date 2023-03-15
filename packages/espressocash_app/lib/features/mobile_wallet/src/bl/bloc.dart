import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../models/remote_request.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

@injectable
class MobileWalletBloc extends Bloc<MobileWalletEvent, MobileWalletState> {
  MobileWalletBloc(
    this._sender, {
    @factoryParam required RemoteRequest request,
    @factoryParam required MyAccount account,
  })  : _account = account,
        super(MobileWalletState.requested(request)) {
    on<MobileWalletEvent>(_eventHandler, transformer: droppable());
  }

  final TxSender _sender;
  final MyAccount _account;

  EventHandler<MobileWalletEvent, MobileWalletState> get _eventHandler =>
      (event, emit) => event.map(
            accepted: (_) => _onAccepted(emit),
            declined: (_) => _onDeclined(emit),
          );

  Future<void> _onDeclined(Emitter<MobileWalletState> emit) async {
    final request = state.whenOrNull(requested: identity);
    if (request == null) return;

    final result = request.map(
      authorizeDapp: always(null),
      signPayloads: always(const SignedPayloadResult.requestDeclined()),
      signTransactionsForSending:
          always(const SignaturesResult.requestDeclined()),
    );

    emit(MobileWalletState.result(result));
  }

  Future<void> _onAccepted(Emitter<MobileWalletState> emit) async {
    final request = state.whenOrNull(requested: identity);
    if (request == null) return;

    final result = request.when(
      authorizeDapp: _onAuthorized,
      signPayloads: _onSignPayloads,
      signTransactionsForSending: _signTransactionsForSending,
    );

    emit(MobileWalletState.result(result));
  }

  AuthorizeResult _onAuthorized(AuthorizeRequest _) => AuthorizeResult(
        publicKey: Uint8List.fromList(_account.wallet.publicKey.bytes),
        walletUriBase: null,
        // TODO(rhbrunetto): fix me
        accountLabel: _account.firstName,
        scope: Uint8List.fromList(
          utf8.encode([_scopeTag, _qualifier].whereType<String>().join(',')),
        ),
      );

  Future<SignedPayloadResult> _onSignPayloads(
    SignPayloadsRequest request,
  ) async {
    final payloads = request.payloads;
    // TODO(rhbrunetto): add payloads validation: invalidPayloads /
    // tooManyPayloads

    final signedPayloads = await Future.wait(
      request.map(
        transactions: (_) => payloads.map(SignedTx.fromBytes).map(
              (tx) => tx
                  .resign(_account.wallet)
                  .letAsync((it) => it.toByteArray().toList()),
            ),
        messages: (_) => payloads.map(
          (it) async =>
              it + await _account.wallet.sign(it).then((s) => s.bytes),
        ),
      ),
    );

    return SignedPayloadResult(
      signedPayloads: signedPayloads.map(Uint8List.fromList).toList(),
    );
  }

  Future<SignaturesResult> _signTransactionsForSending(
    SignAndSendTransactionsRequest request,
  ) async {
    // TODO(rhbrunetto): add validations:
    // - authorization: scope
    // - payload: invalidPayloads / tooManyPayloads

    final signedTxs = await request.transactions
        .map(SignedTx.fromBytes)
        .map((it) => it.resign(_account.wallet))
        .let(Future.wait);

    final signatures = signedTxs
        .map((it) => it.signatures.first.bytes)
        .map(Uint8List.fromList)
        .toList();

    final results = await signedTxs
        .map(
          (tx) => _sender
              .send(tx, minContextSlot: BigInt.zero)
              .letAsync((it) => it.maybeMap(orElse: F, sent: T)),
        )
        .let(Future.wait);

    return results.any((e) => !e)
        ? SignaturesResult.invalidPayloads(valid: results)
        : SignaturesResult(signatures: signatures);
  }
}

const String _scopeTag = 'app';
const String? _qualifier = null;
