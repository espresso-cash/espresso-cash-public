import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_client/src/local_association_scenario.dart';

part 'mobile_wallet_adapter_client.freezed.dart';

class MobileWalletAdapterClient {
  MobileWalletAdapterClient(this._scenarioId);

  final int _scenarioId;

  Future<GetCapabilitiesResult> getCapabilities() async {
    final result = await api.getCapabilities(_scenarioId);

    return GetCapabilitiesResult(
      supportsCloneAuthorization: result.supportsCloneAuthorization,
      supportsSignAndSendTransactions: result.supportsSignAndSendTransactions,
      maxTransactionsPerSigningRequest: result.maxTransactionsPerSigningRequest,
      maxMessagesPerSigningRequest: result.maxMessagesPerSigningRequest,
    );
  }

  Future<AuthorizationResult?> authorize({
    Uri? identityUri,
    Uri? iconUri,
    String? identityName,
    String? cluster,
  }) async {
    try {
      final result = await api.authorize(
        _scenarioId,
        identityUri?.toString(),
        iconUri?.toString(),
        identityName,
        cluster,
      );

      return AuthorizationResult(
        authToken: result.authToken,
        publicKey: result.publicKey,
        accountLabel: result.accountLabel,
        walletUriBase: Uri.tryParse(result.walletUriBase ?? ''),
      );
    } on PlatformException {
      return null;
    }
  }

  Future<AuthorizationResult?> reauthorize({
    Uri? identityUri,
    Uri? iconUri,
    String? identityName,
    required String authToken,
  }) async {
    try {
      final result = await api.reauthorize(
        _scenarioId,
        identityUri?.toString(),
        iconUri?.toString(),
        identityName,
        authToken,
      );

      return AuthorizationResult(
        authToken: result.authToken,
        publicKey: result.publicKey,
        accountLabel: result.accountLabel,
        walletUriBase: Uri.tryParse(result.walletUriBase ?? ''),
      );
    } on PlatformException {
      return null;
    }
  }
}

@freezed
class GetCapabilitiesResult with _$GetCapabilitiesResult {
  const factory GetCapabilitiesResult({
    required bool supportsCloneAuthorization,
    required bool supportsSignAndSendTransactions,
    required int maxTransactionsPerSigningRequest,
    required int maxMessagesPerSigningRequest,
  }) = _GetCapabilitiesResult;
}

@freezed
class AuthorizationResult with _$AuthorizationResult {
  const factory AuthorizationResult({
    required String authToken,
    required Uint8List publicKey,
    required String? accountLabel,
    required Uri? walletUriBase,
  }) = _AuthorizationResult;
}
