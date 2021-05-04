import 'package:convert/convert.dart';
import 'package:solana/src/edwards25519/compressed_edwards_y.dart';
import 'package:solana/src/edwards25519/edwards_point.dart';
import 'package:solana/src/edwards25519/field_element.dart';
import 'package:test/test.dart';

EdwardsPoint ed25519BasePoint = EdwardsPoint(
  FieldElement([
    -14297830,
    -7645148,
    16144683,
    -16471763,
    27570974,
    -2696100,
    -26142465,
    8378389,
    20764389,
    8758491
  ]),
  FieldElement([
    -26843541,
    -6710886,
    13421773,
    -13421773,
    26843546,
    6710886,
    -13421773,
    13421773,
    -26843546,
    -6710886,
  ]),
  FieldElement([1, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
  FieldElement([
    28827062,
    -6116119,
    -27349572,
    244363,
    8635006,
    11264893,
    19351346,
    13413597,
    16611511,
    -6414980,
  ]),
);

void main() {
  /**
   * Compressed Edwards Y form of the Ed25519 base point.
   */
  final CompressedEdwardsY ed25519BasePointCompressed = CompressedEdwardsY(
      hex.decode(
          '5866666666666666666666666666666666666666666666666666666666666666'));
  final List<CompressedEdwardsY> eightTorsionCompressed = [
    CompressedEdwardsY(hex.decode(
        '0100000000000000000000000000000000000000000000000000000000000000')),
    CompressedEdwardsY(hex.decode(
        'c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac037a')),
    CompressedEdwardsY(hex.decode(
        '0000000000000000000000000000000000000000000000000000000000000080')),
    CompressedEdwardsY(hex.decode(
        '26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc05')),
    CompressedEdwardsY(hex.decode(
        'ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f')),
    CompressedEdwardsY(hex.decode(
        '26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc85')),
    CompressedEdwardsY(hex.decode(
        '0000000000000000000000000000000000000000000000000000000000000000')),
    CompressedEdwardsY(hex.decode(
        'c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac03fa'))
  ];
  group('EdwardsPoint test', () {
    test('it decompresses compressed point', () {
      final EdwardsPoint b = ed25519BasePointCompressed.decompress();
      expect(b.compress(), ed25519BasePointCompressed);
    });
    test('is small order', () {
      // The base point has large prime order
      expect(ed25519BasePoint.isSmallOrder(), false);
      // Eight torsion compressed has all points of small order.
      for (final CompressedEdwardsY compressed in eightTorsionCompressed) {
        expect(compressed.decompress().isSmallOrder(), true);
      }
    });
  });
}
