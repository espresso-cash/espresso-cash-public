import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/encoder/compact_u16.dart';

class CompiledMessage {
  CompiledMessage(this.data);

  factory CompiledMessage.fromSignedTransaction(ByteArray data) {
    final signaturesCount = CompactU16.raw(data).value;

    return CompiledMessage(data.skip(1 + signaturesCount * signatureLength));
  }

  int get requiredSignatureCount => data.first;

  final ByteArray data;
}
