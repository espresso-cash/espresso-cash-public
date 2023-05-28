import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_client/src/api.dart';
import 'package:solana_mobile_client/src/local_association_scenario.dart';

part 'mobile_wallet_adapter_client.freezed.dart';

class MobileWalletAdapterClient {
  const MobileWalletAdapterClient(this._scenarioId);

  final int _scenarioId;

  Future<GetCapabilitiesResult?> getCapabilities() async {
    try {
      final result = await api.getCapabilities(_scenarioId);

      return GetCapabilitiesResult(
        supportsCloneAuthorization: result.supportsCloneAuthorization,
        supportsSignAndSendTransactions: result.supportsSignAndSendTransactions,
        maxTransactionsPerSigningRequest:
            result.maxTransactionsPerSigningRequest,
        maxMessagesPerSigningRequest: result.maxMessagesPerSigningRequest,
      );
    } on PlatformException {
      return null;
    }
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

  Future<void> deauthorize({
    required String authToken,
  }) async {
    try {
      await api.deauthorize(_scenarioId, authToken);
    } on PlatformException {
      return;
    }
  }

  Future<SignPayloadsResult> signTransactions({
    required List<Uint8List> transactions,
  }) async {
    try {
      final result = await api.signTransactions(_scenarioId, transactions);

      return SignPayloadsResult(
        signedPayloads: result.signedPayloads.whereType<Uint8List>().toList(),
      );
    } on PlatformException {
      return const SignPayloadsResult(signedPayloads: []);
    }
  }

  Future<SignMessagesResult> signMessages({
    required List<Uint8List> messages,
    required List<Uint8List> addresses,
  }) async {
    try {
      final result = await api.signMessages(_scenarioId, messages, addresses);

      return SignMessagesResult(
        signedMessages: result.messages
            .whereType<SignedMessageDto>()
            .map(
              (it) => SignedMessage(
                message: it.message,
                addresses: it.addresses.whereType<Uint8List>().toList(),
                signatures: it.signatures.whereType<Uint8List>().toList(),
              ),
            )
            .toList(),
      );
    } on PlatformException {
      return const SignMessagesResult(signedMessages: []);
    }
  }

  Future<SignAndSendTransactionsResult> signAndSendTransactions({
    required List<Uint8List> transactions,
    int? minContextSlot,
  }) async {
    try {
      final result = await api.signAndSendTransactions(
        _scenarioId,
        transactions,
        minContextSlot,
      );

      return SignAndSendTransactionsResult(
        signatures: result.signatures.whereType<Uint8List>().toList(),
      );
    } on PlatformException {
      return const SignAndSendTransactionsResult(signatures: []);
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

@freezed
class SignPayloadsResult with _$SignPayloadsResult {
  const factory SignPayloadsResult({
    required List<Uint8List> signedPayloads,
  }) = _SignPayloadsResult;
}

@freezed
class SignAndSendTransactionsResult with _$SignAndSendTransactionsResult {
  const factory SignAndSendTransactionsResult({
    required List<Uint8List> signatures,
  }) = _SignAndSendTransactionsResult;
}

@freezed
class SignedMessage with _$SignedMessage {
  const factory SignedMessage({
    required Uint8List message,
    required List<Uint8List> addresses,
    required List<Uint8List> signatures,
  }) = _SignedMessage;
}

@freezed
class SignMessagesResult with _$SignMessagesResult {
  const factory SignMessagesResult({
    required List<SignedMessage> signedMessages,
  }) = _SignMessagesResult;
}
