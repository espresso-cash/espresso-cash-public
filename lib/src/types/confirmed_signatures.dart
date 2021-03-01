import 'package:solana_dart/src/types/confirmed_signature.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class ConfirmedSignatures {
  ConfirmedSignatures._(dynamic value)
      : _list = [
          for (var item in value)
            item != null ? ConfirmedSignature.fromDynamic(item) : null
        ];

  ConfirmedSignatures.fromJsonRpcResponseString(String jsonRpcResponseString)
      : this._(JsonRpcResponseObject.getResult(jsonRpcResponseString));

  ConfirmedSignature operator [](int index) =>
      _list == null ? null : _list[index];
  int get length => _list.length;

  final List<ConfirmedSignature> _list;

  String toString() => '$_list';
}
