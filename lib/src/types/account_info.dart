import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';

part 'account_info.g.dart';

@JsonSerializable(createToJson: false)
class AccountInfo {
  AccountInfo({
    required this.owner,
    required this.lamports,
    required this.executable,
    required this.rentEpoch,
    this.data,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  final String owner;
  final int lamports;
  final bool executable;
  final dynamic data;
  final int rentEpoch;
}

@JsonSerializable(createToJson: false)
class AccountInfoResponse extends JsonRpcResponse<ValueResponse<AccountInfo>> {
  AccountInfoResponse(ValueResponse<AccountInfo> result)
      : super(result: result);

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
}
