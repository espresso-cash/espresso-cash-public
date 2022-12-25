// Autogenerated from Pigeon (v3.2.9), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class AccountDto {
  AccountDto({
    required this.id,
    required this.name,
    required this.derivationPath,
    required this.publicKeyEncoded,
  });

  int id;
  String name;
  String derivationPath;
  String publicKeyEncoded;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['name'] = name;
    pigeonMap['derivationPath'] = derivationPath;
    pigeonMap['publicKeyEncoded'] = publicKeyEncoded;
    return pigeonMap;
  }

  static AccountDto decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return AccountDto(
      id: pigeonMap['id']! as int,
      name: pigeonMap['name']! as String,
      derivationPath: pigeonMap['derivationPath']! as String,
      publicKeyEncoded: pigeonMap['publicKeyEncoded']! as String,
    );
  }
}

class SeedDto {
  SeedDto({
    required this.authToken,
    required this.name,
    required this.purpose,
    required this.accounts,
  });

  int authToken;
  String name;
  int purpose;
  List<AccountDto?> accounts;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['authToken'] = authToken;
    pigeonMap['name'] = name;
    pigeonMap['purpose'] = purpose;
    pigeonMap['accounts'] = accounts;
    return pigeonMap;
  }

  static SeedDto decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SeedDto(
      authToken: pigeonMap['authToken']! as int,
      name: pigeonMap['name']! as String,
      purpose: pigeonMap['purpose']! as int,
      accounts: (pigeonMap['accounts'] as List<Object?>?)!.cast<AccountDto?>(),
    );
  }
}

class ImplementationLimitsDto {
  ImplementationLimitsDto({
    required this.maxBip32PathDepth,
    this.maxSigningRequests,
    this.maxRequestedSignatures,
    this.maxRequestedPublicKeys,
    this.authPurpose,
  });

  int maxBip32PathDepth;
  int? maxSigningRequests;
  int? maxRequestedSignatures;
  int? maxRequestedPublicKeys;
  int? authPurpose;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['maxBip32PathDepth'] = maxBip32PathDepth;
    pigeonMap['maxSigningRequests'] = maxSigningRequests;
    pigeonMap['maxRequestedSignatures'] = maxRequestedSignatures;
    pigeonMap['maxRequestedPublicKeys'] = maxRequestedPublicKeys;
    pigeonMap['authPurpose'] = authPurpose;
    return pigeonMap;
  }

  static ImplementationLimitsDto decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return ImplementationLimitsDto(
      maxBip32PathDepth: pigeonMap['maxBip32PathDepth']! as int,
      maxSigningRequests: pigeonMap['maxSigningRequests'] as int?,
      maxRequestedSignatures: pigeonMap['maxRequestedSignatures'] as int?,
      maxRequestedPublicKeys: pigeonMap['maxRequestedPublicKeys'] as int?,
      authPurpose: pigeonMap['authPurpose'] as int?,
    );
  }
}

class _ApiHostCodec extends StandardMessageCodec {
  const _ApiHostCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AccountDto) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is ImplementationLimitsDto) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
    if (value is SeedDto) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return AccountDto.decode(readValue(buffer)!);
      
      case 129:       
        return ImplementationLimitsDto.decode(readValue(buffer)!);
      
      case 130:       
        return SeedDto.decode(readValue(buffer)!);
      
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

  Future<ImplementationLimitsDto> getImplementationLimitsForPurpose(int arg_purpose) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.getImplementationLimitsForPurpose', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_purpose]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as ImplementationLimitsDto?)!;
    }
  }

  Future<bool> hasUnauthorizedSeedsForPurpose(int arg_purpose) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.hasUnauthorizedSeedsForPurpose', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_purpose]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as bool?)!;
    }
  }

  Future<bool> isAvailable(bool arg_allowSimulated) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.isAvailable', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_allowSimulated]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as bool?)!;
    }
  }

  Future<List<SeedDto?>> getAuthorizedSeeds() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.getAuthorizedSeeds', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as List<Object?>?)!.cast<SeedDto?>();
    }
  }

  Future<List<AccountDto?>> getAccounts(int arg_authToken) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.getAccounts', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_authToken]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as List<Object?>?)!.cast<AccountDto?>();
    }
  }

  Future<String> getAccountByLevel(int arg_bipLevel) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.getAccountByLevel', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_bipLevel]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as String?)!;
    }
  }
}
