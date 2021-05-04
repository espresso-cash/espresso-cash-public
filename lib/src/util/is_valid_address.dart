import 'package:solana/src/base58/base58.dart';
import 'package:solana/src/edwards25519/edwards_25519.dart';

bool isValidAddress(String address) {
  try {
    final List<int> data = decode(address);
    final CompressedEdwardsY compressedEdwardsY = CompressedEdwardsY(data);
    final EdwardsPoint edwardsPoint = compressedEdwardsY.decompress();
    return !edwardsPoint.isSmallOrder();
  } on Exception {
    return false;
  }
}
