import '../../../gen/assets.gen.dart';

enum PaymentMethod { visa, mastercard, applePay, googlePay, bank, sepa, pix, swift }

extension PaymentMethodAssets on PaymentMethod {
  SvgGenImage get logo => switch (this) {
    PaymentMethod.visa => Assets.brands.visa,
    PaymentMethod.mastercard => Assets.brands.mastercard,
    PaymentMethod.applePay => Assets.brands.applePay,
    PaymentMethod.googlePay => Assets.brands.gpay,
    PaymentMethod.bank => Assets.brands.bank,
    PaymentMethod.sepa => Assets.brands.sepa,
    PaymentMethod.pix => Assets.brands.pix,
    PaymentMethod.swift => Assets.brands.swift,
  };
}
