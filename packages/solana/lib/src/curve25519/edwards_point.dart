import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/curve25519/compressed_edwards_y.dart';
import 'package:solana/src/curve25519/field_element.dart';
import 'package:solana/src/curve25519/projective_point.dart';

@immutable
class EdwardsPoint {
  const EdwardsPoint(this._x, this._y, this._z, this._t);

  static final EdwardsPoint identity = EdwardsPoint(
    FieldElement.zero,
    FieldElement.one,
    FieldElement.one,
    FieldElement.zero,
  );

  final FieldElement _x;
  final FieldElement _y;
  final FieldElement _z;
  final FieldElement _t;

  CompressedEdwardsY compress() {
    final r = _z.invert();
    final x = _x * r;
    final y = _y * r;
    final s = y.toByteArray();
    final shift = x.isNegative() ? BigInt.one : BigInt.zero;
    s[31] |= shift << 7;

    return CompressedEdwardsY(s);
  }

  EdwardsPoint _multiplyByCofactor() => _multiplyByPow2(3);

  ProjectivePoint _toProjective() => ProjectivePoint(_x, _y, _z);

  EdwardsPoint _multiplyByPow2(int k) {
    if (k <= 0) {
      throw const FormatException('exponent must be positive and non-zero');
    }
    ProjectivePoint s = _toProjective();
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
