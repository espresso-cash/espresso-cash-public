import 'package:solana/src/curve25519/edwards_point.dart';
import 'package:solana/src/curve25519/extensions.dart';
import 'package:solana/src/curve25519/field_element.dart';

final _d = FieldElement([
  BigInt.from(-10913610),
  BigInt.from(13857413),
  BigInt.from(-15372611),
  BigInt.from(6949391),
  BigInt.from(114729), //
  BigInt.from(-8787816),
  BigInt.from(-6275908),
  BigInt.from(-3247719),
  BigInt.from(-18696448),
  BigInt.from(-12055116),
]);

class CompressedEdwardsY {
  CompressedEdwardsY(this._data);

  final List<BigInt> _data;

  EdwardsPoint decompress() {
    final y = FieldElement.fromByteArray(_data);
    final ySquare = y.square();
    final u = ySquare - FieldElement.one;
    final v = ySquare * _d + FieldElement.one;
    final sqrt = FieldElement.sqrtRatioM1(u, v);
    if (!sqrt.wasSquare) {
      throw const FormatException('not a valid point');
    }
    final sqrtResult = sqrt.result;
    final isNegative = sqrtResult.isNegative();
    final selector = isNegative && _data.bit(255) == BigInt.one ? 1 : 0;
    final x = (-sqrt.result).select(sqrt.result, selector);

    return EdwardsPoint(x, y, FieldElement.one, x * y);
  }

  @override
  int get hashCode => _data.hashCode;

  @override
  bool operator ==(Object other) =>
      other is CompressedEdwardsY && _data.compareAll(other._data);
}
