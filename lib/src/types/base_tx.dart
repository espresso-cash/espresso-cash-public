import 'package:solana_dart/src/types/transfer_tx.dart';

class BaseTx {
  BaseTx();

  factory BaseTx.fromInstruction(dynamic instruction, int timestamp) {
    dynamic parsed = instruction['parsed'];
    switch (parsed['type']) {
      case 'transfer':
        return TransferTx.fromJson({...parsed['info'], 'timestamp': timestamp});
      default:
        throw ('unsupported transaction type');
    }
  }

  factory BaseTx.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> message = json['message'];
    if (message == null) throw ('invalid data, must have a message field');
    List<dynamic> instructions = message['instructions'];
    if (instructions == null) {
      throw ('invalid instructions array');
    } else if (instructions.length > 1) {
      throw ('multiple instructions not yet supported');
    } else {
      return BaseTx.fromInstruction(instructions[0], json['timestamp']);
    }
  }
}
