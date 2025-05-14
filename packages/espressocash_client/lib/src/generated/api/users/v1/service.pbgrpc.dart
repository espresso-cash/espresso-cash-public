//
//  Generated code. Do not modify.
//  source: api/users/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $6;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$6.LoginRequest, $6.LoginResponse>(
      '/espressocash.api.users.v1.UserService/Login',
      ($6.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.LoginResponse.fromBuffer(value));
  static final _$getWalletProofMessage =
      $grpc.ClientMethod<$6.GetWalletProofMessageRequest, $6.GetWalletProofMessageResponse>(
          '/espressocash.api.users.v1.UserService/GetWalletProofMessage',
          ($6.GetWalletProofMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.GetWalletProofMessageResponse.fromBuffer(value));
  static final _$updateCountry =
      $grpc.ClientMethod<$6.UpdateCountryRequest, $6.UpdateCountryResponse>(
          '/espressocash.api.users.v1.UserService/UpdateCountry',
          ($6.UpdateCountryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.UpdateCountryResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$6.LoginResponse> login($6.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetWalletProofMessageResponse> getWalletProofMessage(
      $6.GetWalletProofMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletProofMessage, request, options: options);
  }

  $grpc.ResponseFuture<$6.UpdateCountryResponse> updateCountry($6.UpdateCountryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCountry, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.users.v1.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.LoginRequest, $6.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.LoginRequest.fromBuffer(value),
        ($6.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$6.GetWalletProofMessageRequest, $6.GetWalletProofMessageResponse>(
            'GetWalletProofMessage',
            getWalletProofMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $6.GetWalletProofMessageRequest.fromBuffer(value),
            ($6.GetWalletProofMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.UpdateCountryRequest, $6.UpdateCountryResponse>(
        'UpdateCountry',
        updateCountry_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.UpdateCountryRequest.fromBuffer(value),
        ($6.UpdateCountryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$6.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$6.GetWalletProofMessageResponse> getWalletProofMessage_Pre(
      $grpc.ServiceCall call, $async.Future<$6.GetWalletProofMessageRequest> request) async {
    return getWalletProofMessage(call, await request);
  }

  $async.Future<$6.UpdateCountryResponse> updateCountry_Pre(
      $grpc.ServiceCall call, $async.Future<$6.UpdateCountryRequest> request) async {
    return updateCountry(call, await request);
  }

  $async.Future<$6.LoginResponse> login($grpc.ServiceCall call, $6.LoginRequest request);
  $async.Future<$6.GetWalletProofMessageResponse> getWalletProofMessage(
      $grpc.ServiceCall call, $6.GetWalletProofMessageRequest request);
  $async.Future<$6.UpdateCountryResponse> updateCountry(
      $grpc.ServiceCall call, $6.UpdateCountryRequest request);
}
