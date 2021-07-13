import 'package:solana/src/common/byte_array.dart';

class CompiledMessage {
  CompiledMessage({
    required this.data,
    required this.requiredSignatureCount,
  });

  final int requiredSignatureCount;

  final ByteArray data;
}
