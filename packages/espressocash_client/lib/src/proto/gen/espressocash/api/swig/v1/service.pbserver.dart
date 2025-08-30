// This is a generated file - do not edit.
//
// Generated from espressocash/api/swig/v1/service.proto.

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

abstract class SWIGServiceBase extends $pb.GeneratedService {
  $async.Future<$0.CreateWalletResponse> createWallet(
      $pb.ServerContext ctx, $0.CreateWalletRequest request);
  $async.Future<$0.SubmitCreateWalletResponse> submitCreateWallet(
      $pb.ServerContext ctx, $0.SubmitCreateWalletRequest request);
  $async.Future<$0.PrepareAddAuthorityResponse> prepareAddAuthority(
      $pb.ServerContext ctx, $0.PrepareAddAuthorityRequest request);
  $async.Future<$0.SubmitAddAuthorityResponse> submitAddAuthority(
      $pb.ServerContext ctx, $0.SubmitAddAuthorityRequest request);
  $async.Future<$0.SubmitCreateATAResponse> submitCreateATA(
      $pb.ServerContext ctx, $0.SubmitCreateATARequest request);
  $async.Future<$0.GetWalletAuthoritiesResponse> getWalletAuthorities(
      $pb.ServerContext ctx, $0.GetWalletAuthoritiesRequest request);
  $async.Future<$0.PrepareSignV1Response> prepareSignV1(
      $pb.ServerContext ctx, $0.PrepareSignV1Request request);
  $async.Future<$0.SubmitSignV1Response> submitSignV1(
      $pb.ServerContext ctx, $0.SubmitSignV1Request request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CreateWallet':
        return $0.CreateWalletRequest();
      case 'SubmitCreateWallet':
        return $0.SubmitCreateWalletRequest();
      case 'PrepareAddAuthority':
        return $0.PrepareAddAuthorityRequest();
      case 'SubmitAddAuthority':
        return $0.SubmitAddAuthorityRequest();
      case 'SubmitCreateATA':
        return $0.SubmitCreateATARequest();
      case 'GetWalletAuthorities':
        return $0.GetWalletAuthoritiesRequest();
      case 'PrepareSignV1':
        return $0.PrepareSignV1Request();
      case 'SubmitSignV1':
        return $0.SubmitSignV1Request();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CreateWallet':
        return createWallet(ctx, request as $0.CreateWalletRequest);
      case 'SubmitCreateWallet':
        return submitCreateWallet(ctx, request as $0.SubmitCreateWalletRequest);
      case 'PrepareAddAuthority':
        return prepareAddAuthority(
            ctx, request as $0.PrepareAddAuthorityRequest);
      case 'SubmitAddAuthority':
        return submitAddAuthority(ctx, request as $0.SubmitAddAuthorityRequest);
      case 'SubmitCreateATA':
        return submitCreateATA(ctx, request as $0.SubmitCreateATARequest);
      case 'GetWalletAuthorities':
        return getWalletAuthorities(
            ctx, request as $0.GetWalletAuthoritiesRequest);
      case 'PrepareSignV1':
        return prepareSignV1(ctx, request as $0.PrepareSignV1Request);
      case 'SubmitSignV1':
        return submitSignV1(ctx, request as $0.SubmitSignV1Request);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SWIGServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SWIGServiceBase$messageJson;
}
