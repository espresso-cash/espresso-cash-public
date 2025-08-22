// This is a generated file - do not edit.
//
// Generated from espressocash/api/stellar/v1/service.proto.

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

abstract class StellarServiceBase extends $pb.GeneratedService {
  $async.Future<$0.SubmitTransactionResponse> submitTransaction(
      $pb.ServerContext ctx, $0.SubmitTransactionRequest request);
  $async.Future<$0.GetTransactionResponse> getTransaction(
      $pb.ServerContext ctx, $0.GetTransactionRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SubmitTransaction':
        return $0.SubmitTransactionRequest();
      case 'GetTransaction':
        return $0.GetTransactionRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SubmitTransaction':
        return submitTransaction(ctx, request as $0.SubmitTransactionRequest);
      case 'GetTransaction':
        return getTransaction(ctx, request as $0.GetTransactionRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => StellarServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => StellarServiceBase$messageJson;
}
