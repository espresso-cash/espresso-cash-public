// This is a generated file - do not edit.
//
// Generated from espressocash/api/dln/v1/service.proto.

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

abstract class DlnServiceBase extends $pb.GeneratedService {
  $async.Future<$0.GetOutgoingQuoteResponse> getOutgoingQuote(
      $pb.ServerContext ctx, $0.GetOutgoingQuoteRequest request);
  $async.Future<$0.GetIncomingQuoteResponse> getIncomingQuote(
      $pb.ServerContext ctx, $0.GetIncomingQuoteRequest request);
  $async.Future<$0.GetOrderIdResponse> getOrderId(
      $pb.ServerContext ctx, $0.GetOrderIdRequest request);
  $async.Future<$0.GetOrderStatusResponse> getOrderStatus(
      $pb.ServerContext ctx, $0.GetOrderStatusRequest request);
  $async.Future<$0.GetGasFeesResponse> getGasFees(
      $pb.ServerContext ctx, $0.GetGasFeesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetOutgoingQuote':
        return $0.GetOutgoingQuoteRequest();
      case 'GetIncomingQuote':
        return $0.GetIncomingQuoteRequest();
      case 'GetOrderId':
        return $0.GetOrderIdRequest();
      case 'GetOrderStatus':
        return $0.GetOrderStatusRequest();
      case 'GetGasFees':
        return $0.GetGasFeesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetOutgoingQuote':
        return getOutgoingQuote(ctx, request as $0.GetOutgoingQuoteRequest);
      case 'GetIncomingQuote':
        return getIncomingQuote(ctx, request as $0.GetIncomingQuoteRequest);
      case 'GetOrderId':
        return getOrderId(ctx, request as $0.GetOrderIdRequest);
      case 'GetOrderStatus':
        return getOrderStatus(ctx, request as $0.GetOrderStatusRequest);
      case 'GetGasFees':
        return getGasFees(ctx, request as $0.GetGasFeesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => DlnServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => DlnServiceBase$messageJson;
}
