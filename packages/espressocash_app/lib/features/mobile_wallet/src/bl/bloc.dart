import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/account.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../models/remote_request.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

@injectable
class RemoteRequestBloc extends Bloc<RemoteRequestEvent, RemoteRequestState> {
  RemoteRequestBloc(
    this._sender, {
    @factoryParam required RemoteRequest request,
    @factoryParam required MyAccount account,
  })  : _account = account,
        super(RemoteRequestState.requested(request)) {
    on<RemoteRequestEvent>(_eventHandler, transformer: droppable());
  }

  final TxSender _sender;
  final MyAccount _account;

  EventHandler<RemoteRequestEvent, RemoteRequestState> get _eventHandler =>
      (event, emit) => event.map(
            accepted: (_) => _onAccepted(emit),
            declined: (_) => _onDeclined(emit),
          );

  Future<void> _onDeclined(Emitter<RemoteRequestState> emit) async {
    final request = state.whenOrNull(requested: identity);
    if (request == null) return;

    final result = request.map(
      authorizeDapp: always(null),
      signPayloads: always(const SignedPayloadResult.requestDeclined()),
      signTransactionsForSending:
          always(const SignaturesResult.requestDeclined()),
    );

    emit(RemoteRequestState.result(result));
  }

  Future<void> _onAccepted(Emitter<RemoteRequestState> emit) async {
    final request = state.whenOrNull(requested: identity);
    if (request == null) return;

    emit(const RemoteRequestState.loading());

    final result = request.when(
      authorizeDapp: _onAuthorized,
      signPayloads: _onSignPayloads,
      signTransactionsForSending: _signTransactionsForSending,
    );

    emit(RemoteRequestState.result(result));
  }

  AuthorizeResult _onAuthorized(AuthorizeRequest _) => AuthorizeResult(
        publicKey: Uint8List.fromList(_account.wallet.publicKey.bytes),
        walletUriBase: null,
        accountLabel: 'Espresso Cash account',
        scope: _buildScope(),
      );

  Future<SignedPayloadResult> _onSignPayloads(
    SignPayloadsRequest request,
  ) =>
      _validatePayloads(
        authorizationScope: request.authorizationScope,
        payloads: request.payloads,
      ).fold(
        (err) async => err.when(
          invalidPayloads: (it) =>
              SignedPayloadResult.invalidPayloads(valid: it),
          authorizationNotValid:
              always(const SignedPayloadResult.authorizationNotValid()),
          tooManyPayloads: always(const SignedPayloadResult.tooManyPayloads()),
        ),
        (payloads) async {
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
        },
      );

  Future<SignaturesResult> _signTransactionsForSending(
    SignAndSendTransactionsRequest request,
  ) =>
      _validatePayloads(
        authorizationScope: request.authorizationScope,
        payloads: request.transactions,
      ).fold(
        (err) async => err.when(
          invalidPayloads: (it) => SignaturesResult.invalidPayloads(valid: it),
          authorizationNotValid:
              always(const SignaturesResult.authorizationNotValid()),
          tooManyPayloads: always(const SignaturesResult.tooManyPayloads()),
        ),
        (payloads) async {
          final signedTxs = await payloads
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
        },
      );
}

Either<_ValidationError, List<Uint8List>> _validatePayloads({
  required List<Uint8List> payloads,
  required Uint8List authorizationScope,
}) {
  if (authorizationScope != _buildScope()) {
    return const Either.left(_ValidationError.authorizationNotValid());
  }
  if (payloads.length > maxPayloadsPerSigningRequest) {
    return const Either.left(_ValidationError.tooManyPayloads());
  }

  final valids = payloads.map((it) => it.isNotEmpty).toList();
  if (valids.any((i) => !i)) {
    return Either.left(_ValidationError.invalidPayloads(valids));
  }

  return Either.right(payloads);
}

@freezed
class _ValidationError with _$_ValidationError {
  const factory _ValidationError.invalidPayloads(List<bool> valids) =
      _InvalidPayload;

  const factory _ValidationError.tooManyPayloads() = _TooManyPayloads;

  const factory _ValidationError.authorizationNotValid() =
      _AuthorizationNotValid;
}

Uint8List _buildScope() => [_scopeTag, _qualifier]
    .whereType<String>()
    .join(',')
    .let(utf8.encode)
    .let(Uint8List.fromList);

const String _scopeTag = 'app';
const String? _qualifier = null;
