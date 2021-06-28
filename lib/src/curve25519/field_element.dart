part of 'curve25519.dart';

const _FieldElement sqrtM1 = _FieldElement._fromConstList([
  -32595792, -7943725, 9377950, 3500415, 12389472, //
  -272473, -25146209, -2005654, 326686, 11406482,
]);

class SqrtRatioM1Result {
  SqrtRatioM1Result(this.wasSquare, this.result);

  final int wasSquare;
  final _FieldElement result;
}

class _FieldElement {
  _FieldElement(this._t) {
    if (_t.length != 10) {
      throw FormatException(
        'cannot create a `FieldElement\' '
        'from a byte array of length ${_t.length}, it MUST be 10',
      );
    }
  }

  _FieldElement.fromByteArray(List<int> input) : _t = List.filled(10, 0) {
    int h0 = load_4(input, 0);
    int h1 = load_3(input, 4) << 6;
    int h2 = load_3(input, 7) << 5;
    int h3 = load_3(input, 10) << 3;
    int h4 = load_3(input, 13) << 2;
    int h5 = load_4(input, 16);
    int h6 = load_3(input, 20) << 7;
    int h7 = load_3(input, 23) << 5;
    int h8 = load_3(input, 26) << 4;
    int h9 = (load_3(input, 29) & 0x7FFFFF) << 2;
    int carry0;
    int carry1;
    int carry2;
    int carry3;
    int carry4;
    int carry5;
    int carry6;
    int carry7;
    int carry8;
    int carry9;
    // Remember: 2^255 congruent 19 modulo p
    carry9 = (h9 + (1 << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 << 25;
    carry1 = (h1 + (1 << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry3 = (h3 + (1 << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry5 = (h5 + (1 << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry7 = (h7 + (1 << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry2 = (h2 + (1 << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry6 = (h6 + (1 << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry8 = (h8 + (1 << 25)) >> 26;
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

  const _FieldElement._fromConstList(this._t);

  static const _FieldElement zero =
      _FieldElement._fromConstList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  static const _FieldElement one =
      _FieldElement._fromConstList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  static const _FieldElement minusOne = // ignore: unused_field
      _FieldElement._fromConstList([-1, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  final List<int> _t;

  static int load_3(List<int> input, int offset) {
    int result = input[offset] & 0xff;
    result |= (input[offset + 1] & 0xff) << 8;
    result |= (input[offset + 2] & 0xff) << 16;
    return result;
  }

  static int load_4(List<int> input, int offset) {
    int result = input[offset] & 0xff;
    result |= (input[offset + 1] & 0xff) << 8;
    result |= (input[offset + 2] & 0xff) << 16;
    result |= input[offset + 3] << 24;
    return result & 0xffffffff;
  }

  List<int> toByteArray() {
    int h0 = _t[0];
    int h1 = _t[1];
    int h2 = _t[2];
    int h3 = _t[3];
    int h4 = _t[4];
    int h5 = _t[5];
    int h6 = _t[6];
    int h7 = _t[7];
    int h8 = _t[8];
    int h9 = _t[9];
    int q;
    int carry0;
    int carry1;
    int carry2;
    int carry3;
    int carry4;
    int carry5;
    int carry6;
    int carry7;
    int carry8;
    int carry9;
    // Step 1:
    // Calculate q
    q = (19 * h9 + (1 << 24)) >> 25;
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
    h0 += 19 * q;
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
    final List<int> s = List.filled(32, 0);
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

  @override
  int get hashCode => toByteArray().hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! _FieldElement) {
      return false;
    }
    final b = toByteArray();
    final c = other.toByteArray();
    return b.compareAll(c);
  }

  _FieldElement select(_FieldElement other, int selector) {
    final int b = -selector;
    final List<int> result = List.filled(10, 0);
    for (int i = 0; i < 10; i++) {
      result[i] = _t[i];
      int x = _t[i] ^ other._t[i];
      x &= b;
      result[i] ^= x;
    }
    return _FieldElement(result);
  }

  _FieldElement abs() => select(-this, isNegative());

  int isNegative() {
    final List<int> s = toByteArray();
    return s[0] & 1;
  }

  _FieldElement operator +(_FieldElement val) {
    final List<int> g = val._t;
    final List<int> h = List.filled(10, 0);
    for (int i = 0; i < 10; i++) {
      h[i] = _t[i] + g[i];
    }
    return _FieldElement._fromConstList(h);
  }

  _FieldElement operator -(_FieldElement val) {
    final List<int> g = val._t;
    final List<int> h = List.filled(10, 0);
    for (int i = 0; i < 10; i++) {
      h[i] = _t[i] - g[i];
    }
    return _FieldElement._fromConstList(h);
  }

  _FieldElement operator -() {
    final List<int> h = List.filled(10, 0);
    for (int i = 0; i < 10; i++) {
      h[i] = -_t[i];
    }
    return _FieldElement._fromConstList(h);
  }

  _FieldElement operator *(_FieldElement val) {
    final List<int> g = val._t;
    final int g1_19 = 19 * g[1]; /* 1.959375*2^29 */
    final int g2_19 = 19 * g[2]; /* 1.959375*2^30; still ok */
    final int g3_19 = 19 * g[3];
    final int g4_19 = 19 * g[4];
    final int g5_19 = 19 * g[5];
    final int g6_19 = 19 * g[6];
    final int g7_19 = 19 * g[7];
    final int g8_19 = 19 * g[8];
    final int g9_19 = 19 * g[9];
    final int f1_2 = 2 * _t[1];
    final int f3_2 = 2 * _t[3];
    final int f5_2 = 2 * _t[5];
    final int f7_2 = 2 * _t[7];
    final int f9_2 = 2 * _t[9];
    final int f0g0 = _t[0] * g[0];
    final int f0g1 = _t[0] * g[1];
    final int f0g2 = _t[0] * g[2];
    final int f0g3 = _t[0] * g[3];
    final int f0g4 = _t[0] * g[4];
    final int f0g5 = _t[0] * g[5];
    final int f0g6 = _t[0] * g[6];
    final int f0g7 = _t[0] * g[7];
    final int f0g8 = _t[0] * g[8];
    final int f0g9 = _t[0] * g[9];
    final int f1g0 = _t[1] * g[0];
    final int f1g1_2 = f1_2 * g[1];
    final int f1g2 = _t[1] * g[2];
    final int f1g3_2 = f1_2 * g[3];
    final int f1g4 = _t[1] * g[4];
    final int f1g5_2 = f1_2 * g[5];
    final int f1g6 = _t[1] * g[6];
    final int f1g7_2 = f1_2 * g[7];
    final int f1g8 = _t[1] * g[8];
    final int f1g9_38 = f1_2 * g9_19;
    final int f2g0 = _t[2] * g[0];
    final int f2g1 = _t[2] * g[1];
    final int f2g2 = _t[2] * g[2];
    final int f2g3 = _t[2] * g[3];
    final int f2g4 = _t[2] * g[4];
    final int f2g5 = _t[2] * g[5];
    final int f2g6 = _t[2] * g[6];
    final int f2g7 = _t[2] * g[7];
    final int f2g8_19 = _t[2] * g8_19;
    final int f2g9_19 = _t[2] * g9_19;
    final int f3g0 = _t[3] * g[0];
    final int f3g1_2 = f3_2 * g[1];
    final int f3g2 = _t[3] * g[2];
    final int f3g3_2 = f3_2 * g[3];
    final int f3g4 = _t[3] * g[4];
    final int f3g5_2 = f3_2 * g[5];
    final int f3g6 = _t[3] * g[6];
    final int f3g7_38 = f3_2 * g7_19;
    final int f3g8_19 = _t[3] * g8_19;
    final int f3g9_38 = f3_2 * g9_19;
    final int f4g0 = _t[4] * g[0];
    final int f4g1 = _t[4] * g[1];
    final int f4g2 = _t[4] * g[2];
    final int f4g3 = _t[4] * g[3];
    final int f4g4 = _t[4] * g[4];
    final int f4g5 = _t[4] * g[5];
    final int f4g6_19 = _t[4] * g6_19;
    final int f4g7_19 = _t[4] * g7_19;
    final int f4g8_19 = _t[4] * g8_19;
    final int f4g9_19 = _t[4] * g9_19;
    final int f5g0 = _t[5] * g[0];
    final int f5g1_2 = f5_2 * g[1];
    final int f5g2 = _t[5] * g[2];
    final int f5g3_2 = f5_2 * g[3];
    final int f5g4 = _t[5] * g[4];
    final int f5g5_38 = f5_2 * g5_19;
    final int f5g6_19 = _t[5] * g6_19;
    final int f5g7_38 = f5_2 * g7_19;
    final int f5g8_19 = _t[5] * g8_19;
    final int f5g9_38 = f5_2 * g9_19;
    final int f6g0 = _t[6] * g[0];
    final int f6g1 = _t[6] * g[1];
    final int f6g2 = _t[6] * g[2];
    final int f6g3 = _t[6] * g[3];
    final int f6g4_19 = _t[6] * g4_19;
    final int f6g5_19 = _t[6] * g5_19;
    final int f6g6_19 = _t[6] * g6_19;
    final int f6g7_19 = _t[6] * g7_19;
    final int f6g8_19 = _t[6] * g8_19;
    final int f6g9_19 = _t[6] * g9_19;
    final int f7g0 = _t[7] * g[0];
    final int f7g1_2 = f7_2 * g[1];
    final int f7g2 = _t[7] * g[2];
    final int f7g3_38 = f7_2 * g3_19;
    final int f7g4_19 = _t[7] * g4_19;
    final int f7g5_38 = f7_2 * g5_19;
    final int f7g6_19 = _t[7] * g6_19;
    final int f7g7_38 = f7_2 * g7_19;
    final int f7g8_19 = _t[7] * g8_19;
    final int f7g9_38 = f7_2 * g9_19;
    final int f8g0 = _t[8] * g[0];
    final int f8g1 = _t[8] * g[1];
    final int f8g2_19 = _t[8] * g2_19;
    final int f8g3_19 = _t[8] * g3_19;
    final int f8g4_19 = _t[8] * g4_19;
    final int f8g5_19 = _t[8] * g5_19;
    final int f8g6_19 = _t[8] * g6_19;
    final int f8g7_19 = _t[8] * g7_19;
    final int f8g8_19 = _t[8] * g8_19;
    final int f8g9_19 = _t[8] * g9_19;
    final int f9g0 = _t[9] * g[0];
    final int f9g1_38 = f9_2 * g1_19;
    final int f9g2_19 = _t[9] * g2_19;
    final int f9g3_38 = f9_2 * g3_19;
    final int f9g4_19 = _t[9] * g4_19;
    final int f9g5_38 = f9_2 * g5_19;
    final int f9g6_19 = _t[9] * g6_19;
    final int f9g7_38 = f9_2 * g7_19;
    final int f9g8_19 = _t[9] * g8_19;
    final int f9g9_38 = f9_2 * g9_19;
    int h0 = f0g0 +
        f1g9_38 +
        f2g8_19 +
        f3g7_38 +
        f4g6_19 +
        f5g5_38 +
        f6g4_19 +
        f7g3_38 +
        f8g2_19 +
        f9g1_38;
    int h1 = f0g1 +
        f1g0 +
        f2g9_19 +
        f3g8_19 +
        f4g7_19 +
        f5g6_19 +
        f6g5_19 +
        f7g4_19 +
        f8g3_19 +
        f9g2_19;
    int h2 = f0g2 +
        f1g1_2 +
        f2g0 +
        f3g9_38 +
        f4g8_19 +
        f5g7_38 +
        f6g6_19 +
        f7g5_38 +
        f8g4_19 +
        f9g3_38;
    int h3 = f0g3 +
        f1g2 +
        f2g1 +
        f3g0 +
        f4g9_19 +
        f5g8_19 +
        f6g7_19 +
        f7g6_19 +
        f8g5_19 +
        f9g4_19;
    int h4 = f0g4 +
        f1g3_2 +
        f2g2 +
        f3g1_2 +
        f4g0 +
        f5g9_38 +
        f6g8_19 +
        f7g7_38 +
        f8g6_19 +
        f9g5_38;
    int h5 = f0g5 +
        f1g4 +
        f2g3 +
        f3g2 +
        f4g1 +
        f5g0 +
        f6g9_19 +
        f7g8_19 +
        f8g7_19 +
        f9g6_19;
    int h6 = f0g6 +
        f1g5_2 +
        f2g4 +
        f3g3_2 +
        f4g2 +
        f5g1_2 +
        f6g0 +
        f7g9_38 +
        f8g8_19 +
        f9g7_38;
    int h7 = f0g7 +
        f1g6 +
        f2g5 +
        f3g4 +
        f4g3 +
        f5g2 +
        f6g1 +
        f7g0 +
        f8g9_19 +
        f9g8_19;
    int h8 = f0g8 +
        f1g7_2 +
        f2g6 +
        f3g5_2 +
        f4g4 +
        f5g3_2 +
        f6g2 +
        f7g1_2 +
        f8g0 +
        f9g9_38;
    int h9 =
        f0g9 + f1g8 + f2g7 + f3g6 + f4g5 + f5g4 + f6g3 + f7g2 + f8g1 + f9g0;
    int carry0;
    int carry1;
    int carry2;
    int carry3;
    int carry4;
    int carry5;
    int carry6;
    int carry7;
    int carry8;
    int carry9;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (1 << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (1 << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (1 << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (1 << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (1 << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (1 << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (1 << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (1 << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 << 25;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final List<int> h = List.filled(10, 0);
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
    return _FieldElement._fromConstList(h);
  }

  _FieldElement square() {
    final int f0 = _t[0];
    final int f1 = _t[1];
    final int f2 = _t[2];
    final int f3 = _t[3];
    final int f4 = _t[4];
    final int f5 = _t[5];
    final int f6 = _t[6];
    final int f7 = _t[7];
    final int f8 = _t[8];
    final int f9 = _t[9];
    final int f0_2 = 2 * f0;
    final int f1_2 = 2 * f1;
    final int f2_2 = 2 * f2;
    final int f3_2 = 2 * f3;
    final int f4_2 = 2 * f4;
    final int f5_2 = 2 * f5;
    final int f6_2 = 2 * f6;
    final int f7_2 = 2 * f7;
    final int f5_38 = 38 * f5; /* 1.959375*2^30 */
    final int f6_19 = 19 * f6; /* 1.959375*2^30 */
    final int f7_38 = 38 * f7; /* 1.959375*2^30 */
    final int f8_19 = 19 * f8; /* 1.959375*2^30 */
    final int f9_38 = 38 * f9; /* 1.959375*2^30 */
    final int f0f0 = f0 * f0;
    final int f0f1_2 = f0_2 * f1;
    final int f0f2_2 = f0_2 * f2;
    final int f0f3_2 = f0_2 * f3;
    final int f0f4_2 = f0_2 * f4;
    final int f0f5_2 = f0_2 * f5;
    final int f0f6_2 = f0_2 * f6;
    final int f0f7_2 = f0_2 * f7;
    final int f0f8_2 = f0_2 * f8;
    final int f0f9_2 = f0_2 * f9;
    final int f1f1_2 = f1_2 * f1;
    final int f1f2_2 = f1_2 * f2;
    final int f1f3_4 = f1_2 * f3_2;
    final int f1f4_2 = f1_2 * f4;
    final int f1f5_4 = f1_2 * f5_2;
    final int f1f6_2 = f1_2 * f6;
    final int f1f7_4 = f1_2 * f7_2;
    final int f1f8_2 = f1_2 * f8;
    final int f1f9_76 = f1_2 * f9_38;
    final int f2f2 = f2 * f2;
    final int f2f3_2 = f2_2 * f3;
    final int f2f4_2 = f2_2 * f4;
    final int f2f5_2 = f2_2 * f5;
    final int f2f6_2 = f2_2 * f6;
    final int f2f7_2 = f2_2 * f7;
    final int f2f8_38 = f2_2 * f8_19;
    final int f2f9_38 = f2 * f9_38;
    final int f3f3_2 = f3_2 * f3;
    final int f3f4_2 = f3_2 * f4;
    final int f3f5_4 = f3_2 * f5_2;
    final int f3f6_2 = f3_2 * f6;
    final int f3f7_76 = f3_2 * f7_38;
    final int f3f8_38 = f3_2 * f8_19;
    final int f3f9_76 = f3_2 * f9_38;
    final int f4f4 = f4 * f4;
    final int f4f5_2 = f4_2 * f5;
    final int f4f6_38 = f4_2 * f6_19;
    final int f4f7_38 = f4 * f7_38;
    final int f4f8_38 = f4_2 * f8_19;
    final int f4f9_38 = f4 * f9_38;
    final int f5f5_38 = f5 * f5_38;
    final int f5f6_38 = f5_2 * f6_19;
    final int f5f7_76 = f5_2 * f7_38;
    final int f5f8_38 = f5_2 * f8_19;
    final int f5f9_76 = f5_2 * f9_38;
    final int f6f6_19 = f6 * f6_19;
    final int f6f7_38 = f6 * f7_38;
    final int f6f8_38 = f6_2 * f8_19;
    final int f6f9_38 = f6 * f9_38;
    final int f7f7_38 = f7 * f7_38;
    final int f7f8_38 = f7_2 * f8_19;
    final int f7f9_76 = f7_2 * f9_38;
    final int f8f8_19 = f8 * f8_19;
    final int f8f9_38 = f8 * f9_38;
    final int f9f9_38 = f9 * f9_38;
    int h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    int h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    int h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    int h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    int h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    int h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    int h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    int h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    int h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    int h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
    int carry0;
    int carry1;
    int carry2;
    int carry3;
    int carry4;
    int carry5;
    int carry6;
    int carry7;
    int carry8;
    int carry9;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (1 << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (1 << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (1 << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (1 << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (1 << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (1 << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (1 << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (1 << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 << 25;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final List<int> h = List.filled(10, 0);
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
    return _FieldElement._fromConstList(h);
  }

  _FieldElement squareAndDouble() {
    final int f0 = _t[0];
    final int f1 = _t[1];
    final int f2 = _t[2];
    final int f3 = _t[3];
    final int f4 = _t[4];
    final int f5 = _t[5];
    final int f6 = _t[6];
    final int f7 = _t[7];
    final int f8 = _t[8];
    final int f9 = _t[9];
    final int f0_2 = 2 * f0;
    final int f1_2 = 2 * f1;
    final int f2_2 = 2 * f2;
    final int f3_2 = 2 * f3;
    final int f4_2 = 2 * f4;
    final int f5_2 = 2 * f5;
    final int f6_2 = 2 * f6;
    final int f7_2 = 2 * f7;
    final int f5_38 = 38 * f5; /* 1.959375*2^30 */
    final int f6_19 = 19 * f6; /* 1.959375*2^30 */
    final int f7_38 = 38 * f7; /* 1.959375*2^30 */
    final int f8_19 = 19 * f8; /* 1.959375*2^30 */
    final int f9_38 = 38 * f9; /* 1.959375*2^30 */
    final int f0f0 = f0 * f0;
    final int f0f1_2 = f0_2 * f1;
    final int f0f2_2 = f0_2 * f2;
    final int f0f3_2 = f0_2 * f3;
    final int f0f4_2 = f0_2 * f4;
    final int f0f5_2 = f0_2 * f5;
    final int f0f6_2 = f0_2 * f6;
    final int f0f7_2 = f0_2 * f7;
    final int f0f8_2 = f0_2 * f8;
    final int f0f9_2 = f0_2 * f9;
    final int f1f1_2 = f1_2 * f1;
    final int f1f2_2 = f1_2 * f2;
    final int f1f3_4 = f1_2 * f3_2;
    final int f1f4_2 = f1_2 * f4;
    final int f1f5_4 = f1_2 * f5_2;
    final int f1f6_2 = f1_2 * f6;
    final int f1f7_4 = f1_2 * f7_2;
    final int f1f8_2 = f1_2 * f8;
    final int f1f9_76 = f1_2 * f9_38;
    final int f2f2 = f2 * f2;
    final int f2f3_2 = f2_2 * f3;
    final int f2f4_2 = f2_2 * f4;
    final int f2f5_2 = f2_2 * f5;
    final int f2f6_2 = f2_2 * f6;
    final int f2f7_2 = f2_2 * f7;
    final int f2f8_38 = f2_2 * f8_19;
    final int f2f9_38 = f2 * f9_38;
    final int f3f3_2 = f3_2 * f3;
    final int f3f4_2 = f3_2 * f4;
    final int f3f5_4 = f3_2 * f5_2;
    final int f3f6_2 = f3_2 * f6;
    final int f3f7_76 = f3_2 * f7_38;
    final int f3f8_38 = f3_2 * f8_19;
    final int f3f9_76 = f3_2 * f9_38;
    final int f4f4 = f4 * f4;
    final int f4f5_2 = f4_2 * f5;
    final int f4f6_38 = f4_2 * f6_19;
    final int f4f7_38 = f4 * f7_38;
    final int f4f8_38 = f4_2 * f8_19;
    final int f4f9_38 = f4 * f9_38;
    final int f5f5_38 = f5 * f5_38;
    final int f5f6_38 = f5_2 * f6_19;
    final int f5f7_76 = f5_2 * f7_38;
    final int f5f8_38 = f5_2 * f8_19;
    final int f5f9_76 = f5_2 * f9_38;
    final int f6f6_19 = f6 * f6_19;
    final int f6f7_38 = f6 * f7_38;
    final int f6f8_38 = f6_2 * f8_19;
    final int f6f9_38 = f6 * f9_38;
    final int f7f7_38 = f7 * f7_38;
    final int f7f8_38 = f7_2 * f8_19;
    final int f7f9_76 = f7_2 * f9_38;
    final int f8f8_19 = f8 * f8_19;
    final int f8f9_38 = f8 * f9_38;
    final int f9f9_38 = f9 * f9_38;
    int h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    int h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    int h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    int h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    int h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    int h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    int h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    int h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    int h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    int h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;
    int carry0;
    int carry1;
    int carry2;
    int carry3;
    int carry4;
    int carry5;
    int carry6;
    int carry7;
    int carry8;
    int carry9;
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
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry1 = (h1 + (1 << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 << 25;
    carry5 = (h5 + (1 << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 << 25;
    carry2 = (h2 + (1 << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 << 26;
    carry6 = (h6 + (1 << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 << 26;
    carry3 = (h3 + (1 << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 << 25;
    carry7 = (h7 + (1 << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 << 25;
    carry4 = (h4 + (1 << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 << 26;
    carry8 = (h8 + (1 << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 << 26;
    carry9 = (h9 + (1 << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 << 25;
    carry0 = (h0 + (1 << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 << 26;
    final List<int> h = List.filled(10, 0);
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
    return _FieldElement._fromConstList(h);
  }

  _FieldElement invert() {
    _FieldElement t0, t1, t2, t3;
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

  _FieldElement powP58() {
    _FieldElement t0, t1, t2;
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

  static SqrtRatioM1Result sqrtRatioM1(_FieldElement u, _FieldElement v) {
    final _FieldElement v3 = v.square() * v;
    final _FieldElement v7 = v3.square() * v;
    _FieldElement r = u * v3 * (u * v7).powP58();
    final _FieldElement check = v * r.square();
    final _FieldElement uNeg = -u;
    final int correctSignSqrt = check == u ? 1 : 0;
    final int flippedSignSqrt = check == uNeg ? 1 : 0;
    final int flippedSignSqrtM1 = check == uNeg * sqrtM1 ? 1 : 0;
    final _FieldElement rPrime = r * sqrtM1;
    r = r.select(rPrime, flippedSignSqrt | flippedSignSqrtM1);
    // Choose the non-negative square root.
    r = r.abs();
    return SqrtRatioM1Result(correctSignSqrt | flippedSignSqrt, r);
  }
}
