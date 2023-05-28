import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/curve25519/edwards_point.dart';
import 'package:solana/src/curve25519/extensions.dart';
import 'package:solana/src/curve25519/field_element.dart';

final _d = FieldElement(
  [
    -10913610, 13857413, -15372611, 6949391, 114729, //
    -8787816, -6275908, -3247719, -18696448, -12055116,
  ].map(BigInt.from).toList(),
);

@immutable
class CompressedEdwardsY {
  const CompressedEdwardsY(this._data);

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
