import 'package:meta/meta.dart';
import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/types/common_tx.dart';

class TransferTx extends CommonTx {
  TransferTx(dynamic info, {@required this.timestamp})
      : source = info['source'],
        destination = info['destination'],
        lamports = info['lamports'];

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
