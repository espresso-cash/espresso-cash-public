import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/curve25519/curve25519.dart';

typedef HashFunc = List<int> Function(List<int> m);

abstract class Ed25519Curve {
  // Returns whether the point [data] is on the ed25519 curve.
  static bool isPointOnCurve(Iterable<int> data) {
    if (data.length != 32) {
      throw const FormatException(
        'invalid length, decoded address is not 32 bytes long',
      );
    }
    try {
      final compressed = CompressedEdwardsY(data.toList());
      final point = compressed.decompress();
      return !point.isSmallOrder();
    } on FormatException {
      return false;
    }
  }
}

/// Returns true if [address] is a valid ed25519 point encoded
/// to base58.
bool isValidAddress(String address) {
  final List<int> data = base58.decode(address);
  if (data.length != 32) {
    throw const FormatException(
      'invalid length, decoded address is not 32 bytes long',
    );
  }
  return Ed25519Curve.isPointOnCurve(data);
}
