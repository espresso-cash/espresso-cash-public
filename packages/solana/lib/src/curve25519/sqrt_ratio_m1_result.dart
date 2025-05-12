import 'package:solana/src/curve25519/field_element.dart';

final FieldElement sqrtM1 = FieldElement.fromConstList(
  [
    -32_595_792, -7_943_725, 9_377_950, 3_500_415, 12_389_472, //
    -272_473, -25_146_209, -2_005_654, 326_686, 11_406_482,
  ].map(BigInt.from).toList(),
);

class SqrtRatioM1Result {
  const SqrtRatioM1Result(this.result, {required this.wasSquare});

  final bool wasSquare;
  final FieldElement result;
}
