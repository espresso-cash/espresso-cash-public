part of 'curve25519.dart';

class EdwardsPoint {
  EdwardsPoint(this._x, this._y, this._z, this._t);

  static final EdwardsPoint identity = EdwardsPoint(
    _FieldElement.zero,
    _FieldElement.one,
    _FieldElement.one,
    _FieldElement.zero,
  );

  late final _FieldElement _x;
  late final _FieldElement _y;
  late final _FieldElement _z;
  late final _FieldElement _t;

  CompressedEdwardsY compress() {
    final _FieldElement r = _z.invert();
    final _FieldElement x = _x * r;
    final _FieldElement y = _y * r;
    final List<int> s = y.toByteArray();
    s[31] |= x.isNegative() << 7;
    return CompressedEdwardsY(s);
  }

  EdwardsPoint _multiplyByCofactor() => _multiplyByPow2(3);

  _ProjectivePoint _toProjective() => _ProjectivePoint(_x, _y, _z);

  EdwardsPoint _multiplyByPow2(int k) {
    if (k <= 0) {
      throw const FormatException('exponent must be positive and non-zero');
    }
    _ProjectivePoint s = _toProjective();
    for (int i = 0; i < k - 1; i++) {
      s = s.dbl().toProjective();
    }
    // Unroll last doubling so we can go directly to extended coordinates.
    return s.dbl().toExtended();
  }

  bool isIdentity() => this == EdwardsPoint.identity;

  bool isSmallOrder() => _multiplyByCofactor().isIdentity();

  @override
  bool operator ==(Object other) =>
      other is EdwardsPoint && compress() == other.compress();

  @override
  int get hashCode => '$_x$_y$_z$_t'.hashCode;
}
