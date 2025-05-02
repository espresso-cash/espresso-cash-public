//
//  Generated code. Do not modify.
//  source: api/tokens/v1/service.proto
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

import 'service.pb.dart' as $7;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.tokens.v1.TokensService')
class TokensServiceClient extends $grpc.Client {
  static final _$getTokensMeta =
      $grpc.ClientMethod<$7.GetTokensMetaRequest, $7.GetTokensMetaResponse>(
          '/espressocash.api.tokens.v1.TokensService/GetTokensMeta',
          ($7.GetTokensMetaRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.GetTokensMetaResponse.fromBuffer(value));
  static final _$getTokensFile =
      $grpc.ClientMethod<$7.GetTokensFileRequest, $7.GetTokensFileResponse>(
          '/espressocash.api.tokens.v1.TokensService/GetTokensFile',
          ($7.GetTokensFileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.GetTokensFileResponse.fromBuffer(value));

  TokensServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.GetTokensMetaResponse> getTokensMeta($7.GetTokensMetaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTokensMeta, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetTokensFileResponse> getTokensFile($7.GetTokensFileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTokensFile, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.tokens.v1.TokensService')
abstract class TokensServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.tokens.v1.TokensService';

  TokensServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.GetTokensMetaRequest, $7.GetTokensMetaResponse>(
        'GetTokensMeta',
        getTokensMeta_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetTokensMetaRequest.fromBuffer(value),
        ($7.GetTokensMetaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetTokensFileRequest, $7.GetTokensFileResponse>(
        'GetTokensFile',
        getTokensFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetTokensFileRequest.fromBuffer(value),
        ($7.GetTokensFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.GetTokensMetaResponse> getTokensMeta_Pre(
      $grpc.ServiceCall call, $async.Future<$7.GetTokensMetaRequest> request) async {
    return getTokensMeta(call, await request);
  }

  $async.Future<$7.GetTokensFileResponse> getTokensFile_Pre(
      $grpc.ServiceCall call, $async.Future<$7.GetTokensFileRequest> request) async {
    return getTokensFile(call, await request);
  }

  $async.Future<$7.GetTokensMetaResponse> getTokensMeta(
      $grpc.ServiceCall call, $7.GetTokensMetaRequest request);
  $async.Future<$7.GetTokensFileResponse> getTokensFile(
      $grpc.ServiceCall call, $7.GetTokensFileRequest request);
}
