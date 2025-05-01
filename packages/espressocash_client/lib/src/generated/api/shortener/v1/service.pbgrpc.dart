//
//  Generated code. Do not modify.
//  source: api/shortener/v1/service.proto
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

import 'service.pb.dart' as $3;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.shortener.v1.ShortenerService')
class ShortenerServiceClient extends $grpc.Client {
  static final _$shortenLink = $grpc.ClientMethod<$3.ShortenLinkRequest, $3.ShortenLinkResponse>(
      '/espressocash.api.shortener.v1.ShortenerService/ShortenLink',
      ($3.ShortenLinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ShortenLinkResponse.fromBuffer(value));
  static final _$expandLink = $grpc.ClientMethod<$3.ExpandLinkRequest, $3.ExpandLinkResponse>(
      '/espressocash.api.shortener.v1.ShortenerService/ExpandLink',
      ($3.ExpandLinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ExpandLinkResponse.fromBuffer(value));

  ShortenerServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.ShortenLinkResponse> shortenLink($3.ShortenLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$shortenLink, request, options: options);
  }

  $grpc.ResponseFuture<$3.ExpandLinkResponse> expandLink($3.ExpandLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$expandLink, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.shortener.v1.ShortenerService')
abstract class ShortenerServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.shortener.v1.ShortenerService';

  ShortenerServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.ShortenLinkRequest, $3.ShortenLinkResponse>(
        'ShortenLink',
        shortenLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ShortenLinkRequest.fromBuffer(value),
        ($3.ShortenLinkResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ExpandLinkRequest, $3.ExpandLinkResponse>(
        'ExpandLink',
        expandLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ExpandLinkRequest.fromBuffer(value),
        ($3.ExpandLinkResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.ShortenLinkResponse> shortenLink_Pre(
      $grpc.ServiceCall call, $async.Future<$3.ShortenLinkRequest> request) async {
    return shortenLink(call, await request);
  }

  $async.Future<$3.ExpandLinkResponse> expandLink_Pre(
      $grpc.ServiceCall call, $async.Future<$3.ExpandLinkRequest> request) async {
    return expandLink(call, await request);
  }

  $async.Future<$3.ShortenLinkResponse> shortenLink(
      $grpc.ServiceCall call, $3.ShortenLinkRequest request);
  $async.Future<$3.ExpandLinkResponse> expandLink(
      $grpc.ServiceCall call, $3.ExpandLinkRequest request);
}
