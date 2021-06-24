part of 'curve25519.dart';

class _ProjectivePoint {
  _ProjectivePoint(this.x, this.y, this.z);

  final _FieldElement x;
  final _FieldElement y;
  final _FieldElement z;

  EdwardsPoint toExtended() => EdwardsPoint(
        x * z,
        y * z,
        z.square(),
        x * y,
      );

  _CompletedPoint dbl() {
    final _FieldElement xx = x.square();
    final _FieldElement yy = y.square();
    final _FieldElement zz2 = z.squareAndDouble();
    final _FieldElement xPlusY = x + y;
    final _FieldElement xPlusYSq = xPlusY.square();
    final _FieldElement yyPlusXX = yy + xx;
    final _FieldElement yyMinusXX = yy - xx;
    return _CompletedPoint(
      xPlusYSq - yyPlusXX,
      yyPlusXX,
      yyMinusXX,
      zz2 - yyMinusXX,
    );
  }
}
