//
//  Generated code. Do not modify.
//  source: api/users/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $8;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$login = $grpc.ClientMethod<$8.LoginRequest, $8.LoginResponse>(
      '/espressocash.api.users.v1.UserService/Login',
      ($8.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.LoginResponse.fromBuffer(value));
  static final _$getWalletProofMessage =
      $grpc.ClientMethod<$8.GetWalletProofMessageRequest, $8.GetWalletProofMessageResponse>(
          '/espressocash.api.users.v1.UserService/GetWalletProofMessage',
          ($8.GetWalletProofMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.GetWalletProofMessageResponse.fromBuffer(value));
  static final _$updateCountry =
      $grpc.ClientMethod<$8.UpdateCountryRequest, $8.UpdateCountryResponse>(
          '/espressocash.api.users.v1.UserService/UpdateCountry',
          ($8.UpdateCountryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.UpdateCountryResponse.fromBuffer(value));

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$8.LoginResponse> login($8.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetWalletProofMessageResponse> getWalletProofMessage(
      $8.GetWalletProofMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletProofMessage, request, options: options);
  }

  $grpc.ResponseFuture<$8.UpdateCountryResponse> updateCountry($8.UpdateCountryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCountry, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.users.v1.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.LoginRequest, $8.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.LoginRequest.fromBuffer(value),
        ($8.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$8.GetWalletProofMessageRequest, $8.GetWalletProofMessageResponse>(
            'GetWalletProofMessage',
            getWalletProofMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $8.GetWalletProofMessageRequest.fromBuffer(value),
            ($8.GetWalletProofMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.UpdateCountryRequest, $8.UpdateCountryResponse>(
        'UpdateCountry',
        updateCountry_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.UpdateCountryRequest.fromBuffer(value),
        ($8.UpdateCountryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$8.LoginResponse> login_Pre(
      $grpc.ServiceCall $call, $async.Future<$8.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$8.GetWalletProofMessageResponse> getWalletProofMessage_Pre(
      $grpc.ServiceCall $call, $async.Future<$8.GetWalletProofMessageRequest> $request) async {
    return getWalletProofMessage($call, await $request);
  }

  $async.Future<$8.UpdateCountryResponse> updateCountry_Pre(
      $grpc.ServiceCall $call, $async.Future<$8.UpdateCountryRequest> $request) async {
    return updateCountry($call, await $request);
  }

  $async.Future<$8.LoginResponse> login($grpc.ServiceCall call, $8.LoginRequest request);
  $async.Future<$8.GetWalletProofMessageResponse> getWalletProofMessage(
      $grpc.ServiceCall call, $8.GetWalletProofMessageRequest request);
  $async.Future<$8.UpdateCountryResponse> updateCountry(
      $grpc.ServiceCall call, $8.UpdateCountryRequest request);
}
