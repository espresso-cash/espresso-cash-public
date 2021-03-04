import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

part 'account_info.g.dart';

@JsonSerializable(createToJson: false)
class AccountInfo {
  AccountInfo({
    this.owner,
    this.lamports,
    this.executable,
    this.rentEpoch,
    this.data,
  }) {
    if (owner == null) throw ('`owner\' must never be `null\'');
  }

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  factory AccountInfo.fromJsonRpcResponseString(String value) =>
      AccountInfo.fromJson(JsonRpcResponseObject.getValue(value));

  final String owner;
  final int lamports;
  final bool executable;
  final dynamic data;
  final int rentEpoch;
}
