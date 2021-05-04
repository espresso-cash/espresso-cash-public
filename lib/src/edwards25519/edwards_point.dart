import 'package:solana/src/edwards25519/compressed_edwards_y.dart';
import 'package:solana/src/edwards25519/field_element.dart';
import 'package:solana/src/edwards25519/projective_point.dart';

class EdwardsPoint {
  EdwardsPoint(this._x, this._y, this._z, this._t);

  static final EdwardsPoint identity = EdwardsPoint(
    FieldElement.zero,
    FieldElement.one,
    FieldElement.one,
    FieldElement.zero,
  );

  late final FieldElement _x;
  late final FieldElement _y;
  late final FieldElement _z;

  // ignore: unused_field
  late final FieldElement _t;

  CompressedEdwardsY compress() {
    final FieldElement r = _z.invert();
    final FieldElement x = _x * r;
    final FieldElement y = _y * r;
    final List<int> s = y.toByteArray();
    s[31] |= x.isNegative() << 7;
    return CompressedEdwardsY(s);
  }

  EdwardsPoint multiplyByCofactor() => multiplyByPow2(3);

  ProjectivePoint toProjective() => ProjectivePoint(_x, _y, _z);

  EdwardsPoint multiplyByPow2(int k) {
    if (k <= 0) {
      throw Exception('Exponent must be positive and non-zero');
    }
    ProjectivePoint s = toProjective();
    for (int i = 0; i < k - 1; i++) {
      s = s.dbl().toProjective();
    }
    // Unroll last doubling so we can go directly to extended coordinates.
    return s.dbl().toExtended();
  }

  bool isIdentity() => constantTimeEqual(EdwardsPoint.identity) == 1;

  bool isSmallOrder() => multiplyByCofactor().isIdentity();

  int constantTimeEqual(EdwardsPoint other) =>
      compress().constantTimeEqual(other.compress());
}
