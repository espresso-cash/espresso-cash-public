part of 'curve25519.dart';

final _d = _FieldElement([
  -10913610, 13857413, -15372611, 6949391, 114729, //
  -8787816, -6275908, -3247719, -18696448, -12055116,
]);

class CompressedEdwardsY {
  CompressedEdwardsY(this.data);

  final List<int> data;

  EdwardsPoint decompress() {
    final _FieldElement y = _FieldElement.fromByteArray(data);
    final _FieldElement ySquare = y.square();
    final _FieldElement u = ySquare - _FieldElement.one;
    final _FieldElement v = ySquare * _d + _FieldElement.one;
    final SqrtRatioM1Result sqrt = _FieldElement.sqrtRatioM1(u, v);
    if (sqrt.wasSquare != 1) {
      throw const FormatException('not a valid point');
    }
    final _FieldElement sqrtResult = sqrt.result;
    final int isNegative = sqrtResult.isNegative();
    final _FieldElement x = (-sqrt.result)
        .select(sqrt.result, isNegative._fastEqual(data._bit(255)));
    return EdwardsPoint(x, y, _FieldElement.one, x * y);
  }

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) =>
      other is CompressedEdwardsY && fastEqual(other) == 1;

  int fastEqual(CompressedEdwardsY other) => data._fastEqual(other.data);
}
