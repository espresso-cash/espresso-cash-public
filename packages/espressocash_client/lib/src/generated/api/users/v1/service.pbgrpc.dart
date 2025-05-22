//
//  Generated code. Do not modify.
//  source: api/users/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $7;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$login = $grpc.ClientMethod<$7.LoginRequest, $7.LoginResponse>(
      '/espressocash.api.users.v1.UserService/Login',
      ($7.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.LoginResponse.fromBuffer(value));
  static final _$getWalletProofMessage =
      $grpc.ClientMethod<$7.GetWalletProofMessageRequest, $7.GetWalletProofMessageResponse>(
          '/espressocash.api.users.v1.UserService/GetWalletProofMessage',
          ($7.GetWalletProofMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.GetWalletProofMessageResponse.fromBuffer(value));
  static final _$updateCountry =
      $grpc.ClientMethod<$7.UpdateCountryRequest, $7.UpdateCountryResponse>(
          '/espressocash.api.users.v1.UserService/UpdateCountry',
          ($7.UpdateCountryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.UpdateCountryResponse.fromBuffer(value));

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$7.LoginResponse> login($7.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetWalletProofMessageResponse> getWalletProofMessage(
      $7.GetWalletProofMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletProofMessage, request, options: options);
  }

  $grpc.ResponseFuture<$7.UpdateCountryResponse> updateCountry($7.UpdateCountryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCountry, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.users.v1.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.LoginRequest, $7.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.LoginRequest.fromBuffer(value),
        ($7.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$7.GetWalletProofMessageRequest, $7.GetWalletProofMessageResponse>(
            'GetWalletProofMessage',
            getWalletProofMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $7.GetWalletProofMessageRequest.fromBuffer(value),
            ($7.GetWalletProofMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UpdateCountryRequest, $7.UpdateCountryResponse>(
        'UpdateCountry',
        updateCountry_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.UpdateCountryRequest.fromBuffer(value),
        ($7.UpdateCountryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.LoginResponse> login_Pre(
      $grpc.ServiceCall $call, $async.Future<$7.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$7.GetWalletProofMessageResponse> getWalletProofMessage_Pre(
      $grpc.ServiceCall $call, $async.Future<$7.GetWalletProofMessageRequest> $request) async {
    return getWalletProofMessage($call, await $request);
  }

  $async.Future<$7.UpdateCountryResponse> updateCountry_Pre(
      $grpc.ServiceCall $call, $async.Future<$7.UpdateCountryRequest> $request) async {
    return updateCountry($call, await $request);
  }

  $async.Future<$7.LoginResponse> login($grpc.ServiceCall call, $7.LoginRequest request);
  $async.Future<$7.GetWalletProofMessageResponse> getWalletProofMessage(
      $grpc.ServiceCall call, $7.GetWalletProofMessageRequest request);
  $async.Future<$7.UpdateCountryResponse> updateCountry(
      $grpc.ServiceCall call, $7.UpdateCountryRequest request);
}
