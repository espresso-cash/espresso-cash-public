import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class AccountInfo {
  AccountInfo({
    this.owner,
    this.lamports,
    this.executable,
    this.rentEpoch,
    this.data,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return AccountInfo();
    return AccountInfo(
      owner: json['owner'],
      lamports: json['lamports'],
      executable: json['executable'],
      rentEpoch: json['rentEpoch'],
      data: json['data'],
    );
  }

  factory AccountInfo.fromJsonRpcResponseString(String value) =>
      AccountInfo.fromJson(JsonRpcResponseObject.getValue(value));

  final String owner;
  final int lamports;
  final bool executable;
  final dynamic data;
  final int rentEpoch;
}
