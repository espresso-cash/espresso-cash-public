import 'package:convert/convert.dart';

const int _bitsPerByte = 8;
const int _hexCharsPerByte = 2;

extension SolanaEncoder on int {
  List<int> toSolanaBytes([int bitSize = 8]) {
    final String padded = toRadixString(16).padLeft(
      _hexCharsPerByte * bitSize ~/ _bitsPerByte,
      '0',
    );
    final List<int> be = hex.decode(padded);
    // Convert to LE
    return List.from(be.reversed);
  }
}
