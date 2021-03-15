import 'dart:convert';

import 'package:solana_dart/src/types/json_rpc_error.dart';

abstract class JsonRpcResponseObject {
  static dynamic getResult(String jsonRpc2String) {
    final Map<String, dynamic> responseObject =
        json.decode(jsonRpc2String) as Map<String, dynamic>;
    // Make sure we have a reasonable object
    if (responseObject['jsonrpc'] != '2.0') {
      throw JsonRpcError.fromString('invalid jsonrpc-2.0 response');
    }
    if (responseObject['error'] != null) {
      throw JsonRpcError.fromJson(
        responseObject['error'] as Map<String, dynamic>,
      );
    }
    if (responseObject['result'] == null) {
      throw JsonRpcError.fromString(
        'object has no result field, invalid jsonrpc-2.0',
      );
    }
    return responseObject['result'];
  }

  static Map<String, dynamic> getValue(String jsonRpc2String) {
    final dynamic result = getResult(jsonRpc2String);
    // If there's no value it's ok, we return null in that case
    return result['value'] as Map<String, dynamic>;
  }
}
