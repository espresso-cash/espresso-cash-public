//
//  Generated code. Do not modify.
//  source: api/tokens/v1/service.proto
//
// @dart = 3.3

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

@$pb.GrpcServiceName('espressocash.api.tokens.v1.TokensService')
class TokensServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$getTokensMeta = $grpc.ClientMethod<$6.GetTokensMetaRequest, $6.GetTokensMetaResponse>(
      '/espressocash.api.tokens.v1.TokensService/GetTokensMeta',
      ($6.GetTokensMetaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetTokensMetaResponse.fromBuffer(value));
  static final _$getTokensFile = $grpc.ClientMethod<$6.GetTokensFileRequest, $6.GetTokensFileResponse>(
      '/espressocash.api.tokens.v1.TokensService/GetTokensFile',
      ($6.GetTokensFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetTokensFileResponse.fromBuffer(value));

  TokensServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$6.GetTokensMetaResponse> getTokensMeta($6.GetTokensMetaRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTokensMeta, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetTokensFileResponse> getTokensFile($6.GetTokensFileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTokensFile, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.tokens.v1.TokensService')
abstract class TokensServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.tokens.v1.TokensService';

  TokensServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.GetTokensMetaRequest, $6.GetTokensMetaResponse>(
        'GetTokensMeta',
        getTokensMeta_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetTokensMetaRequest.fromBuffer(value),
        ($6.GetTokensMetaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetTokensFileRequest, $6.GetTokensFileResponse>(
        'GetTokensFile',
        getTokensFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetTokensFileRequest.fromBuffer(value),
        ($6.GetTokensFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.GetTokensMetaResponse> getTokensMeta_Pre($grpc.ServiceCall $call, $async.Future<$6.GetTokensMetaRequest> $request) async {
    return getTokensMeta($call, await $request);
  }

  $async.Future<$6.GetTokensFileResponse> getTokensFile_Pre($grpc.ServiceCall $call, $async.Future<$6.GetTokensFileRequest> $request) async {
    return getTokensFile($call, await $request);
  }

  $async.Future<$6.GetTokensMetaResponse> getTokensMeta($grpc.ServiceCall call, $6.GetTokensMetaRequest request);
  $async.Future<$6.GetTokensFileResponse> getTokensFile($grpc.ServiceCall call, $6.GetTokensFileRequest request);
}
