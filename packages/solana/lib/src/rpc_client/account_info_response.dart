import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'account_info_response.g.dart';

@JsonSerializable(createToJson: false)
class AccountInfoResponse extends JsonRpcResponse<ValueResponse<Account>> {
  AccountInfoResponse(ValueResponse<Account> result) : super(result: result);

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
}
