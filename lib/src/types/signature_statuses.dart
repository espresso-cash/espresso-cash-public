import 'package:crypto_please_solana_lib/src/types/json_rpc_response_object.dart';
import 'package:crypto_please_solana_lib/src/types/signature_status.dart';

class SignatureStatuses {
  SignatureStatuses._(dynamic value)
      : _list = [for (var item in value) SignatureStatus.fromDynamic(item)];
  SignatureStatuses.fromJsonRpcResponseString(String jsonString)
      : this._(JsonRpcResponseObject.getValue(jsonString));

  final List<SignatureStatus> _list;
}
