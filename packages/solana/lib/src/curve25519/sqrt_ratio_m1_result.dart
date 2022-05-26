import 'package:solana/src/curve25519/field_element.dart';

final FieldElement sqrtM1 = FieldElement.fromConstList(
  [
    BigInt.from(-32595792),
    BigInt.from(-7943725),
    BigInt.from(9377950),
    BigInt.from(3500415),
    BigInt.from(12389472), //
    BigInt.from(-272473),
    BigInt.from(-25146209),
    BigInt.from(-2005654),
    BigInt.from(326686),
    BigInt.from(11406482),
  ],
);

class SqrtRatioM1Result {
  SqrtRatioM1Result(
    this.result, {
    required this.wasSquare,
  });

  final bool wasSquare;
  final FieldElement result;
}
