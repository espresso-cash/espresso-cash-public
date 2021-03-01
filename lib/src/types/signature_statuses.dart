import 'package:solana_dart/src/types/json_rpc_response_object.dart';
import 'package:solana_dart/src/types/signature_status.dart';

class SignatureStatuses {
  SignatureStatuses._(dynamic value)
      : _list = [
          for (var item in value)
            item == null ? null : SignatureStatus.fromDynamic(item)
        ];
  SignatureStatuses.fromJsonRpcResponseString(String jsonString)
      : this._(JsonRpcResponseObject.getValue(jsonString));

  SignatureStatus operator [](int index) => _list == null ? null : _list[index];
  int get length => _list.length;

  String toString() => '$_list';

  final List<SignatureStatus> _list;
}
