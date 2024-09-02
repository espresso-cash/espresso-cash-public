import 'package:decimal/decimal.dart';
import '../../../gen/assets.gen.dart';

enum RampPartner {
  kado(
    title: 'Kado Money',
    minimumAmount: r'$10',
  ),
  rampNetwork(
    title: 'Ramp Network',
    minimumAmount: r'$7',
  ),
  coinflow(
    title: 'Coinflow',
    minimumAmount: r'$20',
  ),
  guardarian(
    title: 'Guardarian',
    minimumAmount: r'$5',
  ),
  scalex(
    title: 'Scalex',
    minimumAmount: r'$5',
  ),
  moneygram(
    title: 'MoneyGram',
    minimumAmount: r'$5',
  );

  const RampPartner({
    required this.title,
    required this.minimumAmount,
  });

  final String title;
  final String minimumAmount;

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
        return Assets.images.moneygramIcon;
      case RampPartner.scalex:
        return Assets.images.moneygramIcon;
      case RampPartner.moneygram:
        return Assets.images.moneygramIcon;
    }
  }
}
