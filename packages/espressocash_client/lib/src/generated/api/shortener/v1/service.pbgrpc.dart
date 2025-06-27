//
//  Generated code. Do not modify.
//  source: api/shortener/v1/service.proto
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

import 'service.pb.dart' as $5;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.shortener.v1.ShortenerService')
class ShortenerServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$shortenLink = $grpc.ClientMethod<$5.ShortenLinkRequest, $5.ShortenLinkResponse>(
      '/espressocash.api.shortener.v1.ShortenerService/ShortenLink',
      ($5.ShortenLinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ShortenLinkResponse.fromBuffer(value));
  static final _$expandLink = $grpc.ClientMethod<$5.ExpandLinkRequest, $5.ExpandLinkResponse>(
      '/espressocash.api.shortener.v1.ShortenerService/ExpandLink',
      ($5.ExpandLinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ExpandLinkResponse.fromBuffer(value));

  ShortenerServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$5.ShortenLinkResponse> shortenLink($5.ShortenLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$shortenLink, request, options: options);
  }

  $grpc.ResponseFuture<$5.ExpandLinkResponse> expandLink($5.ExpandLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$expandLink, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.shortener.v1.ShortenerService')
abstract class ShortenerServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.shortener.v1.ShortenerService';

  ShortenerServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.ShortenLinkRequest, $5.ShortenLinkResponse>(
        'ShortenLink',
        shortenLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ShortenLinkRequest.fromBuffer(value),
        ($5.ShortenLinkResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ExpandLinkRequest, $5.ExpandLinkResponse>(
        'ExpandLink',
        expandLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ExpandLinkRequest.fromBuffer(value),
        ($5.ExpandLinkResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.ShortenLinkResponse> shortenLink_Pre(
      $grpc.ServiceCall $call, $async.Future<$5.ShortenLinkRequest> $request) async {
    return shortenLink($call, await $request);
  }

  $async.Future<$5.ExpandLinkResponse> expandLink_Pre(
      $grpc.ServiceCall $call, $async.Future<$5.ExpandLinkRequest> $request) async {
    return expandLink($call, await $request);
  }

  $async.Future<$5.ShortenLinkResponse> shortenLink(
      $grpc.ServiceCall call, $5.ShortenLinkRequest request);
  $async.Future<$5.ExpandLinkResponse> expandLink(
      $grpc.ServiceCall call, $5.ExpandLinkRequest request);
}
