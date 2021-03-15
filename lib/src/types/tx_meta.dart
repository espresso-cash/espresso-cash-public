import 'package:meta/meta.dart';

class TxMeta {
  TxMeta({
    @required this.err,
    @required this.fee,
  });
  factory TxMeta.fromJson(Map<String, dynamic> json) {
    return TxMeta(
      err: json['err'],
      fee: json['fee'],
    );
  }

  final dynamic err;
  final int fee;
  // TODO add other fields
}
