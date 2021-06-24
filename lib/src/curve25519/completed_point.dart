part of 'curve25519.dart';

class _CompletedPoint {
  _CompletedPoint(this.x, this.y, this.z, this.t);

  final _FieldElement x;
  final _FieldElement y;
  final _FieldElement z;
  final _FieldElement t;

  _ProjectivePoint toProjective() => _ProjectivePoint(
        x * t,
        y * z,
        z * t,
      );

  EdwardsPoint toExtended() => EdwardsPoint(
        x * t,
        y * z,
        z * t,
        x * y,
      );
}
