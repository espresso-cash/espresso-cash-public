abstract class JsonRpcRequest {
  const factory JsonRpcRequest.bulk(
    List<JsonRpcSingleRequest> list,
  ) = JsonRpcBulkRequest;

  String get method;

  dynamic toJson();
}

class JsonRpcBulkRequest implements JsonRpcRequest {
  const JsonRpcBulkRequest(this.list);

  @override
  List<dynamic> toJson() =>
      list.map<dynamic>((i) => i.toJson()).toList(growable: false);

  final List<JsonRpcRequest> list;

  @override
  String get method => '[${list.map((e) => e.method).join(', ')}]';
}

class JsonRpcSingleRequest implements JsonRpcRequest {
  const JsonRpcSingleRequest({
    required this.id,
    required this.method,
    this.params,
  });

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'jsonrpc': '2.0',
        'id': id,
        'method': method,
        if (params != null) 'params': params,
      };

  final String id;

  @override
  final String method;

  final List<dynamic>? params;
}
