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

import 'service.pb.dart' as $5;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$5.LoginRequest, $5.LoginResponse>(
      '/espressocash.api.users.v1.UserService/Login',
      ($5.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.LoginResponse.fromBuffer(value));
  static final _$getWalletProofMessage = $grpc.ClientMethod<
          $5.GetWalletProofMessageRequest, $5.GetWalletProofMessageResponse>(
      '/espressocash.api.users.v1.UserService/GetWalletProofMessage',
      ($5.GetWalletProofMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.GetWalletProofMessageResponse.fromBuffer(value));
  static final _$updateCountry =
      $grpc.ClientMethod<$5.UpdateCountryRequest, $5.UpdateCountryResponse>(
          '/espressocash.api.users.v1.UserService/UpdateCountry',
          ($5.UpdateCountryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.UpdateCountryResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.LoginResponse> login($5.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$5.GetWalletProofMessageResponse> getWalletProofMessage(
      $5.GetWalletProofMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWalletProofMessage, request, options: options);
  }

  $grpc.ResponseFuture<$5.UpdateCountryResponse> updateCountry(
      $5.UpdateCountryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCountry, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.users.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.users.v1.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.LoginRequest, $5.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.LoginRequest.fromBuffer(value),
        ($5.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetWalletProofMessageRequest,
            $5.GetWalletProofMessageResponse>(
        'GetWalletProofMessage',
        getWalletProofMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetWalletProofMessageRequest.fromBuffer(value),
        ($5.GetWalletProofMessageResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.UpdateCountryRequest, $5.UpdateCountryResponse>(
            'UpdateCountry',
            updateCountry_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.UpdateCountryRequest.fromBuffer(value),
            ($5.UpdateCountryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$5.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$5.GetWalletProofMessageResponse> getWalletProofMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.GetWalletProofMessageRequest> request) async {
    return getWalletProofMessage(call, await request);
  }

  $async.Future<$5.UpdateCountryResponse> updateCountry_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.UpdateCountryRequest> request) async {
    return updateCountry(call, await request);
  }

  $async.Future<$5.LoginResponse> login(
      $grpc.ServiceCall call, $5.LoginRequest request);
  $async.Future<$5.GetWalletProofMessageResponse> getWalletProofMessage(
      $grpc.ServiceCall call, $5.GetWalletProofMessageRequest request);
  $async.Future<$5.UpdateCountryResponse> updateCountry(
      $grpc.ServiceCall call, $5.UpdateCountryRequest request);
}
