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
  AssetGenImage get logo {
    switch (this) {
      case PaymentMethod.visa:
        return Assets.images.visaIcon;
      case PaymentMethod.mastercard:
        return Assets.images.mastercardIcon;
      case PaymentMethod.applePay:
        return Assets.images.applepayIcon;
      case PaymentMethod.googlePay:
        return Assets.images.gpayIcon;
      case PaymentMethod.bank:
        return Assets.images.bankIcon;
      case PaymentMethod.sepa:
        return Assets.images.sepaIcon;
      case PaymentMethod.pix:
        return Assets.images.pixIcon;
      case PaymentMethod.swift:
        return Assets.images.swiftIcon;
    }
  }
}
