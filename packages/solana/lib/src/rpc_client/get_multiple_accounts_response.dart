import 'package:json_annotation/json_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'get_multiple_accounts_response.g.dart';

@JsonSerializable(createToJson: false)
class GetMultipleAccountsResponse
    extends JsonRpcResponse<ValueResponse<List<Account?>>> {
  GetMultipleAccountsResponse(ValueResponse<List<Account?>> result)
      : super(result: result);

  factory GetMultipleAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMultipleAccountsResponseFromJson(json);
}
