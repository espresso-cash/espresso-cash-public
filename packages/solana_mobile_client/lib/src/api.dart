// Autogenerated from Pigeon (v7.2.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class GetCapabilitiesResultDto {
  GetCapabilitiesResultDto({
    required this.supportsCloneAuthorization,
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
  });

  bool supportsCloneAuthorization;

  bool supportsSignAndSendTransactions;

  int maxTransactionsPerSigningRequest;

  int maxMessagesPerSigningRequest;

  Object encode() {
    return <Object?>[
      supportsCloneAuthorization,
      supportsSignAndSendTransactions,
      maxTransactionsPerSigningRequest,
      maxMessagesPerSigningRequest,
    ];
  }

  static GetCapabilitiesResultDto decode(Object result) {
    result as List<Object?>;
    return GetCapabilitiesResultDto(
      supportsCloneAuthorization: result[0]! as bool,
      supportsSignAndSendTransactions: result[1]! as bool,
      maxTransactionsPerSigningRequest: result[2]! as int,
      maxMessagesPerSigningRequest: result[3]! as int,
    );
  }
}

class AuthorizationResultDto {
  AuthorizationResultDto({
    required this.authToken,
    required this.publicKey,
    this.accountLabel,
    this.walletUriBase,
  });

  String authToken;

  Uint8List publicKey;

  String? accountLabel;

  String? walletUriBase;

  Object encode() {
    return <Object?>[
      authToken,
      publicKey,
      accountLabel,
      walletUriBase,
    ];
  }

  static AuthorizationResultDto decode(Object result) {
    result as List<Object?>;
    return AuthorizationResultDto(
      authToken: result[0]! as String,
      publicKey: result[1]! as Uint8List,
      accountLabel: result[2] as String?,
      walletUriBase: result[3] as String?,
    );
  }
}

class SignPayloadsResultDto {
  SignPayloadsResultDto({
    required this.signedPayloads,
  });

  List<Uint8List?> signedPayloads;

  Object encode() {
    return <Object?>[
      signedPayloads,
    ];
  }

  static SignPayloadsResultDto decode(Object result) {
    result as List<Object?>;
    return SignPayloadsResultDto(
      signedPayloads: (result[0] as List<Object?>?)!.cast<Uint8List?>(),
    );
  }
}

class SignAndSendTransactionsResultDto {
  SignAndSendTransactionsResultDto({
    required this.signatures,
  });

  List<Uint8List?> signatures;

  Object encode() {
    return <Object?>[
      signatures,
    ];
  }

  static SignAndSendTransactionsResultDto decode(Object result) {
    result as List<Object?>;
    return SignAndSendTransactionsResultDto(
      signatures: (result[0] as List<Object?>?)!.cast<Uint8List?>(),
    );
  }
}

class SignedMessageDto {
  SignedMessageDto({
    required this.message,
    required this.addresses,
    required this.signatures,
  });

  Uint8List message;

  List<Uint8List?> addresses;

  List<Uint8List?> signatures;

  Object encode() {
    return <Object?>[
      message,
      addresses,
      signatures,
    ];
  }

  static SignedMessageDto decode(Object result) {
    result as List<Object?>;
    return SignedMessageDto(
      message: result[0]! as Uint8List,
      addresses: (result[1] as List<Object?>?)!.cast<Uint8List?>(),
      signatures: (result[2] as List<Object?>?)!.cast<Uint8List?>(),
    );
  }
}

class SignMessagesResultDto {
  SignMessagesResultDto({
    required this.messages,
  });

  List<SignedMessageDto?> messages;

  Object encode() {
    return <Object?>[
      messages,
    ];
  }

  static SignMessagesResultDto decode(Object result) {
    result as List<Object?>;
    return SignMessagesResultDto(
      messages: (result[0] as List<Object?>?)!.cast<SignedMessageDto?>(),
    );
  }
}

class _ApiLocalAssociationScenarioCodec extends StandardMessageCodec {
  const _ApiLocalAssociationScenarioCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AuthorizationResultDto) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is GetCapabilitiesResultDto) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SignAndSendTransactionsResultDto) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is SignMessagesResultDto) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is SignPayloadsResultDto) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is SignedMessageDto) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return AuthorizationResultDto.decode(readValue(buffer)!);
      case 129: 
        return GetCapabilitiesResultDto.decode(readValue(buffer)!);
      case 130: 
        return SignAndSendTransactionsResultDto.decode(readValue(buffer)!);
      case 131: 
        return SignMessagesResultDto.decode(readValue(buffer)!);
      case 132: 
        return SignPayloadsResultDto.decode(readValue(buffer)!);
      case 133: 
        return SignedMessageDto.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ApiLocalAssociationScenario {
  /// Constructor for [ApiLocalAssociationScenario].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ApiLocalAssociationScenario({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ApiLocalAssociationScenarioCodec();

  Future<void> create(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.create', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id]) as List<Object?>?;
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

  Future<void> start(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.start', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id]) as List<Object?>?;
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
        'dev.flutter.pigeon.ApiLocalAssociationScenario.close', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id]) as List<Object?>?;
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

  Future<void> startActivityForResult(int arg_id, String? arg_uriPrefix) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.startActivityForResult', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_uriPrefix]) as List<Object?>?;
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

  Future<GetCapabilitiesResultDto> getCapabilities(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.getCapabilities', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as GetCapabilitiesResultDto?)!;
    }
  }

  Future<AuthorizationResultDto> authorize(int arg_id, String? arg_identityUri, String? arg_iconUri, String? arg_identityName, String? arg_cluster) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.authorize', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_identityUri, arg_iconUri, arg_identityName, arg_cluster]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as AuthorizationResultDto?)!;
    }
  }

  Future<AuthorizationResultDto> reauthorize(int arg_id, String? arg_identityUri, String? arg_iconUri, String? arg_identityName, String arg_authToken) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.reauthorize', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_identityUri, arg_iconUri, arg_identityName, arg_authToken]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as AuthorizationResultDto?)!;
    }
  }

  Future<void> deauthorize(int arg_id, String arg_authToken) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.deauthorize', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_authToken]) as List<Object?>?;
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

  Future<SignPayloadsResultDto> signTransactions(int arg_id, List<Uint8List?> arg_transactions) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.signTransactions', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_transactions]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as SignPayloadsResultDto?)!;
    }
  }

  Future<SignMessagesResultDto> signMessages(int arg_id, List<Uint8List?> arg_messages, List<Uint8List?> arg_addresses) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.signMessages', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_messages, arg_addresses]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as SignMessagesResultDto?)!;
    }
  }

  Future<SignAndSendTransactionsResultDto> signAndSendTransactions(int arg_id, List<Uint8List?> arg_transactions, int? arg_minContextSlot) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiLocalAssociationScenario.signAndSendTransactions', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_id, arg_transactions, arg_minContextSlot]) as List<Object?>?;
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
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as SignAndSendTransactionsResultDto?)!;
    }
  }
}
