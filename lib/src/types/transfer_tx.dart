import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/types/base_tx.dart';

part 'transfer_tx.g.dart';

@JsonSerializable(createToJson: false)
class TransferTx implements BaseTx {
  TransferTx({
    this.source,
    this.destination,
    this.lamports,
    this.timestamp,
  });

  factory TransferTx.fromJson(Map<String, dynamic> json) =>
      _$TransferTxFromJson(json);

  final String source;
  final String destination;
  final int lamports;
  final int timestamp;

  String toString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(1000 * timestamp);
    String amount = (lamports / LAMPORTS_PER_SOL).toStringAsFixed(9);
    return 'transfer from $source to $destination a total of $amount SOL @ $date';
  }
}
