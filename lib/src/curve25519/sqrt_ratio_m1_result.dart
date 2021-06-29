part of 'curve25519.dart';

const _FieldElement sqrtM1 = _FieldElement._fromConstList([
  -32595792, -7943725, 9377950, 3500415, 12389472, //
  -272473, -25146209, -2005654, 326686, 11406482,
]);

class SqrtRatioM1Result {
  SqrtRatioM1Result(
    this.result, {
    required this.wasSquare,
  });

  final bool wasSquare;
  final _FieldElement result;
}
