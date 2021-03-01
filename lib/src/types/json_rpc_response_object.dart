import 'dart:convert';

import 'package:solana_dart/src/types/json_rpc_error.dart';

abstract class JsonRpcResponseObject {
  static dynamic getResult(String jsonRpc2String) {
    dynamic responseObject = json.decode(jsonRpc2String);
    // Make sure we have a reasonable object
    if (responseObject['jsonrpc'] != '2.0')
      throw ('invalid jsonrpc-2.0 response');
    if (responseObject['error'] != null)
      throw JsonRpcError(responseObject['error']);
    if (responseObject['result'] == null)
      throw ('object has no result field, invalid jsonrpc-2.0');
    return responseObject['result'];
  }

  static dynamic getValue(String jsonRpc2String) {
    dynamic result = getResult(jsonRpc2String);
    // If there's no value it's ok, we return null in that case
    return result['value'];
  }
}
