import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:solana/src/exceptions/http_exception.dart';
import 'package:solana/src/exceptions/json_rpc_exception.dart';
import 'package:solana/src/exceptions/rpc_timeout_exception.dart';
import 'package:solana/src/rpc/json_rpc_request.dart';

class JsonRpcClient {
  JsonRpcClient(
    this._url, {
    required Duration timeout,
    required Map<String, String> customHeaders,
  })  : _timeout = timeout,
        _headers = {..._defaultHeaders, ...customHeaders};

  final String _url;
  final Duration _timeout;
  final Map<String, String> _headers;

  // Getters used by extensions.
  String get url => _url;
  Duration get timeout => _timeout;
  Map<String, String> get headers => _headers;

  int _lastId = 1;

  Future<List<Map<String, dynamic>>> bulkRequest(
    String method,
    List<List<dynamic>> params,
  ) async {
    final requests = params
        .map(
          (p) => JsonRpcSingleRequest(
            method: method,
            params: p,
            id: (_lastId++).toString(),
          ),
        )
        .toList(growable: false);

    final response = await postRequest(JsonRpcRequest.bulk(requests));
    if (response is _JsonRpcArrayResponse) {
      final elements = response.array;

      return elements
          .map((_JsonRpcObjectResponse item) => item.data)
          .toList(growable: false);
    }

    throw const FormatException('unexpected jsonrpc response type');
  }

  /// Calls the [method] jsonrpc-2.0 method with [params] parameters
  Future<Map<String, dynamic>> request(
    String method, {
    List<dynamic>? params,
  }) async {
    final request = JsonRpcSingleRequest(
      id: (_lastId++).toString(),
      method: method,
      params: params,
    );

    final response = await postRequest(request);
    if (response is _JsonRpcObjectResponse) {
      return response.data;
    }

    throw const FormatException('unexpected jsonrpc response type');
  }

  Future<JsonRpcResponse> postRequest(
    JsonRpcRequest request,
  ) async {
    final body = request.toJson();
    // Perform the POST request
    final Response response = await post(
      Uri.parse(_url),
      headers: _headers,
      body: json.encode(body),
    ).timeout(
      _timeout,
      onTimeout: () => throw RpcTimeoutException(
        method: request.method,
        body: body,
        timeout: _timeout,
      ),
    );
    // Handle the response
    if (response.statusCode == 200) {
      return JsonRpcResponse.parse(json.decode(response.body));
    }

    throw HttpException(response.statusCode, response.body);
  }
}

abstract class JsonRpcResponse {
  const factory JsonRpcResponse._object(Map<String, dynamic> data) =
      _JsonRpcObjectResponse;

  const factory JsonRpcResponse._array(List<_JsonRpcObjectResponse> list) =
      _JsonRpcArrayResponse;

  factory JsonRpcResponse._fromObject(Map<String, dynamic> data) {
    if (data['jsonrpc'] != '2.0') {
      throw const FormatException('invalid jsonrpc-2.0 response');
    }
    if (data['error'] != null) {
      throw JsonRpcException.fromJson(data['error'] as Map<String, dynamic>);
    }
    if (!data.containsKey('result')) {
      throw const FormatException(
        'object has no result field, invalid jsonrpc-2.0',
      );
    }

    return JsonRpcResponse._object(data);
  }

  factory JsonRpcResponse.parse(dynamic response) {
    if (response is List<dynamic>) {
      return JsonRpcResponse._array(
        response.map((dynamic r) {
          if (r is Map<String, dynamic>) {
            return _JsonRpcObjectResponse(r);
          }

          throw const FormatException('cannot parse the jsonrpc response');
        }).toList(growable: false),
      );
    } else if (response is Map<String, dynamic>) {
      return JsonRpcResponse._fromObject(response);
    }

    throw const FormatException('cannot parse the jsonrpc response');
  }
}

class _JsonRpcObjectResponse implements JsonRpcResponse {
  const _JsonRpcObjectResponse(this.data);

  final Map<String, dynamic> data;
}

class _JsonRpcArrayResponse implements JsonRpcResponse {
  const _JsonRpcArrayResponse(this.array);

  final List<_JsonRpcObjectResponse> array;
}

const _defaultHeaders = <String, String>{
  'Content-Type': 'application/json',
};
