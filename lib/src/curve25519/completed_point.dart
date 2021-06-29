part of 'curve25519.dart';

class _CompletedPoint {
  _CompletedPoint(this._x, this._y, this._z, this._t);

  final _FieldElement _x;
  final _FieldElement _y;
  final _FieldElement _z;
  final _FieldElement _t;

  _ProjectivePoint toProjective() => _ProjectivePoint(
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
