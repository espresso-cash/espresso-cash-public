// ignore_for_file: avoid-self-assignment

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/curve25519/extensions.dart';
import 'package:solana/src/curve25519/sqrt_ratio_m1_result.dart';

@immutable
class FieldElement {
  FieldElement(this._t) {
    if (_t.length != 10) {
      throw FormatException(
        'cannot create a `FieldElement\' '
        'from a byte array of length ${_t.length}, it MUST be 10',
      );
    }
  }

  FieldElement.fromByteArray(List<BigInt> input)
      : _t = List.filled(10, BigInt.zero) {
    BigInt h0 = load_4(input, 0);
    BigInt h1 = load_3(input, 4) << 6;
    BigInt h2 = load_3(input, 7) << 5;
    BigInt h3 = load_3(input, 10) << 3;
    BigInt h4 = load_3(input, 13) << 2;
    BigInt h5 = load_4(input, 16);
    BigInt h6 = load_3(input, 20) << 7;
    BigInt h7 = load_3(input, 23) << 5;
    BigInt h8 = load_3(input, 26) << 4;
    BigInt h9 = (load_3(input, 29) & BigInt.from(0x7FFFFF)) << 2;
    BigInt carry0;
    BigInt carry1;
    BigInt carry2;
    BigInt carry3;
    BigInt carry4;
    BigInt carry5;
    BigInt carry6;
    BigInt carry7;
    BigInt carry8;
    BigInt carry9;
    // Remember: 2^255 congruent 19 modulo p
    carry9 = (h9 + (BigInt.one << 24)) >> 25;
    h0 += carry9 * BigInt.from(19);
    h9 -= carry9 << 25;
    carry1 = (h1 + (BigInt.one << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry3 = (h3 + (BigInt.one << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry5 = (h5 + (BigInt.one << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry7 = (h7 + (BigInt.one << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry2 = (h2 + (BigInt.one << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry6 = (h6 + (BigInt.one << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry8 = (h8 + (BigInt.one << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    _t[0] = h0;
    _t[1] = h1;
    _t[2] = h2;
    _t[3] = h3;
    _t[4] = h4;
    _t[5] = h5;
    _t[6] = h6;
    _t[7] = h7;
    _t[8] = h8;
    _t[9] = h9;
  }

  const FieldElement.fromConstList(this._t);

  static final FieldElement zero = FieldElement.fromConstList([
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
  ]);
  static final FieldElement one = FieldElement.fromConstList([
    BigInt.one,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
    BigInt.zero,
  ]);

  final List<BigInt> _t;

  static BigInt load_3(List<BigInt> input, int offset) {
    var result = input[offset] & BigInt.from(0xff);
    result |= (input[offset + 1] & BigInt.from(0xff)) << 8;
    result |= (input[offset + 2] & BigInt.from(0xff)) << 16;

    return result;
  }

  static BigInt load_4(List<BigInt> input, int offset) {
    var result = input[offset] & BigInt.from(0xff);
    result |= (input[offset + 1] & BigInt.from(0xff)) << 8;
    result |= (input[offset + 2] & BigInt.from(0xff)) << 16;
    result |= input[offset + 3] << 24;

    return result & BigInt.from(0xffffffff);
  }

  List<BigInt> toByteArray() {
    BigInt h0 = _t[0];
    BigInt h1 = _t[1];
    BigInt h2 = _t[2];
    BigInt h3 = _t[3];
    BigInt h4 = _t[4];
    BigInt h5 = _t[5];
    BigInt h6 = _t[6];
    BigInt h7 = _t[7];
    BigInt h8 = _t[8];
    BigInt h9 = _t[9];
    BigInt q;
    BigInt carry0;
    BigInt carry1;
    BigInt carry2;
    BigInt carry3;
    BigInt carry4;
    BigInt carry5;
    BigInt carry6;
    BigInt carry7;
    BigInt carry8;
    BigInt carry9;
    // Step 1:
    // Calculate q
    q = (BigInt.from(19) * h9 + (BigInt.from(1) << 24)) >> 25;
    q = (h0 + q) >> 26;
    q = (h1 + q) >> 25;
    q = (h2 + q) >> 26;
    q = (h3 + q) >> 25;
    q = (h4 + q) >> 26;
    q = (h5 + q) >> 25;
    q = (h6 + q) >> 26;
    q = (h7 + q) >> 25;
    q = (h8 + q) >> 26;
    q = (h9 + q) >> 25;
    // r = h - q * p = h - 2^255 * q + 19 * q
    // First add 19 * q then discard the bit 255
    h0 += BigInt.from(19) * q;
    carry0 = h0 >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry1 = h1 >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry2 = h2 >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry3 = h3 >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry4 = h4 >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry5 = h5 >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry6 = h6 >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry7 = h7 >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry8 = h8 >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = h9 >> 25;
    h9 -= carry9 << 25;
    // Step 2 (straight forward conversion):
    final s = List.filled(32, BigInt.zero);
    s[0] = h0;
    s[1] = h0 >> 8;
    s[2] = h0 >> 16;
    s[3] = (h0 >> 24) | (h1 << 2);
    s[4] = h1 >> 6;
    s[5] = h1 >> 14;
    s[6] = (h1 >> 22) | (h2 << 3);
    s[7] = h2 >> 5;
    s[8] = h2 >> 13;
    s[9] = (h2 >> 21) | (h3 << 5);
    s[10] = h3 >> 3;
    s[11] = h3 >> 11;
    s[12] = (h3 >> 19) | (h4 << 6);
    s[13] = h4 >> 2;
    s[14] = h4 >> 10;
    s[15] = h4 >> 18;
    s[16] = h5;
    s[17] = h5 >> 8;
    s[18] = h5 >> 16;
    s[19] = (h5 >> 24) | (h6 << 1);
    s[20] = h6 >> 7;
    s[21] = h6 >> 15;
    s[22] = (h6 >> 23) | (h7 << 3);
    s[23] = h7 >> 5;
    s[24] = h7 >> 13;
    s[25] = (h7 >> 21) | (h8 << 4);
    s[26] = h8 >> 4;
    s[27] = h8 >> 12;
    s[28] = (h8 >> 20) | (h9 << 6);
    s[29] = h9 >> 2;
    s[30] = h9 >> 10;
    s[31] = h9 >> 18;

    return s;
  }

  FieldElement select(FieldElement other, int selector) {
    final b = -selector;
    final result = List.filled(10, BigInt.zero);
    for (int i = 0; i < 10; i++) {
      result[i] = _t[i];
      BigInt x = _t[i] ^ other._t[i];
      x &= BigInt.from(b);
      result[i] ^= x;
    }

    return FieldElement(result);
  }

  FieldElement abs() => select(-this, isNegative() ? 1 : 0);

  bool isNegative() {
    final s = toByteArray();

    return s[0] & BigInt.one == BigInt.one;
  }

  FieldElement operator +(FieldElement val) {
    final g = val._t;
    final h = List.filled(10, BigInt.zero);
    for (int i = 0; i < 10; i++) {
      h[i] = _t[i] + g[i];
    }

    return FieldElement.fromConstList(h);
  }

  FieldElement operator -(FieldElement val) {
    final g = val._t;
    final h = List.filled(10, BigInt.zero);
    for (int i = 0; i < 10; i++) {
      h[i] = _t[i] - g[i];
    }

    return FieldElement.fromConstList(h);
  }

  FieldElement operator -() {
    final h = List.filled(10, BigInt.zero);
    for (int i = 0; i < 10; i++) {
      h[i] = -_t[i];
    }

    return FieldElement.fromConstList(h);
  }

  FieldElement operator *(FieldElement val) {
    final g = val._t;
    final g1_19 = BigInt.from(19) * g[1]; /* 1.959375*2^29 */
    final g2_19 = BigInt.from(19) * g[2]; /* 1.959375*2^30; still ok */
    final g3_19 = BigInt.from(19) * g[3];
    final g4_19 = BigInt.from(19) * g[4];
    final g5_19 = BigInt.from(19) * g[5];
    final g6_19 = BigInt.from(19) * g[6];
    final g7_19 = BigInt.from(19) * g[7];
    final g8_19 = BigInt.from(19) * g[8];
    final g9_19 = BigInt.from(19) * g[9];
    final f1_2 = BigInt.from(2) * _t[1];
    final f3_2 = BigInt.from(2) * _t[3];
    final f5_2 = BigInt.from(2) * _t[5];
    final f7_2 = BigInt.from(2) * _t[7];
    final f9_2 = BigInt.from(2) * _t[9];
    final f0g0 = _t[0] * g[0];
    final f0g1 = _t[0] * g[1];
    final f0g2 = _t[0] * g[2];
    final f0g3 = _t[0] * g[3];
    final f0g4 = _t[0] * g[4];
    final f0g5 = _t[0] * g[5];
    final f0g6 = _t[0] * g[6];
    final f0g7 = _t[0] * g[7];
    final f0g8 = _t[0] * g[8];
    final f0g9 = _t[0] * g[9];
    final f1g0 = _t[1] * g[0];
    final f1g1_2 = f1_2 * g[1];
    final f1g2 = _t[1] * g[2];
    final f1g3_2 = f1_2 * g[3];
    final f1g4 = _t[1] * g[4];
    final f1g5_2 = f1_2 * g[5];
    final f1g6 = _t[1] * g[6];
    final f1g7_2 = f1_2 * g[7];
    final f1g8 = _t[1] * g[8];
    final f1g9_38 = f1_2 * g9_19;
    final f2g0 = _t[2] * g[0];
    final f2g1 = _t[2] * g[1];
    final f2g2 = _t[2] * g[2];
    final f2g3 = _t[2] * g[3];
    final f2g4 = _t[2] * g[4];
    final f2g5 = _t[2] * g[5];
    final f2g6 = _t[2] * g[6];
    final f2g7 = _t[2] * g[7];
    final f2g8_19 = _t[2] * g8_19;
    final f2g9_19 = _t[2] * g9_19;
    final f3g0 = _t[3] * g[0];
    final f3g1_2 = f3_2 * g[1];
    final f3g2 = _t[3] * g[2];
    final f3g3_2 = f3_2 * g[3];
    final f3g4 = _t[3] * g[4];
    final f3g5_2 = f3_2 * g[5];
    final f3g6 = _t[3] * g[6];
    final f3g7_38 = f3_2 * g7_19;
    final f3g8_19 = _t[3] * g8_19;
    final f3g9_38 = f3_2 * g9_19;
    final f4g0 = _t[4] * g[0];
    final f4g1 = _t[4] * g[1];
    final f4g2 = _t[4] * g[2];
    final f4g3 = _t[4] * g[3];
    final f4g4 = _t[4] * g[4];
    final f4g5 = _t[4] * g[5];
    final f4g6_19 = _t[4] * g6_19;
    final f4g7_19 = _t[4] * g7_19;
    final f4g8_19 = _t[4] * g8_19;
    final f4g9_19 = _t[4] * g9_19;
    final f5g0 = _t[5] * g[0];
    final f5g1_2 = f5_2 * g[1];
    final f5g2 = _t[5] * g[2];
    final f5g3_2 = f5_2 * g[3];
    final f5g4 = _t[5] * g[4];
    final f5g5_38 = f5_2 * g5_19;
    final f5g6_19 = _t[5] * g6_19;
    final f5g7_38 = f5_2 * g7_19;
    final f5g8_19 = _t[5] * g8_19;
    final f5g9_38 = f5_2 * g9_19;
    final f6g0 = _t[6] * g[0];
    final f6g1 = _t[6] * g[1];
    final f6g2 = _t[6] * g[2];
    final f6g3 = _t[6] * g[3];
    final f6g4_19 = _t[6] * g4_19;
    final f6g5_19 = _t[6] * g5_19;
    final f6g6_19 = _t[6] * g6_19;
    final f6g7_19 = _t[6] * g7_19;
    final f6g8_19 = _t[6] * g8_19;
    final f6g9_19 = _t[6] * g9_19;
    final f7g0 = _t[7] * g[0];
    final f7g1_2 = f7_2 * g[1];
    final f7g2 = _t[7] * g[2];
    final f7g3_38 = f7_2 * g3_19;
    final f7g4_19 = _t[7] * g4_19;
    final f7g5_38 = f7_2 * g5_19;
    final f7g6_19 = _t[7] * g6_19;
    final f7g7_38 = f7_2 * g7_19;
    final f7g8_19 = _t[7] * g8_19;
    final f7g9_38 = f7_2 * g9_19;
    final f8g0 = _t[8] * g[0];
    final f8g1 = _t[8] * g[1];
    final f8g2_19 = _t[8] * g2_19;
    final f8g3_19 = _t[8] * g3_19;
    final f8g4_19 = _t[8] * g4_19;
    final f8g5_19 = _t[8] * g5_19;
    final f8g6_19 = _t[8] * g6_19;
    final f8g7_19 = _t[8] * g7_19;
    final f8g8_19 = _t[8] * g8_19;
    final f8g9_19 = _t[8] * g9_19;
    final f9g0 = _t[9] * g[0];
    final f9g1_38 = f9_2 * g1_19;
    final f9g2_19 = _t[9] * g2_19;
    final f9g3_38 = f9_2 * g3_19;
    final f9g4_19 = _t[9] * g4_19;
    final f9g5_38 = f9_2 * g5_19;
    final f9g6_19 = _t[9] * g6_19;
    final f9g7_38 = f9_2 * g7_19;
    final f9g8_19 = _t[9] * g8_19;
    final f9g9_38 = f9_2 * g9_19;
    BigInt h0 = f0g0 +
        f1g9_38 +
        f2g8_19 +
        f3g7_38 +
        f4g6_19 +
        f5g5_38 +
        f6g4_19 +
        f7g3_38 +
        f8g2_19 +
        f9g1_38;
    BigInt h1 = f0g1 +
        f1g0 +
        f2g9_19 +
        f3g8_19 +
        f4g7_19 +
        f5g6_19 +
        f6g5_19 +
        f7g4_19 +
        f8g3_19 +
        f9g2_19;
    BigInt h2 = f0g2 +
        f1g1_2 +
        f2g0 +
        f3g9_38 +
        f4g8_19 +
        f5g7_38 +
        f6g6_19 +
        f7g5_38 +
        f8g4_19 +
        f9g3_38;
    BigInt h3 = f0g3 +
        f1g2 +
        f2g1 +
        f3g0 +
        f4g9_19 +
        f5g8_19 +
        f6g7_19 +
        f7g6_19 +
        f8g5_19 +
        f9g4_19;
    BigInt h4 = f0g4 +
        f1g3_2 +
        f2g2 +
        f3g1_2 +
        f4g0 +
        f5g9_38 +
        f6g8_19 +
        f7g7_38 +
        f8g6_19 +
        f9g5_38;
    BigInt h5 = f0g5 +
        f1g4 +
        f2g3 +
        f3g2 +
        f4g1 +
        f5g0 +
        f6g9_19 +
        f7g8_19 +
        f8g7_19 +
        f9g6_19;
    BigInt h6 = f0g6 +
        f1g5_2 +
        f2g4 +
        f3g3_2 +
        f4g2 +
        f5g1_2 +
        f6g0 +
        f7g9_38 +
        f8g8_19 +
        f9g7_38;
    BigInt h7 = f0g7 +
        f1g6 +
        f2g5 +
        f3g4 +
        f4g3 +
        f5g2 +
        f6g1 +
        f7g0 +
        f8g9_19 +
        f9g8_19;
    BigInt h8 = f0g8 +
        f1g7_2 +
        f2g6 +
        f3g5_2 +
        f4g4 +
        f5g3_2 +
        f6g2 +
        f7g1_2 +
        f8g0 +
        f9g9_38;
    BigInt h9 =
        f0g9 + f1g8 + f2g7 + f3g6 + f4g5 + f5g4 + f6g3 + f7g2 + f8g1 + f9g0;
    BigInt carry0;
    BigInt carry1;
    BigInt carry2;
    BigInt carry3;
    BigInt carry4;
    BigInt carry5;
    BigInt carry6;
    BigInt carry7;
    BigInt carry8;
    BigInt carry9;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (BigInt.one << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (BigInt.one << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (BigInt.one << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (BigInt.one << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (BigInt.one << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (BigInt.one << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (BigInt.one << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (BigInt.one << 24)) >> 25;
    h0 += carry9 * BigInt.from(19);
    h9 -= carry9 << 25;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final h = List.filled(10, BigInt.zero);
    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;

    return FieldElement.fromConstList(h);
  }

  FieldElement square() {
    final f0 = _t[0];
    final f1 = _t[1];
    final f2 = _t[2];
    final f3 = _t[3];
    final f4 = _t[4];
    final f5 = _t[5];
    final f6 = _t[6];
    final f7 = _t[7];
    final f8 = _t[8];
    final f9 = _t[9];
    final f0_2 = BigInt.from(2) * f0;
    final f1_2 = BigInt.from(2) * f1;
    final f2_2 = BigInt.from(2) * f2;
    final f3_2 = BigInt.from(2) * f3;
    final f4_2 = BigInt.from(2) * f4;
    final f5_2 = BigInt.from(2) * f5;
    final f6_2 = BigInt.from(2) * f6;
    final f7_2 = BigInt.from(2) * f7;
    final f5_38 = BigInt.from(38) * f5; /* 1.959375*2^30 */
    final f6_19 = BigInt.from(19) * f6; /* 1.959375*2^30 */
    final f7_38 = BigInt.from(38) * f7; /* 1.959375*2^30 */
    final f8_19 = BigInt.from(19) * f8; /* 1.959375*2^30 */
    final f9_38 = BigInt.from(38) * f9; /* 1.959375*2^30 */
    final f0f0 = f0 * f0;
    final f0f1_2 = f0_2 * f1;
    final f0f2_2 = f0_2 * f2;
    final f0f3_2 = f0_2 * f3;
    final f0f4_2 = f0_2 * f4;
    final f0f5_2 = f0_2 * f5;
    final f0f6_2 = f0_2 * f6;
    final f0f7_2 = f0_2 * f7;
    final f0f8_2 = f0_2 * f8;
    final f0f9_2 = f0_2 * f9;
    final f1f1_2 = f1_2 * f1;
    final f1f2_2 = f1_2 * f2;
    final f1f3_4 = f1_2 * f3_2;
    final f1f4_2 = f1_2 * f4;
    final f1f5_4 = f1_2 * f5_2;
    final f1f6_2 = f1_2 * f6;
    final f1f7_4 = f1_2 * f7_2;
    final f1f8_2 = f1_2 * f8;
    final f1f9_76 = f1_2 * f9_38;
    final f2f2 = f2 * f2;
    final f2f3_2 = f2_2 * f3;
    final f2f4_2 = f2_2 * f4;
    final f2f5_2 = f2_2 * f5;
    final f2f6_2 = f2_2 * f6;
    final f2f7_2 = f2_2 * f7;
    final f2f8_38 = f2_2 * f8_19;
    final f2f9_38 = f2 * f9_38;
    final f3f3_2 = f3_2 * f3;
    final f3f4_2 = f3_2 * f4;
    final f3f5_4 = f3_2 * f5_2;
    final f3f6_2 = f3_2 * f6;
    final f3f7_76 = f3_2 * f7_38;
    final f3f8_38 = f3_2 * f8_19;
    final f3f9_76 = f3_2 * f9_38;
    final f4f4 = f4 * f4;
    final f4f5_2 = f4_2 * f5;
    final f4f6_38 = f4_2 * f6_19;
    final f4f7_38 = f4 * f7_38;
    final f4f8_38 = f4_2 * f8_19;
    final f4f9_38 = f4 * f9_38;
    final f5f5_38 = f5 * f5_38;
    final f5f6_38 = f5_2 * f6_19;
    final f5f7_76 = f5_2 * f7_38;
    final f5f8_38 = f5_2 * f8_19;
    final f5f9_76 = f5_2 * f9_38;
    final f6f6_19 = f6 * f6_19;
    final f6f7_38 = f6 * f7_38;
    final f6f8_38 = f6_2 * f8_19;
    final f6f9_38 = f6 * f9_38;
    final f7f7_38 = f7 * f7_38;
    final f7f8_38 = f7_2 * f8_19;
    final f7f9_76 = f7_2 * f9_38;
    final f8f8_19 = f8 * f8_19;
    final f8f9_38 = f8 * f9_38;
    final f9f9_38 = f9 * f9_38;
    BigInt h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    BigInt h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    BigInt h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    BigInt h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    BigInt h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    BigInt h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    BigInt h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    BigInt h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    BigInt h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    BigInt h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
    BigInt carry0;
    BigInt carry1;
    BigInt carry2;
    BigInt carry3;
    BigInt carry4;
    BigInt carry5;
    BigInt carry6;
    BigInt carry7;
    BigInt carry8;
    BigInt carry9;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (BigInt.one << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (BigInt.one << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (BigInt.one << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (BigInt.one << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (BigInt.one << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (BigInt.one << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (BigInt.one << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (BigInt.one << 24)) >> 25;
    h0 += carry9 * BigInt.from(19);
    h9 -= carry9 << 25;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final h = List.filled(10, BigInt.zero);
    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;

    return FieldElement.fromConstList(h);
  }

  FieldElement squareAndDouble() {
    final f0 = _t[0];
    final f1 = _t[1];
    final f2 = _t[2];
    final f3 = _t[3];
    final f4 = _t[4];
    final f5 = _t[5];
    final f6 = _t[6];
    final f7 = _t[7];
    final f8 = _t[8];
    final f9 = _t[9];
    final f0_2 = BigInt.from(2) * f0;
    final f1_2 = BigInt.from(2) * f1;
    final f2_2 = BigInt.from(2) * f2;
    final f3_2 = BigInt.from(2) * f3;
    final f4_2 = BigInt.from(2) * f4;
    final f5_2 = BigInt.from(2) * f5;
    final f6_2 = BigInt.from(2) * f6;
    final f7_2 = BigInt.from(2) * f7;
    final f5_38 = BigInt.from(38) * f5; /* 1.959375*2^30 */
    final f6_19 = BigInt.from(19) * f6; /* 1.959375*2^30 */
    final f7_38 = BigInt.from(38) * f7; /* 1.959375*2^30 */
    final f8_19 = BigInt.from(19) * f8; /* 1.959375*2^30 */
    final f9_38 = BigInt.from(38) * f9; /* 1.959375*2^30 */
    final f0f0 = f0 * f0;
    final f0f1_2 = f0_2 * f1;
    final f0f2_2 = f0_2 * f2;
    final f0f3_2 = f0_2 * f3;
    final f0f4_2 = f0_2 * f4;
    final f0f5_2 = f0_2 * f5;
    final f0f6_2 = f0_2 * f6;
    final f0f7_2 = f0_2 * f7;
    final f0f8_2 = f0_2 * f8;
    final f0f9_2 = f0_2 * f9;
    final f1f1_2 = f1_2 * f1;
    final f1f2_2 = f1_2 * f2;
    final f1f3_4 = f1_2 * f3_2;
    final f1f4_2 = f1_2 * f4;
    final f1f5_4 = f1_2 * f5_2;
    final f1f6_2 = f1_2 * f6;
    final f1f7_4 = f1_2 * f7_2;
    final f1f8_2 = f1_2 * f8;
    final f1f9_76 = f1_2 * f9_38;
    final f2f2 = f2 * f2;
    final f2f3_2 = f2_2 * f3;
    final f2f4_2 = f2_2 * f4;
    final f2f5_2 = f2_2 * f5;
    final f2f6_2 = f2_2 * f6;
    final f2f7_2 = f2_2 * f7;
    final f2f8_38 = f2_2 * f8_19;
    final f2f9_38 = f2 * f9_38;
    final f3f3_2 = f3_2 * f3;
    final f3f4_2 = f3_2 * f4;
    final f3f5_4 = f3_2 * f5_2;
    final f3f6_2 = f3_2 * f6;
    final f3f7_76 = f3_2 * f7_38;
    final f3f8_38 = f3_2 * f8_19;
    final f3f9_76 = f3_2 * f9_38;
    final f4f4 = f4 * f4;
    final f4f5_2 = f4_2 * f5;
    final f4f6_38 = f4_2 * f6_19;
    final f4f7_38 = f4 * f7_38;
    final f4f8_38 = f4_2 * f8_19;
    final f4f9_38 = f4 * f9_38;
    final f5f5_38 = f5 * f5_38;
    final f5f6_38 = f5_2 * f6_19;
    final f5f7_76 = f5_2 * f7_38;
    final f5f8_38 = f5_2 * f8_19;
    final f5f9_76 = f5_2 * f9_38;
    final f6f6_19 = f6 * f6_19;
    final f6f7_38 = f6 * f7_38;
    final f6f8_38 = f6_2 * f8_19;
    final f6f9_38 = f6 * f9_38;
    final f7f7_38 = f7 * f7_38;
    final f7f8_38 = f7_2 * f8_19;
    final f7f9_76 = f7_2 * f9_38;
    final f8f8_19 = f8 * f8_19;
    final f8f9_38 = f8 * f9_38;
    final f9f9_38 = f9 * f9_38;
    BigInt h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    BigInt h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    BigInt h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    BigInt h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    BigInt h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    BigInt h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    BigInt h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    BigInt h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    BigInt h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    BigInt h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
    BigInt carry0;
    BigInt carry1;
    BigInt carry2;
    BigInt carry3;
    BigInt carry4;
    BigInt carry5;
    BigInt carry6;
    BigInt carry7;
    BigInt carry8;
    BigInt carry9;
    h0 += h0;
    h1 += h1;
    h2 += h2;
    h3 += h3;
    h4 += h4;
    h5 += h5;
    h6 += h6;
    h7 += h7;
    h8 += h8;
    h9 += h9;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (BigInt.one << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (BigInt.one << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (BigInt.one << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (BigInt.one << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (BigInt.one << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (BigInt.one << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (BigInt.one << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (BigInt.one << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (BigInt.one << 24)) >> 25;
    h0 += carry9 * BigInt.from(19);
    h9 -= carry9 << 25;
    carry0 = (h0 + (BigInt.one << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final h = List.filled(10, BigInt.zero);
    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;

    return FieldElement.fromConstList(h);
  }

  FieldElement invert() {
    FieldElement t0, t1, t2, t3;
    // 2 == 2 * 1
    t0 = square();
    // 4 == 2 * 2
    t1 = t0.square();
    // 8 == 2 * 4
    t1 = t1.square();
    // 9 == 8 + 1
    t1 = this * t1;
    // 11 == 9 + 2
    t0 = t0 * t1;
    // 22 == 2 * 11
    t2 = t0.square();
    // 31 == 22 + 9
    t1 = t1 * t2;
    // 2^6 - 2^1
    t2 = t1.square();
    // 2^10 - 2^5
    for (int i = 1; i < 5; ++i) {
      t2 = t2.square();
    }
    // 2^10 - 2^0
    t1 = t2 * t1;
    // 2^11 - 2^1
    t2 = t1.square();
    // 2^20 - 2^10
    for (int i = 1; i < 10; ++i) {
      t2 = t2.square();
    }
    // 2^20 - 2^0
    t2 = t2 * t1;
    // 2^21 - 2^1
    t3 = t2.square();
    // 2^40 - 2^20
    for (int i = 1; i < 20; ++i) {
      t3 = t3.square();
    }
    // 2^40 - 2^0
    t2 = t3 * t2;
    // 2^41 - 2^1
    t2 = t2.square();
    // 2^50 - 2^10
    for (int i = 1; i < 10; ++i) {
      t2 = t2.square();
    }
    // 2^50 - 2^0
    t1 = t2 * t1;
    // 2^51 - 2^1
    t2 = t1.square();
    // 2^100 - 2^50
    for (int i = 1; i < 50; ++i) {
      t2 = t2.square();
    }
    // 2^100 - 2^0
    t2 = t2 * t1;
    // 2^101 - 2^1
    t3 = t2.square();
    // 2^200 - 2^100
    for (int i = 1; i < 100; ++i) {
      t3 = t3.square();
    }
    // 2^200 - 2^0
    t2 = t3 * t2;
    // 2^201 - 2^1
    t2 = t2.square();
    // 2^250 - 2^50
    for (int i = 1; i < 50; ++i) {
      t2 = t2.square();
    }
    // 2^250 - 2^0
    t1 = t2 * t1;
    // 2^251 - 2^1
    t1 = t1.square();
    // 2^255 - 2^5
    for (int i = 1; i < 5; ++i) {
      t1 = t1.square();
    }

    // 2^255 - 21
    return t1 * t0;
  }

  FieldElement powP58() {
    FieldElement t0, t1, t2;
    // 2 == 2 * 1
    t0 = square();
    // 4 == 2 * 2
    t1 = t0.square();
    // 8 == 2 * 4
    t1 = t1.square();
    // z9 = z1*z8
    t1 = this * t1;
    // 11 == 9 + 2
    t0 = t0 * t1;
    // 22 == 2 * 11
    t0 = t0.square();
    // 31 == 22 + 9
    t0 = t1 * t0;
    // 2^6 - 2^1
    t1 = t0.square();
    // 2^10 - 2^5
    for (int i = 1; i < 5; ++i) {
      t1 = t1.square();
    }
    // 2^10 - 2^0
    t0 = t1 * t0;
    // 2^11 - 2^1
    t1 = t0.square();
    // 2^20 - 2^10
    for (int i = 1; i < 10; ++i) {
      t1 = t1.square();
    }
    // 2^20 - 2^0
    t1 = t1 * t0;
    // 2^21 - 2^1
    t2 = t1.square();
    // 2^40 - 2^20
    for (int i = 1; i < 20; ++i) {
      t2 = t2.square();
    }
    // 2^40 - 2^0
    t1 = t2 * t1;
    // 2^41 - 2^1
    t1 = t1.square();
    // 2^50 - 2^10
    for (int i = 1; i < 10; ++i) {
      t1 = t1.square();
    }
    // 2^50 - 2^0
    t0 = t1 * t0;
    // 2^51 - 2^1
    t1 = t0.square();
    // 2^100 - 2^50
    for (int i = 1; i < 50; ++i) {
      t1 = t1.square();
    }
    // 2^100 - 2^0
    t1 = t1 * t0;
    // 2^101 - 2^1
    t2 = t1.square();
    // 2^200 - 2^100
    for (int i = 1; i < 100; ++i) {
      t2 = t2.square();
    }
    // 2^200 - 2^0
    t1 = t2 * t1;
    // 2^201 - 2^1
    t1 = t1.square();
    // 2^250 - 2^50
    for (int i = 1; i < 50; ++i) {
      t1 = t1.square();
    }
    // 2^250 - 2^0
    t0 = t1 * t0;
    // 2^251 - 2^1
    t0 = t0.square();
    // 2^252 - 2^2
    t0 = t0.square();

    // 2^252 - 3
    return this * t0;
  }

  static SqrtRatioM1Result sqrtRatioM1(FieldElement u, FieldElement v) {
    final v3 = v.square() * v;
    final v7 = v3.square() * v;
    FieldElement r = u * v3 * (u * v7).powP58();
    final check = v * r.square();
    final uNeg = -u;
    final correctSignSqrt = check == u ? 1 : 0;
    final flippedSignSqrt = check == uNeg ? 1 : 0;
    final flippedSignSqrtM1 = check == uNeg * sqrtM1 ? 1 : 0;
    final rPrime = r * sqrtM1;
    r = r.select(rPrime, flippedSignSqrt | flippedSignSqrtM1);
    // Choose the non-negative square root.
    r = r.abs();
    final wasSquare = correctSignSqrt | flippedSignSqrt != 0;

    return SqrtRatioM1Result(r, wasSquare: wasSquare);
  }

  @override
  int get hashCode => toByteArray().hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! FieldElement) {
      return false;
    }
    final b = toByteArray();
    final c = other.toByteArray();

    return b.compareAll(c);
  }

  @override
  String toString() => _t.toString();
}
