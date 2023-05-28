import 'package:solana/src/curve25519/field_element.dart';

final FieldElement sqrtM1 = FieldElement.fromConstList(
  [
    -32595792, -7943725, 9377950, 3500415, 12389472, //
    -272473, -25146209, -2005654, 326686, 11406482,
  ].map(BigInt.from).toList(),
);

class SqrtRatioM1Result {
  const SqrtRatioM1Result(
    this.result, {
    required this.wasSquare,
  });

  final bool wasSquare;
  final FieldElement result;
}
