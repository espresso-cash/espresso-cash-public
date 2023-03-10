import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../../core/accounts/bl/account.dart';
import '../models/remote_request.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

@injectable
class MobileWalletBloc extends Bloc<MobileWalletEvent, MobileWalletState> {
  MobileWalletBloc(
    this._client, {
    @factoryParam required RemoteRequest request,
    @factoryParam required MyAccount account,
  })  : _account = account,
        super(MobileWalletState.requested(request)) {
    on<MobileWalletEvent>(_eventHandler, transformer: sequential());
  }

  final SolanaClient _client;
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
      reauthorizeDapp: always(null),
      signPayloads: always(const SignedPayloadResult.requestDeclined()),
      sendTransactions: always(const SignedPayloadResult.requestDeclined()),
      signTransactionsForSending:
          always(const SignaturesResult.requestDeclined()),
    );

    emit(MobileWalletState.result(result));
  }

  Future<void> _onAccepted(Emitter<MobileWalletState> emit) async {
    final request = state.whenOrNull(requested: identity);
    if (request == null) return;

    final result = request.map(
      authorizeDapp: (_) => _onAuthorized(
        scopeTag: _scopeTag,
        qualifier: _qualifier,
      ),
      reauthorizeDapp: always(null),
      signPayloads: always(null),
      sendTransactions: always(null),
      signTransactionsForSending: always(null),
    );

    emit(MobileWalletState.result(result));
  }

  AuthorizeResult _onAuthorized({
    required String scopeTag,
    required String? qualifier,
  }) =>
      AuthorizeResult(
        publicKey: Uint8List.fromList(_account.wallet.publicKey.bytes),
        // TODO(rhbrunetto): fix me
        accountLabel: _account.firstName,
        walletUriBase: null,
        scope: Uint8List.fromList(
          utf8.encode([scopeTag, qualifier].whereType<String>().join(',')),
        ),
      );
}

const String _scopeTag = 'app';
const String? _qualifier = null;
