import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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

    final result = await request.when(
      authorizeDapp: _onAuthorized,
      signPayloads: _onSignPayloads,
      signTransactionsForSending: _signTransactionsForSending,
    );

    emit(RemoteRequestState.result(result));
  }

  Future<AuthorizeResult> _onAuthorized(AuthorizeRequest _) async =>
      AuthorizeResult(
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
        (err) async => err.toSignedPayloadResult(),
        (payloads) async {
          final signedPayloads = await request.map(
            transactions: (it) => it.payloads
                .map(SignedTx.fromBytes)
                .resignAll(_account.wallet)
                .letAsync((it) => it.map((it) => it.toByteArray().toList())),
            messages: (it) async => zip2(
              it.payloads,
              await _account.wallet.sign(it.payloads),
            ).map((it) => it.item1 + it.item2.bytes),
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
        (err) async => err.toSignaturesResult(),
        (payloads) async {
          final signedTxs = await payloads
              .map(SignedTx.fromBytes)
              .let((it) => it.resignAll(_account.wallet));

          final results = await Future.wait(
            signedTxs.map(
              (tx) => _sender
                  .send(tx, minContextSlot: BigInt.zero)
                  .letAsync((it) => it.maybeMap(orElse: F, sent: T)),
            ),
          );

          return results.any((e) => !e)
              ? SignaturesResult.invalidPayloads(valid: results)
              : SignaturesResult(
                  signatures: signedTxs
                      .map((it) => it.signatures.first.bytes)
                      .map(Uint8List.fromList)
                      .toList(),
                );
        },
      );
}

Either<_ValidationError, List<Uint8List>> _validatePayloads({
  required List<Uint8List> payloads,
  required Uint8List authorizationScope,
}) {
  if (!authorizationScope.deepEquals(_buildScope())) {
    return const Either.left(_ValidationError.authorizationNotValid());
  }

  if (payloads.length > maxPayloadsPerSigningRequest) {
    return const Either.left(_ValidationError.tooManyPayloads());
  }

  final valids = payloads.map((it) => it.isNotEmpty).toList();

  return valids.any((i) => !i)
      ? Either.left(_ValidationError.invalidPayloads(valids))
      : Either.right(payloads);
}

@freezed
class _ValidationError with _$_ValidationError {
  const factory _ValidationError.invalidPayloads(List<bool> valids) =
      _InvalidPayload;

  const factory _ValidationError.tooManyPayloads() = _TooManyPayloads;

  const factory _ValidationError.authorizationNotValid() =
      _AuthorizationNotValid;
}

extension on _ValidationError {
  SignaturesResult toSignaturesResult() => when(
        invalidPayloads: (it) => SignaturesResult.invalidPayloads(valid: it),
        tooManyPayloads: always(const SignaturesResult.tooManyPayloads()),
        authorizationNotValid:
            always(const SignaturesResult.authorizationNotValid()),
      );

  SignedPayloadResult toSignedPayloadResult() => when(
        invalidPayloads: (it) => SignedPayloadResult.invalidPayloads(valid: it),
        tooManyPayloads: always(const SignedPayloadResult.tooManyPayloads()),
        authorizationNotValid:
            always(const SignedPayloadResult.authorizationNotValid()),
      );
}

Uint8List _buildScope() => [_scopeTag, _qualifier]
    .whereType<String>()
    .join(',')
    .let(utf8.encode)
    .let(Uint8List.fromList);

const String _scopeTag = 'espresso-cash';
const String? _qualifier = null;
