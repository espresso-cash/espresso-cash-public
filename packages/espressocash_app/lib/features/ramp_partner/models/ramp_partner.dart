import 'package:decimal/decimal.dart';
import '../../../gen/assets.gen.dart';
import 'payment_methods.dart';

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
  );

  const RampPartner({
    required this.title,
    required this.minimumAmount,
    required this.paymentMethods,
  });

  final String title;
  final String minimumAmount;
  final List<PaymentMethod> paymentMethods;

  Decimal get minimumAmountInDecimal =>
      Decimal.parse(minimumAmount.substring(1));
}

extension RampPartnerAssets on RampPartner {
  AssetGenImage get logo {
    switch (this) {
      case RampPartner.kado:
        return Assets.images.kadoIcon;
      case RampPartner.rampNetwork:
        return Assets.images.rampIcon;
      case RampPartner.coinflow:
        return Assets.images.coinflowIcon;
      case RampPartner.guardarian:
        return Assets.images.guardianIcon;
      case RampPartner.scalex:
        return Assets.images.scalexIcon;
      case RampPartner.moneygram:
        return Assets.images.moneygramIcon;
    }
  }
}
