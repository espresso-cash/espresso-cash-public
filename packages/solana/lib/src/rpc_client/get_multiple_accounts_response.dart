import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'get_multiple_accounts_response.g.dart';

@JsonSerializable(createToJson: false)
class GetMultipleAccountsResponse
    extends JsonRpcResponse<ValueResponse<List<AccountData>>> {
  GetMultipleAccountsResponse(ValueResponse<List<AccountData>> result)
      : super(result: result);

  factory GetMultipleAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMultipleAccountsResponseFromJson(json);
}
