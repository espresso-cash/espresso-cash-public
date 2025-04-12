// Autogenerated from Pigeon (v7.2.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum MobileWalletAdapterServerException {
  requestDeclined,
  invalidPayloads,
  tooManyPayloads,
  authorizationNotValid,
  notSubmitted,
}

class AuthorizeRequestDto {
  AuthorizeRequestDto({this.identityName, this.identityUri, this.iconUri});

  String? identityName;

  String? identityUri;

  String? iconUri;

  Object encode() {
    return <Object?>[identityName, identityUri, iconUri];
  }

  static AuthorizeRequestDto decode(Object result) {
    result as List<Object?>;
    return AuthorizeRequestDto(
      identityName: result[0] as String?,
      identityUri: result[1] as String?,
      iconUri: result[2] as String?,
    );
  }
}

class AuthorizeResultDto {
  AuthorizeResultDto({required this.publicKey, this.accountLabel, this.walletUriBase, this.scope});

  Uint8List publicKey;

  String? accountLabel;

  String? walletUriBase;

  Uint8List? scope;

  Object encode() {
    return <Object?>[publicKey, accountLabel, walletUriBase, scope];
  }

  static AuthorizeResultDto decode(Object result) {
    result as List<Object?>;
    return AuthorizeResultDto(
      publicKey: result[0]! as Uint8List,
      accountLabel: result[1] as String?,
      walletUriBase: result[2] as String?,
      scope: result[3] as Uint8List?,
    );
  }
}

class ReauthorizeRequestDto {
  ReauthorizeRequestDto({
    this.identityName,
    this.identityUri,
    this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  String? identityName;

  String? identityUri;

  String? iconRelativeUri;

  String cluster;

  Uint8List authorizationScope;

  Object encode() {
    return <Object?>[identityName, identityUri, iconRelativeUri, cluster, authorizationScope];
  }

  static ReauthorizeRequestDto decode(Object result) {
    result as List<Object?>;
    return ReauthorizeRequestDto(
      identityName: result[0] as String?,
      identityUri: result[1] as String?,
      iconRelativeUri: result[2] as String?,
      cluster: result[3]! as String,
      authorizationScope: result[4]! as Uint8List,
    );
  }
}

class SignedPayloadsResultDto {
  SignedPayloadsResultDto({this.payloads, this.error, this.validPayloads});

  List<Uint8List?>? payloads;

  MobileWalletAdapterServerException? error;

  List<bool?>? validPayloads;

  Object encode() {
    return <Object?>[payloads, error?.index, validPayloads];
  }

  static SignedPayloadsResultDto decode(Object result) {
    result as List<Object?>;
    return SignedPayloadsResultDto(
      payloads: (result[0] as List<Object?>?)?.cast<Uint8List?>(),
      error:
          result[1] != null ? MobileWalletAdapterServerException.values[result[1]! as int] : null,
      validPayloads: (result[2] as List<Object?>?)?.cast<bool?>(),
    );
  }
}

class SignTransactionsRequestDto {
  SignTransactionsRequestDto({
    required this.payloads,
    this.identityName,
    this.identityUri,
    this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  List<Uint8List?> payloads;

  String? identityName;

  String? identityUri;

  String? iconRelativeUri;

  String cluster;

  Uint8List authorizationScope;

  Object encode() {
    return <Object?>[
      payloads,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      authorizationScope,
    ];
  }

  static SignTransactionsRequestDto decode(Object result) {
    result as List<Object?>;
    return SignTransactionsRequestDto(
      payloads: (result[0] as List<Object?>?)!.cast<Uint8List?>(),
      identityName: result[1] as String?,
      identityUri: result[2] as String?,
      iconRelativeUri: result[3] as String?,
      cluster: result[4]! as String,
      authorizationScope: result[5]! as Uint8List,
    );
  }
}

class SignMessagesRequestDto {
  SignMessagesRequestDto({
    required this.payloads,
    this.identityName,
    this.identityUri,
    this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  List<Uint8List?> payloads;

  String? identityName;

  String? identityUri;

  String? iconRelativeUri;

  String cluster;

  Uint8List authorizationScope;

  Object encode() {
    return <Object?>[
      payloads,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      authorizationScope,
    ];
  }

  static SignMessagesRequestDto decode(Object result) {
    result as List<Object?>;
    return SignMessagesRequestDto(
      payloads: (result[0] as List<Object?>?)!.cast<Uint8List?>(),
      identityName: result[1] as String?,
      identityUri: result[2] as String?,
      iconRelativeUri: result[3] as String?,
      cluster: result[4]! as String,
      authorizationScope: result[5]! as Uint8List,
    );
  }
}

class SignAndSendTransactionsRequestDto {
  SignAndSendTransactionsRequestDto({
    this.minContextSlot,
    required this.transactions,
    required this.publicKey,
    this.identityName,
    this.identityUri,
    this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  int? minContextSlot;

  List<Uint8List?> transactions;

  Uint8List publicKey;

  String? identityName;

  String? identityUri;

  String? iconRelativeUri;

  String cluster;

  Uint8List authorizationScope;

  Object encode() {
    return <Object?>[
      minContextSlot,
      transactions,
      publicKey,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      authorizationScope,
    ];
  }

  static SignAndSendTransactionsRequestDto decode(Object result) {
    result as List<Object?>;
    return SignAndSendTransactionsRequestDto(
      minContextSlot: result[0] as int?,
      transactions: (result[1] as List<Object?>?)!.cast<Uint8List?>(),
      publicKey: result[2]! as Uint8List,
      identityName: result[3] as String?,
      identityUri: result[4] as String?,
      iconRelativeUri: result[5] as String?,
      cluster: result[6]! as String,
      authorizationScope: result[7]! as Uint8List,
    );
  }
}

class SignaturesResultDto {
  SignaturesResultDto({this.signatures, this.error, this.validSignatures});

  List<Uint8List?>? signatures;

  MobileWalletAdapterServerException? error;

  List<bool?>? validSignatures;

  Object encode() {
    return <Object?>[signatures, error?.index, validSignatures];
  }

  static SignaturesResultDto decode(Object result) {
    result as List<Object?>;
    return SignaturesResultDto(
      signatures: (result[0] as List<Object?>?)?.cast<Uint8List?>(),
      error:
          result[1] != null ? MobileWalletAdapterServerException.values[result[1]! as int] : null,
      validSignatures: (result[2] as List<Object?>?)?.cast<bool?>(),
    );
  }
}

class DeauthorizeEventDto {
  DeauthorizeEventDto({
    this.identityName,
    this.identityUri,
    this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  String? identityName;

  String? identityUri;

  String? iconRelativeUri;

  String cluster;

  Uint8List authorizationScope;

  Object encode() {
    return <Object?>[identityName, identityUri, iconRelativeUri, cluster, authorizationScope];
  }

  static DeauthorizeEventDto decode(Object result) {
    result as List<Object?>;
    return DeauthorizeEventDto(
      identityName: result[0] as String?,
      identityUri: result[1] as String?,
      iconRelativeUri: result[2] as String?,
      cluster: result[3]! as String,
      authorizationScope: result[4]! as Uint8List,
    );
  }
}

class WalletConfigDto {
  WalletConfigDto({
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
    required this.supportedTransactionVersions,
    required this.noConnectionWarningTimeoutInMs,
  });

  bool supportsSignAndSendTransactions;

  int maxTransactionsPerSigningRequest;

  int maxMessagesPerSigningRequest;

  List<String?> supportedTransactionVersions;

  int noConnectionWarningTimeoutInMs;

  Object encode() {
    return <Object?>[
      supportsSignAndSendTransactions,
      maxTransactionsPerSigningRequest,
      maxMessagesPerSigningRequest,
      supportedTransactionVersions,
      noConnectionWarningTimeoutInMs,
    ];
  }

  static WalletConfigDto decode(Object result) {
    result as List<Object?>;
    return WalletConfigDto(
      supportsSignAndSendTransactions: result[0]! as bool,
      maxTransactionsPerSigningRequest: result[1]! as int,
      maxMessagesPerSigningRequest: result[2]! as int,
      supportedTransactionVersions: (result[3] as List<Object?>?)!.cast<String?>(),
      noConnectionWarningTimeoutInMs: result[4]! as int,
    );
  }
}

class AuthIssuerConfigDto {
  AuthIssuerConfigDto({
    required this.name,
    required this.maxOutstandingTokensPerIdentility,
    required this.authorizationValidityInMs,
    required this.reauthorizationValidityInMs,
    required this.reauthorizationNopDurationInMs,
  });

  String name;

  int maxOutstandingTokensPerIdentility;

  int authorizationValidityInMs;

  int reauthorizationValidityInMs;

  int reauthorizationNopDurationInMs;

  Object encode() {
    return <Object?>[
      name,
      maxOutstandingTokensPerIdentility,
      authorizationValidityInMs,
      reauthorizationValidityInMs,
      reauthorizationNopDurationInMs,
    ];
  }

  static AuthIssuerConfigDto decode(Object result) {
    result as List<Object?>;
    return AuthIssuerConfigDto(
      name: result[0]! as String,
      maxOutstandingTokensPerIdentility: result[1]! as int,
      authorizationValidityInMs: result[2]! as int,
      reauthorizationValidityInMs: result[3]! as int,
      reauthorizationNopDurationInMs: result[4]! as int,
    );
  }
}

class _ApiFlutterCodec extends StandardMessageCodec {
  const _ApiFlutterCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AuthorizeRequestDto) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AuthorizeResultDto) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is DeauthorizeEventDto) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is ReauthorizeRequestDto) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is SignAndSendTransactionsRequestDto) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is SignMessagesRequestDto) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is SignTransactionsRequestDto) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is SignaturesResultDto) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is SignedPayloadsResultDto) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AuthorizeRequestDto.decode(readValue(buffer)!);
      case 129:
        return AuthorizeResultDto.decode(readValue(buffer)!);
      case 130:
        return DeauthorizeEventDto.decode(readValue(buffer)!);
      case 131:
        return ReauthorizeRequestDto.decode(readValue(buffer)!);
      case 132:
        return SignAndSendTransactionsRequestDto.decode(readValue(buffer)!);
      case 133:
        return SignMessagesRequestDto.decode(readValue(buffer)!);
      case 134:
        return SignTransactionsRequestDto.decode(readValue(buffer)!);
      case 135:
        return SignaturesResultDto.decode(readValue(buffer)!);
      case 136:
        return SignedPayloadsResultDto.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class ApiFlutter {
  static const MessageCodec<Object?> codec = _ApiFlutterCodec();

  void onScenarioReady(int id);

  void onScenarioServingClients(int id);

  void onScenarioServingComplete(int id);

  void onScenarioComplete(int id);

  void onScenarioError(int id);

  void onScenarioTeardownComplete(int id);

  void onLowPowerAndNoConnection(int id);

  Future<AuthorizeResultDto?> authorize(AuthorizeRequestDto request, int id);

  Future<bool> reauthorize(ReauthorizeRequestDto request, int id);

  Future<SignedPayloadsResultDto?> signTransactions(SignTransactionsRequestDto request, int id);

  Future<SignedPayloadsResultDto?> signMessages(SignMessagesRequestDto request, int id);

  Future<SignaturesResultDto?> signAndSendTransactions(
    SignAndSendTransactionsRequestDto request,
    int id,
  );

  Future<void> deauthorize(DeauthorizeEventDto event, int id);

  void onNewIntent(bool isInitialIntent);

  static void setup(ApiFlutter? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioReady',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioReady was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioReady was null, expected non-null int.',
          );
          api.onScenarioReady(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioServingClients',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingClients was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingClients was null, expected non-null int.',
          );
          api.onScenarioServingClients(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete was null, expected non-null int.',
          );
          api.onScenarioServingComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioComplete',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioComplete was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioComplete was null, expected non-null int.',
          );
          api.onScenarioComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioError',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioError was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioError was null, expected non-null int.',
          );
          api.onScenarioError(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete was null, expected non-null int.',
          );
          api.onScenarioTeardownComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onLowPowerAndNoConnection',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onLowPowerAndNoConnection was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onLowPowerAndNoConnection was null, expected non-null int.',
          );
          api.onLowPowerAndNoConnection(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.authorize',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final AuthorizeRequestDto? arg_request = (args[0] as AuthorizeRequestDto?);
          assert(
            arg_request != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null, expected non-null AuthorizeRequestDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null, expected non-null int.',
          );
          final AuthorizeResultDto? output = await api.authorize(arg_request!, arg_id!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.reauthorize',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.reauthorize was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final ReauthorizeRequestDto? arg_request = (args[0] as ReauthorizeRequestDto?);
          assert(
            arg_request != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.reauthorize was null, expected non-null ReauthorizeRequestDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.reauthorize was null, expected non-null int.',
          );
          final bool output = await api.reauthorize(arg_request!, arg_id!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.signTransactions',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signTransactions was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final SignTransactionsRequestDto? arg_request = (args[0] as SignTransactionsRequestDto?);
          assert(
            arg_request != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signTransactions was null, expected non-null SignTransactionsRequestDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signTransactions was null, expected non-null int.',
          );
          final SignedPayloadsResultDto? output = await api.signTransactions(arg_request!, arg_id!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.signMessages',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signMessages was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final SignMessagesRequestDto? arg_request = (args[0] as SignMessagesRequestDto?);
          assert(
            arg_request != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signMessages was null, expected non-null SignMessagesRequestDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signMessages was null, expected non-null int.',
          );
          final SignedPayloadsResultDto? output = await api.signMessages(arg_request!, arg_id!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.signAndSendTransactions',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signAndSendTransactions was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final SignAndSendTransactionsRequestDto? arg_request =
              (args[0] as SignAndSendTransactionsRequestDto?);
          assert(
            arg_request != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signAndSendTransactions was null, expected non-null SignAndSendTransactionsRequestDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.signAndSendTransactions was null, expected non-null int.',
          );
          final SignaturesResultDto? output = await api.signAndSendTransactions(
            arg_request!,
            arg_id!,
          );
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.deauthorize',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.deauthorize was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final DeauthorizeEventDto? arg_event = (args[0] as DeauthorizeEventDto?);
          assert(
            arg_event != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.deauthorize was null, expected non-null DeauthorizeEventDto.',
          );
          final int? arg_id = (args[1] as int?);
          assert(
            arg_id != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.deauthorize was null, expected non-null int.',
          );
          await api.deauthorize(arg_event!, arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiFlutter.onNewIntent',
        codec,
        binaryMessenger: binaryMessenger,
      );
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(
            message != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onNewIntent was null.',
          );
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_isInitialIntent = (args[0] as bool?);
          assert(
            arg_isInitialIntent != null,
            'Argument for dev.flutter.pigeon.ApiFlutter.onNewIntent was null, expected non-null bool.',
          );
          api.onNewIntent(arg_isInitialIntent!);
          return;
        });
      }
    }
  }
}

class _ApiHostCodec extends StandardMessageCodec {
  const _ApiHostCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AuthIssuerConfigDto) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is WalletConfigDto) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AuthIssuerConfigDto.decode(readValue(buffer)!);
      case 129:
        return WalletConfigDto.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ApiHost {
  /// Constructor for [ApiHost].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ApiHost({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ApiHostCodec();

  Future<void> start(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.ApiHost.start',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(<Object?>[arg_id]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> close(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.ApiHost.close',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(<Object?>[arg_id]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<Uint8List?> createScenario(
    int arg_id,
    WalletConfigDto arg_walletConfig,
    AuthIssuerConfigDto arg_authIssuerConfig,
  ) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.ApiHost.createScenario',
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_walletConfig, arg_authIssuerConfig])
            as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return (replyList[0] as Uint8List?);
    }
  }
}
