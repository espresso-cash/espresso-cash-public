import 'package:meta/meta.dart';
import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/types/base_tx.dart';

class TransferTx implements BaseTx {
  TransferTx({
    @required this.source,
    @required this.destination,
    @required this.lamports,
    @required this.timestamp,
  });

  factory TransferTx.fromJson(Map<String, dynamic> json) {
    return TransferTx(
      source: json['source'],
      destination: json['destination'],
      lamports: json['lamports'],
      timestamp: json['timestamp'],
    );
  }

  final String source;
  final String destination;
  final int lamports;
  final int timestamp;

  @override
  String toString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(1000 * timestamp);
    String amount = (lamports / lamportsPerSol).toStringAsFixed(9);
    return 'transfer from $source to $destination a total of $amount SOL @ $date';
  }
}
