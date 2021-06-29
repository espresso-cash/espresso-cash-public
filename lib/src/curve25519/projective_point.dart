part of 'curve25519.dart';

class _ProjectivePoint {
  _ProjectivePoint(this._x, this._y, this._z);

  final _FieldElement _x;
  final _FieldElement _y;
  final _FieldElement _z;

  EdwardsPoint toExtended() => EdwardsPoint(
        _x * _z,
        _y * _z,
        _z.square(),
        _x * _y,
      );

  _CompletedPoint dbl() {
    final xx = _x.square();
    final yy = _y.square();
    final zz2 = _z.squareAndDouble();
    final xPlusY = _x + _y;
    final xPlusYSq = xPlusY.square();
    final yyPlusXX = yy + xx;
    final yyMinusXX = yy - xx;
    return _CompletedPoint(
      xPlusYSq - yyPlusXX,
      yyPlusXX,
      yyMinusXX,
      zz2 - yyMinusXX,
    );
  }
}
