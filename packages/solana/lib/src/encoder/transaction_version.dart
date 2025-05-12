import 'package:solana/src/encoder/byte_array.dart';

enum TransactionVersion {
  legacy,
  v0;

  factory TransactionVersion.fromByteArray(ByteArray data) {
    final byte = data.first;
    final maskedPrefix = byte & 0x7f;

    return maskedPrefix == byte
        ? legacy
        : maskedPrefix == 0
        ? v0
        : throw UnimplementedError('Version $maskedPrefix is not supported');
  }
}
