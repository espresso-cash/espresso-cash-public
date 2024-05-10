// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../di.dart';

part 'rpc_client.freezed.dart';
part 'rpc_client.g.dart';

@RestApi()
abstract class JsonRpcClient {
  factory JsonRpcClient({@rpcUrl required Uri baseUrl}) => _JsonRpcClient(
        Dio(),
        baseUrl: baseUrl.toString(),
      );

  @POST('')
  Future<HttpResponse<JsonRpcResponse>> sendRequest(
    @Body() JsonRpcRequest request,
  );
}

@freezed
class JsonRpcRequest with _$JsonRpcRequest {
  const factory JsonRpcRequest({
    @JsonKey(name: 'jsonrpc') @Default('2.0') String version,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'method') required String method,
    @JsonKey(name: 'params') dynamic params,
  }) = _JsonRpcRequest;

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);
}

@freezed
class JsonRpcResponse with _$JsonRpcResponse {
  const factory JsonRpcResponse({
    @JsonKey(name: 'jsonrpc') required String version,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'result') dynamic result,
  }) = _JsonRpcResponse;

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json);
}
