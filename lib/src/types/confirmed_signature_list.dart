import 'package:solana_dart/src/types/confirmed_signature.dart';
import 'package:solana_dart/src/types/confirmed_signatures_iterator.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class ConfirmedSignatureList extends Iterable<ConfirmedSignature> {
  ConfirmedSignatureList(this._list);

  final List<ConfirmedSignature> _list;
  ConfirmedSignature operator [](int index) => _list[index];

  factory ConfirmedSignatureList.fromJsonList(List<dynamic> list) =>
      ConfirmedSignatureList(
        list.map((dynamic item) => ConfirmedSignature.fromJson(item)).toList(),
      );

  factory ConfirmedSignatureList.fromJsonRpcResponseString(
          String jsonRpcResponseString) =>
      ConfirmedSignatureList.fromJsonList(
        JsonRpcResponseObject.getResult(jsonRpcResponseString),
      );

  @override
  Iterator<ConfirmedSignature> get iterator =>
      ConfirmedSignatureIterator(_list);
}
