import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class AccountInfo {
  AccountInfo._(dynamic value)
      : owner = value['owner'],
        lamports = BigInt.from(value['lamports']),
        executable = value['executable'],
        data = value['data'],
        rentEpoch = value['rentEpoch'] {
    if (owner == null) throw ('`owner\' must never be `null\'');
  }

  @override
  AccountInfo.fromJsonRpcResponseString(String value)
      : this._(JsonRpcResponseObject.getValue(value));

  final String owner;
  final BigInt lamports;
  final bool executable;
  final dynamic data;
  final int rentEpoch;
}
