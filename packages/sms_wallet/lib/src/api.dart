// Autogenerated from Pigeon (v3.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class AuthorizeRequestDto {
  AuthorizeRequestDto({
    this.identityName,
    this.identityUri,
    this.iconUri,
  });

  String? identityName;
  String? identityUri;
  String? iconUri;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['identityName'] = identityName;
    pigeonMap['identityUri'] = identityUri;
    pigeonMap['iconUri'] = iconUri;
    return pigeonMap;
  }

  static AuthorizeRequestDto decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return AuthorizeRequestDto(
      identityName: pigeonMap['identityName'] as String?,
      identityUri: pigeonMap['identityUri'] as String?,
      iconUri: pigeonMap['iconUri'] as String?,
    );
  }
}

class AuthorizeResultDto {
  AuthorizeResultDto({
    required this.publicKey,
    this.accountLabel,
    this.walletUriBase,
    this.scope,
  });

  Uint8List publicKey;
  String? accountLabel;
  String? walletUriBase;
  Uint8List? scope;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['publicKey'] = publicKey;
    pigeonMap['accountLabel'] = accountLabel;
    pigeonMap['walletUriBase'] = walletUriBase;
    pigeonMap['scope'] = scope;
    return pigeonMap;
  }

  static AuthorizeResultDto decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return AuthorizeResultDto(
      publicKey: pigeonMap['publicKey']! as Uint8List,
      accountLabel: pigeonMap['accountLabel'] as String?,
      walletUriBase: pigeonMap['walletUriBase'] as String?,
      scope: pigeonMap['scope'] as Uint8List?,
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
  Future<AuthorizeResultDto?> authorize(AuthorizeRequestDto request, int id);
  static void setup(ApiFlutter? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioReady', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioReady was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioReady was null, expected non-null int.');
          api.onScenarioReady(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioServingClients', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingClients was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingClients was null, expected non-null int.');
          api.onScenarioServingClients(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete was null, expected non-null int.');
          api.onScenarioServingComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioComplete', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioComplete was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioComplete was null, expected non-null int.');
          api.onScenarioComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioError', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioError was null, expected non-null int.');
          api.onScenarioError(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_id = (args[0] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete was null, expected non-null int.');
          api.onScenarioTeardownComplete(arg_id!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ApiFlutter.authorize', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final AuthorizeRequestDto? arg_request =
              (args[0] as AuthorizeRequestDto?);
          assert(arg_request != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null, expected non-null AuthorizeRequestDto.');
          final int? arg_id = (args[1] as int?);
          assert(arg_id != null,
              'Argument for dev.flutter.pigeon.ApiFlutter.authorize was null, expected non-null int.');
          final AuthorizeResultDto? output =
              await api.authorize(arg_request!, arg_id!);
          return output;
        });
      }
    }
  }
}

class _ApiHostCodec extends StandardMessageCodec {
  const _ApiHostCodec();
}

class ApiHost {
  /// Constructor for [ApiHost].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ApiHost({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ApiHostCodec();

  Future<void> start(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.start', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_id]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> close(int arg_id) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ApiHost.close', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_id]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}
