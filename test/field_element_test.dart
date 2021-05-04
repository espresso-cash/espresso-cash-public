import 'package:solana/src/edwards25519/field_element.dart';
import 'package:test/test.dart';

void main() {
  /// Test vectors below, and the tests they are used in, are from
  /// curve25519-dalek.
  /// https://github.com/dalek-cryptography/curve25519-dalek/blob/4bdccd7b7c394d9f8ffc4b29d5acc23c972f3d7a/src/field.rs#L280-L301
  ///
  /// Random element a of GF(2^255-19), from Sage
  /// a = 10703145068883540813293858232352184442332212228051251926706380353716438957572
  /// @formatter:off
  final List<int> aBytes = [
    0x04,
    0xfe,
    0xdf,
    0x98,
    0xa7,
    0xfa,
    0x0a,
    0x68,
    0x84,
    0x92,
    0xbd,
    0x59,
    0x08,
    0x07,
    0xa7,
    0x03,
    0x9e,
    0xd1,
    0xf6,
    0xf2,
    0xe1,
    0xd9,
    0xe2,
    0xa4,
    0xa4,
    0x51,
    0x47,
    0x36,
    0xf3,
    0xc3,
    0xa9,
    0x17
  ];

  // Byte representation of a**2
  final List<int> aSquaredBytes = [
    0x75,
    0x97,
    0x24,
    0x9e,
    0xe6,
    0x06,
    0xfe,
    0xab,
    0x24,
    0x04,
    0x56,
    0x68,
    0x07,
    0x91,
    0x2d,
    0x5d,
    0x0b,
    0x0f,
    0x3f,
    0x1c,
    0xb2,
    0x6e,
    0xf2,
    0xe2,
    0x63,
    0x9c,
    0x12,
    0xba,
    0x73,
    0x0b,
    0xe3,
    0x62
  ];

  // Byte representation of 1/a
  final List<int> aInverseBytes = [
    0x96,
    0x1b,
    0xcd,
    0x8d,
    0x4d,
    0x5e,
    0xa2,
    0x3a,
    0xe9,
    0x36,
    0x37,
    0x93,
    0xdb,
    0x7b,
    0x4d,
    0x70,
    0xb8,
    0x0d,
    0xc0,
    0x55,
    0xd0,
    0x4c,
    0x1d,
    0x7b,
    0x90,
    0x71,
    0xd8,
    0xe9,
    0xb6,
    0x18,
    0xe6,
    0x30
  ];

  // Byte representation of a^((p-5)/8)
  final List<int> aP58Bytes = [
    0x6a,
    0x4f,
    0x24,
    0x89,
    0x1f,
    0x57,
    0x60,
    0x36,
    0xd0,
    0xbe,
    0x12,
    0x3c,
    0x8f,
    0xf5,
    0xb1,
    0x59,
    0xe0,
    0xf0,
    0xb8,
    0x1b,
    0x20,
    0xd2,
    0xb5,
    0x1f,
    0x15,
    0x21,
    0xf9,
    0xe3,
    0xe1,
    0x61,
    0x21,
    0x55
  ];
  final FieldElement a = FieldElement.fromByteArray(aBytes);
  final FieldElement aSquared = FieldElement.fromByteArray(aSquaredBytes);

  test('a * a equals a^2 constant', () {
    expect(a * a, aSquared);
  });

  test('a^2 equals a^2 constant', () {
    expect(a.square(), aSquared);
  });

  test('a * a equals a^2 constant', () {
    expect(a * a, a.square());
  });

  test('a + a equals a * 2', () {
    const FieldElement one = FieldElement.one;
    expect(a + a, a * (one + one));
  });

  test('1/a equals 1/a constant', () {
    final aInverseConstant = FieldElement.fromByteArray(aInverseBytes);
    final aInverseValue = a.invert();
    expect(aInverseValue, aInverseConstant);
    expect(aInverseValue * a, FieldElement.one);
  });

  test('a^((p-5/8)) equals a^((p-5)/8) constant', () {
    final aP58 = FieldElement.fromByteArray(aP58Bytes);
    expect(a.powP58(), aP58);
  });

  test('field element sqrt ratio m1', () {
    const FieldElement zero = FieldElement.zero;
    const FieldElement one = FieldElement.one;
    final FieldElement two = one + one; // 2 is non square mod p.
    final FieldElement four = two + two; // 4 is square mod p.
    SqrtRatioM1Result sqrt;
    // 0/0 should return (1, 0) since u is 0
    sqrt = FieldElement.sqrtRatioM1(zero, zero);
    expect(sqrt.wasSquare, 1);
    expect(sqrt.result, zero);
    expect(sqrt.result.isNegative(), 0);

    // 1/0 should return (0, 0) since v is 0, u is nonzero
    sqrt = FieldElement.sqrtRatioM1(one, zero);
    expect(sqrt.wasSquare, 0);
    expect(sqrt.result, zero);
    expect(sqrt.result.isNegative(), 0);

    // 2/1 is non square, so we expect (0, sqrt(i*2))
    sqrt = FieldElement.sqrtRatioM1(two, one);
    expect(sqrt.wasSquare, 0);
    expect(sqrt.result.square(), two * sqrtM1);
    expect(sqrt.result.isNegative(), 0);

    // 4/1 is square, so we expect (1, sqrt(4))
    sqrt = FieldElement.sqrtRatioM1(four, one);
    expect(sqrt.wasSquare, 1);
    expect(sqrt.result.square(), four);
    expect(sqrt.result.isNegative(), 0);

    // 1/4 is square, so we expect (1, 1/sqrt(4))
    sqrt = FieldElement.sqrtRatioM1(one, four);
    expect(sqrt.wasSquare, 1);
    expect(sqrt.result.square() * four, one);
    expect(sqrt.result.isNegative(), 0);
  });
}
