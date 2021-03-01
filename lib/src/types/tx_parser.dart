import 'package:meta/meta.dart';
import 'package:solana_dart/src/types/common_tx.dart';
import 'package:solana_dart/src/types/transfer_tx.dart';

class TxParser {
  static List<CommonTx> parse(dynamic data, {@required int timestamp}) {
    dynamic message = data['message'];
    if (message == null) throw ('invalid data, must have a message field');
    List<dynamic> instructions = message['instructions'];
    if (instructions == null) {
      throw ('invalid instructions array');
    } else {
      return instructions.map((dynamic instruction) {
        dynamic parsed = instruction['parsed'];
        switch (parsed['type']) {
          case 'transfer':
            return TransferTx(parsed['info'], timestamp: timestamp);
          default:
            throw ('unsupported transaction type');
        }
      }).toList();
    }
  }
}
