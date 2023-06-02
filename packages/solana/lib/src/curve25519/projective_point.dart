import 'package:solana/src/curve25519/completed_point.dart';
import 'package:solana/src/curve25519/edwards_point.dart';
import 'package:solana/src/curve25519/field_element.dart';

class ProjectivePoint {
  const ProjectivePoint(this._x, this._y, this._z);

  final FieldElement _x;
  final FieldElement _y;
  final FieldElement _z;

  EdwardsPoint toExtended() => EdwardsPoint(
        _x * _z,
        _y * _z,
        _z.square(),
        _x * _y,
      );

  CompletedPoint dbl() {
    final xx = _x.square();
    final yy = _y.square();
    final zz2 = _z.squareAndDouble();
    final xPlusY = _x + _y;
    final xPlusYSq = xPlusY.square();
    final yyPlusXX = yy + xx;
    final yyMinusXX = yy - xx;

    return CompletedPoint(
      xPlusYSq - yyPlusXX,
      yyPlusXX,
      yyMinusXX,
      zz2 - yyMinusXX,
    );
  }
}
