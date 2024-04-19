import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:socks5_proxy/socks.dart';
import 'package:solana/src/exceptions/http_exception.dart';
import 'package:solana/src/exceptions/json_rpc_exception.dart';
import 'package:solana/src/exceptions/rpc_timeout_exception.dart';
import 'package:solana/src/rpc/json_rpc_request.dart';

class JsonRpcClient {
  JsonRpcClient(
    this._url, {
    required Duration timeout,
    required Map<String, String> customHeaders,
    required Map<String, dynamic> proxyInfo, // {host: String, port: int}
  })  : _timeout = timeout,
        _headers = {..._defaultHeaders, ...customHeaders},
        _proxyInfo = proxyInfo;

  final String _url;
  final Duration _timeout;
  final Map<String, String> _headers;
  final Map<String, dynamic> _proxyInfo;
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

    final response = await _postRequest(JsonRpcRequest.bulk(requests));
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

    final response = await _postRequest(request);
    if (response is _JsonRpcObjectResponse) {
      return response.data;
    }

    throw const FormatException('unexpected jsonrpc response type');
  }

  Future<_JsonRpcResponse> _postRequest(
    JsonRpcRequest request,
  ) async {
    final Uri uri = Uri.parse(_url);
    final HttpClient httpClient = HttpClient();

    try {
      // If proxyInfo is provided, configure the proxy.
      if (_proxyInfo.isNotEmpty) {
        SocksTCPClient.assignToHttpClient(httpClient, [
          ProxySettings(
            InternetAddress(_proxyInfo['host'] as String),
            _proxyInfo['port'] as int,
          ),
        ]);
      }

      final HttpClientRequest httpClientRequest = await httpClient.postUrl(uri);
      _headers
          .forEach((key, value) => httpClientRequest.headers.set(key, value));
      httpClientRequest.write(json.encode(request.toJson()));

      final HttpClientResponse response =
          await httpClientRequest.close().timeout(
        _timeout,
        onTimeout: () {
          throw RpcTimeoutException(
            method: request.method,
            body: json.encode(request.toJson()),
            timeout: _timeout,
          );
        },
      );

      // Consolidate the bytes and parse the response.
      final Uint8List bodyBytes =
          await consolidateHttpClientResponseBytes(response);
      final String responseBody = utf8.decode(bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return _JsonRpcResponse._parse(json.decode(responseBody));
      }

      throw HttpException(statusCode, responseBody);
    } finally {
      httpClient.close();
    }
  }
}

abstract class _JsonRpcResponse {
  const factory _JsonRpcResponse._object(Map<String, dynamic> data) =
      _JsonRpcObjectResponse;

  const factory _JsonRpcResponse._array(List<_JsonRpcObjectResponse> list) =
      _JsonRpcArrayResponse;

  factory _JsonRpcResponse._fromObject(Map<String, dynamic> data) {
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

    return _JsonRpcResponse._object(data);
  }

  factory _JsonRpcResponse._parse(dynamic response) {
    if (response is List<dynamic>) {
      return _JsonRpcResponse._array(
        response.map((dynamic r) {
          if (r is Map<String, dynamic>) {
            return _JsonRpcObjectResponse(r);
          }

          throw const FormatException('cannot parse the jsonrpc response');
        }).toList(growable: false),
      );
    } else if (response is Map<String, dynamic>) {
      return _JsonRpcResponse._fromObject(response);
    }

    throw const FormatException('cannot parse the jsonrpc response');
  }
}

class _JsonRpcObjectResponse implements _JsonRpcResponse {
  const _JsonRpcObjectResponse(this.data);

  final Map<String, dynamic> data;
}

class _JsonRpcArrayResponse implements _JsonRpcResponse {
  const _JsonRpcArrayResponse(this.array);

  final List<_JsonRpcObjectResponse> array;
}

const _defaultHeaders = <String, String>{
  'Content-Type': 'application/json',
};

/// Helper function to consolidate HttpClientResponse bytes.
///
/// Helps ensure HttpClientResponse is fully read before closing the connection.
/// Helper for proxied connections.
Future<Uint8List> consolidateHttpClientResponseBytes(
    HttpClientResponse response) {
  final Completer<Uint8List> completer = Completer<Uint8List>();
  final List<int> bytes = [];
  response.listen(
    bytes.addAll,
    onDone: () => completer.complete(Uint8List.fromList(bytes)),
    onError: completer.completeError,
    cancelOnError: true,
  );

  return completer.future;
}
