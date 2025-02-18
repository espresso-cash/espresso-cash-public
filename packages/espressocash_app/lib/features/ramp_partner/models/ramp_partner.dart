import 'package:decimal/decimal.dart';
import '../../../gen/assets.gen.dart';
import 'payment_methods.dart';

class BrijParams {
  const BrijParams({
    required this.partnerPK,
    required this.termsUrl,
    required this.privacyUrl,
  });

  final String partnerPK;
  final String termsUrl;
  final String privacyUrl;
}

enum RampPartner {
  kado(
    title: 'Kado Money',
    minimumAmount: r'$10',
    paymentMethods: [
      PaymentMethod.visa,
      PaymentMethod.mastercard,
      PaymentMethod.applePay,
      PaymentMethod.bank,
      PaymentMethod.sepa,
      PaymentMethod.pix,
    ],
  ),

  rampNetwork(
    title: 'Ramp Network',
    minimumAmount: r'$7',
    paymentMethods: [
      PaymentMethod.visa,
      PaymentMethod.mastercard,
      PaymentMethod.applePay,
      PaymentMethod.googlePay,
      PaymentMethod.bank,
    ],
  ),

  coinflow(
    title: 'Coinflow',
    minimumAmount: r'$20',
    paymentMethods: [
      PaymentMethod.visa,
      PaymentMethod.mastercard,
      PaymentMethod.bank,
    ],
  ),

  guardarian(
    title: 'Guardarian',
    minimumAmount: r'$5',
    paymentMethods: [
      PaymentMethod.visa,
      PaymentMethod.mastercard,
      PaymentMethod.applePay,
      PaymentMethod.googlePay,
      PaymentMethod.sepa,
      PaymentMethod.swift,
    ],
  ),

  scalex(
    title: 'Scalex',
    minimumAmount: r'$5',
    paymentMethods: [PaymentMethod.bank],
  ),

  moneygram(
    title: 'MoneyGram',
    minimumAmount: r'$10',
    paymentMethods: [],
  ),

  brij(
    title: 'Brij Network (DEMO)',
    minimumAmount: r'$5',
    paymentMethods: [PaymentMethod.bank],
    brijParams: BrijParams(
      partnerPK: '9YmsP8PoWfNaTwBjLRy8R5Yr9Ukcu2hvVvzea8mRpnKp',
      termsUrl: 'https://brij.network/terms',
      privacyUrl: 'https://brij.network/privacy',
    ),
  ),

  scalexBrij(
    title: 'Scalex (via BRIJ)',
    minimumAmount: r'$5',
    paymentMethods: [PaymentMethod.bank],
    brijParams: BrijParams(
      partnerPK: '342yN5YEX6bgGaTCuprVquFXhpZ8twyPzBo5kMZWQpDQ',
      termsUrl: 'https://www.scalex.africa/termsofuse',
      privacyUrl: 'https://www.scalex.africa/privacypolicy',
    ),
  );

  const RampPartner({
    required this.title,
    required this.minimumAmount,
    required this.paymentMethods,
    this.brijParams,
  });

  final String title;
  final String minimumAmount;
  final List<PaymentMethod> paymentMethods;

  final BrijParams? brijParams;

  Decimal get minimumAmountInDecimal =>
      Decimal.parse(minimumAmount.substring(1));
}

extension RampPartnerAssets on RampPartner {
  AssetGenImage get logo {
    switch (this) {
      case RampPartner.kado:
        return Assets.brands.kado;
      case RampPartner.rampNetwork:
        return Assets.brands.ramp;
      case RampPartner.coinflow:
        return Assets.brands.coinflow;
      case RampPartner.guardarian:
        return Assets.brands.guardarian;
      case RampPartner.scalex:
      case RampPartner.scalexBrij:
        return Assets.brands.scalex;
      case RampPartner.moneygram:
        return Assets.brands.moneygram;
      case RampPartner.brij:
        return Assets.brands.brij;
    }
  }
}
