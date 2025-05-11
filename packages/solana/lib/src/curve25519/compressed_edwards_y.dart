import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/curve25519/edwards_point.dart';
import 'package:solana/src/curve25519/extensions.dart';
import 'package:solana/src/curve25519/field_element.dart';

final _d = FieldElement(
  [
    -10_913_610, 13_857_413, -15_372_611, 6_949_391, 114_729, //
    -8_787_816, -6_275_908, -3_247_719, -18_696_448, -12_055_116,
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
    final x = (-sqrtResult).select(sqrtResult, selector);

    return EdwardsPoint(x, y, FieldElement.one, x * y);
  }

  @override
  int get hashCode => _data.hashCode;

  @override
  bool operator ==(Object other) => other is CompressedEdwardsY && _data.compareAll(other._data);
}
