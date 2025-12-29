// ignore_for_file: avoid-duplicate-constant-values

import 'package:decimal/decimal.dart';
import '../../../gen/assets.gen.dart';
import 'payment_methods.dart';

enum RampPartner {
  kado(title: 'Kado Money', minimumAmount: r'$10', paymentMethods: []),

  coinflow(title: 'Coinflow', minimumAmount: r'$20', paymentMethods: []),

  guardarian(title: 'Guardarian', minimumAmount: r'$5', paymentMethods: []),

  moneygram(title: 'MoneyGram', minimumAmount: r'$10', paymentMethods: []),

  brijRedirect(
    title: 'Brij Network',
    minimumAmount: r'$5',
    paymentMethods: [
      PaymentMethod.visa,
      PaymentMethod.mastercard,
      PaymentMethod.applePay,
      PaymentMethod.googlePay,
      PaymentMethod.sepa,
      PaymentMethod.swift,
    ],
  );

  const RampPartner({
    required this.title,
    required this.minimumAmount,
    required this.paymentMethods,
  });

  final String title;
  final String minimumAmount;
  final List<PaymentMethod> paymentMethods;

  Decimal get minimumAmountInDecimal => Decimal.parse(minimumAmount.substring(1));
}

extension RampPartnerAssets on RampPartner {
  AssetGenImage get logo => switch (this) {
    RampPartner.kado ||
    RampPartner.coinflow ||
    RampPartner.guardarian ||
    RampPartner.moneygram ||
    RampPartner.brijRedirect => Assets.brands.brij,
  };
}
