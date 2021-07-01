import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/account.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'associated_account.g.dart';

@JsonSerializable(createToJson: false)
class AssociatedTokenAccount {
  AssociatedTokenAccount({
    required this.address,
    required this.account,
  });

  factory AssociatedTokenAccount.fromJson(Map<String, dynamic> json) =>
      _$AssociatedTokenAccountFromJson(json);

  @JsonKey(name: 'pubkey')
  final String address;
  final Account account;
}

@JsonSerializable(createToJson: false)
class AssociatedTokenAccountResponse
    extends JsonRpcResponse<ValueResponse<List<AssociatedTokenAccount>>> {
  AssociatedTokenAccountResponse(
      ValueResponse<List<AssociatedTokenAccount>> result)
      : super(result: result);

  factory AssociatedTokenAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AssociatedTokenAccountResponseFromJson(json);
}
