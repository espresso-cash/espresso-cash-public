import 'package:meta/meta.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class AccountInfo {
  AccountInfo({
    @required this.owner,
    @required this.lamports,
    @required this.executable,
    @required this.rentEpoch,
    this.data,
  });

  factory AccountInfo.nullAccount() => AccountInfo(
        owner: "",
        lamports: 0,
        executable: false,
        rentEpoch: 0,
      );

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return AccountInfo.nullAccount();
    return AccountInfo(
      owner: json['owner'],
      lamports: json['lamports'],
      executable: json['executable'],
      rentEpoch: json['rentEpoch'],
      data: json['data'],
    );
  }

  factory AccountInfo.fromJsonRpcResponseString(String value) =>
      AccountInfo.fromJson(
        JsonRpcResponseObject.getValue(value),
      );

  final String owner;
  final int lamports;
  final bool executable;
  final dynamic data;
  final int rentEpoch;
}
