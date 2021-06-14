import 'package:convert/convert.dart';
import 'package:solana/src/base58/base58.dart';

typedef HashFunc = List<int> Function(List<int> m);

class EdwardsPoint {
  EdwardsPoint(this._x, this._y);

  factory EdwardsPoint.fromCompressedY(List<int> data) {
    final y = EdwardsPoint._bigIntFromBytes(data);
    final x = EdwardsPoint._recoverX(y);
    return EdwardsPoint(x, y);
  }

  static const int b = 256;
  static final BigInt q = BigInt.parse(
      '57896044618658097711785492504343953926634992332820282019728792003956564819949');
  static final BigInt qm2 = BigInt.parse(
      '57896044618658097711785492504343953926634992332820282019728792003956564819947');
  static final BigInt qp3 = BigInt.parse(
      '57896044618658097711785492504343953926634992332820282019728792003956564819952');
  static final BigInt l = BigInt.parse(
      '7237005577332262213973186563042994240857116359379907606001950938285454250989');
  static final BigInt d = BigInt.parse(
      '-4513249062541557337682894930092624173785641285191125241628941591882900924598840740');
  static final BigInt I = BigInt.parse(
      '19681161376707505956807079304988542015446066515923890162744021073123829784752');
  static final BigInt by = BigInt.parse(
      '46316835694926478169428394003475163141307993866256225615783033603165251855960');
  static final BigInt bx = BigInt.parse(
      '15112221349535400772501151409588531511454012693041857206046113283949847762202');
  static final List<BigInt> B = [bx % q, by % q];
  static final BigInt un = BigInt.parse(
      '57896044618658097711785492504343953926634992332820282019728792003956564819967');

  final BigInt _x;
  final BigInt _y;

  static final BigInt zero = BigInt.from(0);
  static final BigInt one = BigInt.from(1);
  static final BigInt two = BigInt.from(2);
  static final BigInt eight = BigInt.from(8);

  bool isOnCurve() {
    final BigInt xx = _x * _x;
    final BigInt yy = _y * _y;
    final BigInt dXXyy = d * yy * xx;
    return (-xx + yy - one - dXXyy) % q == zero;
  }

  static BigInt _expMod(BigInt b, BigInt e, BigInt m) {
    if (e == zero) {
      return one;
    }
    BigInt t = _expMod(b, e ~/ two, m).pow(2) % m;
    if (e % two != zero) {
      t = t * b % m;
    }
    return t;
  }

  static BigInt _inv(BigInt x) => _expMod(x, qm2, q);

  static BigInt _recoverX(BigInt y) {
    final BigInt y2 = y * y;
    final BigInt xx = (y2 - one) * (_inv(d * y2 + one));
    BigInt x = _expMod(xx, qp3 ~/ eight, q);
    if (!((x * x - xx) % q == zero)) x = x * I % q;
    if (!(x % two == zero)) x = q - x;
    return x;
  }

  static BigInt _bigIntFromBytes(List<int> bytes) => BigInt.parse(
        hex.encode([for (int byte in bytes.reversed) byte]),
        radix: 16,
      );
}

/// Returns true if [address] is a valid ed25519 point encoded
/// to base58.
bool isValidAddress(String address) {
  try {
    final List<int> data = decode(address);
    if (data.length != 32) {
      return false;
    }
    final point = EdwardsPoint.fromCompressedY(data);
    // Just check if the point is on the Ed25519 curve
    return point.isOnCurve();
  } on FormatException {
    return false;
  }
}
