import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/types/account.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';

part 'associated_account.g.dart';

@JsonSerializable(createToJson: false)
class AssociatedAccount {
  AssociatedAccount({
    required this.address,
    required this.account,
  });

  factory AssociatedAccount.fromJson(Map<String, dynamic> json) =>
      _$AssociatedAccountFromJson(json);

  @JsonKey(name: 'pubkey')
  final String address;
  final Account account;
}

@JsonSerializable(createToJson: false)
class AssociatedAccountResponse
    extends JsonRpcResponse<ValueResponse<List<AssociatedAccount>>> {
  AssociatedAccountResponse(ValueResponse<List<AssociatedAccount>> result)
      : super(result: result);

  factory AssociatedAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AssociatedAccountResponseFromJson(json);
}
