import 'package:decimal/decimal.dart';

enum RampPartner {
  kado(title: 'Kado Money', minimumAmount: r'$10'),
  rampNetwork(title: 'Ramp Network', minimumAmount: r'$7'),
  coinflow(title: 'Coinflow', minimumAmount: r'$20'),
  guardarian(title: 'Guardarian', minimumAmount: r'$5'),
  scalex(title: 'Scalex', minimumAmount: r'$5'),
  moneygram(title: 'MoneyGram', minimumAmount: r'$5');

  const RampPartner({required this.title, required this.minimumAmount});

  final String title;
  final String minimumAmount;

  Decimal get minimumAmountInDecimal =>
      Decimal.parse(minimumAmount.substring(1));
}
