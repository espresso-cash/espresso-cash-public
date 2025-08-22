// This is a generated file - do not edit.
//
// Generated from espressocash/api/users/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $0;
import 'service.pbjson.dart';

export 'service.pb.dart';

abstract class UserServiceBase extends $pb.GeneratedService {
  $async.Future<$0.LoginResponse> login(
      $pb.ServerContext ctx, $0.LoginRequest request);
  $async.Future<$0.GetWalletProofMessageResponse> getWalletProofMessage(
      $pb.ServerContext ctx, $0.GetWalletProofMessageRequest request);
  $async.Future<$0.UpdateCountryResponse> updateCountry(
      $pb.ServerContext ctx, $0.UpdateCountryRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Login':
        return $0.LoginRequest();
      case 'GetWalletProofMessage':
        return $0.GetWalletProofMessageRequest();
      case 'UpdateCountry':
        return $0.UpdateCountryRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Login':
        return login(ctx, request as $0.LoginRequest);
      case 'GetWalletProofMessage':
        return getWalletProofMessage(
            ctx, request as $0.GetWalletProofMessageRequest);
      case 'UpdateCountry':
        return updateCountry(ctx, request as $0.UpdateCountryRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UserServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UserServiceBase$messageJson;
}
