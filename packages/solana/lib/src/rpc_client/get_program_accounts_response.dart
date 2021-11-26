import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/account_with_pubkey.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'get_program_accounts_response.g.dart';

@JsonSerializable(createToJson: false)
class GetProgramAccountsResponse
    extends JsonRpcResponse<List<AccountWithPubkey>> {
  GetProgramAccountsResponse(List<AccountWithPubkey> result)
      : super(result: result);

  factory GetProgramAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProgramAccountsResponseFromJson(json);
}
