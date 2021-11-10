import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'transaction_signature.g.dart';

/// Response of the [`sendTransaction`][send transaction] rpc method.
///
/// [send transaction]: https://docs.solana.com/developing/clients/jsonrpc-api#sendtransaction
typedef TransactionSignature = String;

@JsonSerializable(createToJson: false)
class SignatureResponse extends JsonRpcResponse<TransactionSignature> {
  SignatureResponse(TransactionSignature result) : super(result: result);

  factory SignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$SignatureResponseFromJson(json);
}
