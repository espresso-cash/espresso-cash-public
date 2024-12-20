import '../../../gen/assets.gen.dart';

enum PaymentMethod {
  visa,
  mastercard,
  applePay,
  googlePay,
  bank,
  sepa,
  pix,
  swift,
}

extension PaymentMethodAssets on PaymentMethod {
  SvgGenImage get logo {
    switch (this) {
      case PaymentMethod.visa:
        return Assets.brands.visa;
      case PaymentMethod.mastercard:
        return Assets.brands.mastercard;
      case PaymentMethod.applePay:
        return Assets.brands.applePay;
      case PaymentMethod.googlePay:
        return Assets.brands.gpay;
      case PaymentMethod.bank:
        return Assets.brands.bank;
      case PaymentMethod.sepa:
        return Assets.brands.sepa;
      case PaymentMethod.pix:
        return Assets.brands.pix;
      case PaymentMethod.swift:
        return Assets.brands.swift;
    }
  }
}
