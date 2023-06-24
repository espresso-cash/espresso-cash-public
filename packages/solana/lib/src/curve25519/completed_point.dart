import 'package:solana/src/curve25519/edwards_point.dart';
import 'package:solana/src/curve25519/field_element.dart';
import 'package:solana/src/curve25519/projective_point.dart';

class CompletedPoint {
  const CompletedPoint(this._x, this._y, this._z, this._t);

  final FieldElement _x;
  final FieldElement _y;
  final FieldElement _z;
  final FieldElement _t;

  ProjectivePoint toProjective() => ProjectivePoint(
        _x * _t,
        _y * _z,
        _z * _t,
      );

  EdwardsPoint toExtended() => EdwardsPoint(
        _x * _t,
        _y * _z,
        _z * _t,
        _x * _y,
      );
}
