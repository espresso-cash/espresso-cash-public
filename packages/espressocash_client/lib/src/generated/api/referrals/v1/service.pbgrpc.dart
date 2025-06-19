//
//  Generated code. Do not modify.
//  source: api/referrals/v1/service.proto
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

import 'service.pb.dart' as $4;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.referrals.v1.ReferralService')
class ReferralServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$addReferral = $grpc.ClientMethod<$4.AddReferralRequest, $4.AddReferralResponse>(
      '/espressocash.api.referrals.v1.ReferralService/AddReferral',
      ($4.AddReferralRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.AddReferralResponse.fromBuffer(value));
  static final _$getStats = $grpc.ClientMethod<$4.GetStatsRequest, $4.GetStatsResponse>(
      '/espressocash.api.referrals.v1.ReferralService/GetStats',
      ($4.GetStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetStatsResponse.fromBuffer(value));
  static final _$verify = $grpc.ClientMethod<$4.VerifyRequest, $4.VerifyResponse>(
      '/espressocash.api.referrals.v1.ReferralService/Verify',
      ($4.VerifyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.VerifyResponse.fromBuffer(value));

  ReferralServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$4.AddReferralResponse> addReferral($4.AddReferralRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addReferral, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetStatsResponse> getStats($4.GetStatsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStats, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyResponse> verify($4.VerifyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verify, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.referrals.v1.ReferralService')
abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.referrals.v1.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.AddReferralRequest, $4.AddReferralResponse>(
        'AddReferral',
        addReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.AddReferralRequest.fromBuffer(value),
        ($4.AddReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetStatsRequest, $4.GetStatsResponse>(
        'GetStats',
        getStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetStatsRequest.fromBuffer(value),
        ($4.GetStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyRequest, $4.VerifyResponse>(
        'Verify',
        verify_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.VerifyRequest.fromBuffer(value),
        ($4.VerifyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.AddReferralResponse> addReferral_Pre(
      $grpc.ServiceCall $call, $async.Future<$4.AddReferralRequest> $request) async {
    return addReferral($call, await $request);
  }

  $async.Future<$4.GetStatsResponse> getStats_Pre(
      $grpc.ServiceCall $call, $async.Future<$4.GetStatsRequest> $request) async {
    return getStats($call, await $request);
  }

  $async.Future<$4.VerifyResponse> verify_Pre(
      $grpc.ServiceCall $call, $async.Future<$4.VerifyRequest> $request) async {
    return verify($call, await $request);
  }

  $async.Future<$4.AddReferralResponse> addReferral(
      $grpc.ServiceCall call, $4.AddReferralRequest request);
  $async.Future<$4.GetStatsResponse> getStats($grpc.ServiceCall call, $4.GetStatsRequest request);
  $async.Future<$4.VerifyResponse> verify($grpc.ServiceCall call, $4.VerifyRequest request);
}
