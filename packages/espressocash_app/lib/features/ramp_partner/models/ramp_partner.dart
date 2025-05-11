// ignore_for_file: avoid-duplicate-constant-values

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
    paymentMethods: [PaymentMethod.visa, PaymentMethod.mastercard, PaymentMethod.bank],
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

  moneygram(title: 'MoneyGram', minimumAmount: r'$10', paymentMethods: []),

  brij(
    title: 'Brij Network (DEMO)',
    minimumAmount: r'$5',
    paymentMethods: [PaymentMethod.bank],
    partnerPK: '9YmsP8PoWfNaTwBjLRy8R5Yr9Ukcu2hvVvzea8mRpnKp',
  );

  const RampPartner({
    required this.title,
    required this.minimumAmount,
    required this.paymentMethods,
    this.partnerPK,
  });

  final String title;
  final String minimumAmount;
  final List<PaymentMethod> paymentMethods;

  final String? partnerPK;

  Decimal get minimumAmountInDecimal => Decimal.parse(minimumAmount.substring(1));
}

extension RampPartnerAssets on RampPartner {
  AssetGenImage get logo => switch (this) {
    RampPartner.kado => Assets.brands.kado,
    RampPartner.rampNetwork => Assets.brands.ramp,
    RampPartner.coinflow => Assets.brands.coinflow,
    RampPartner.guardarian => Assets.brands.guardarian,
    RampPartner.moneygram => Assets.brands.moneygram,
    RampPartner.brij => Assets.brands.brij,
  };
}
