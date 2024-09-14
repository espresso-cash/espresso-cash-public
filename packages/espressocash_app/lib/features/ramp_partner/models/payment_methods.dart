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
        return Assets.icons.visaIcon;
      case PaymentMethod.mastercard:
        return Assets.icons.mastercardIcon;
      case PaymentMethod.applePay:
        return Assets.icons.applepayIcon;
      case PaymentMethod.googlePay:
        return Assets.icons.gpayIcon;
      case PaymentMethod.bank:
        return Assets.icons.bankIcon;
      case PaymentMethod.sepa:
        return Assets.icons.sepaIcon;
      case PaymentMethod.pix:
        return Assets.icons.pixIcon;
      case PaymentMethod.swift:
        return Assets.icons.swiftIcon;
    }
  }
}
