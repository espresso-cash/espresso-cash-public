part of 'curve25519.dart';

final _d = _FieldElement([
  -10913610, 13857413, -15372611, 6949391, 114729, //
  -8787816, -6275908, -3247719, -18696448, -12055116,
]);

class CompressedEdwardsY {
  CompressedEdwardsY(this._data);

  final List<int> _data;

  EdwardsPoint decompress() {
    final y = _FieldElement.fromByteArray(_data);
    final ySquare = y.square();
    final u = ySquare - _FieldElement.one;
    final v = ySquare * _d + _FieldElement.one;
    final sqrt = _FieldElement.sqrtRatioM1(u, v);
    if (sqrt.wasSquare != 1) {
      throw const FormatException('not a valid point');
    }
    final sqrtResult = sqrt.result;
    final isNegative = sqrtResult.isNegative();
    final selector = isNegative && _data.bit(255) == 1 ? 1 : 0;
    final x = (-sqrt.result).select(sqrt.result, selector);
    return EdwardsPoint(x, y, _FieldElement.one, x * y);
  }

  @override
  int get hashCode => _data.hashCode;

  @override
  bool operator ==(Object other) =>
      other is CompressedEdwardsY && _data.compareAll(other._data);
}
