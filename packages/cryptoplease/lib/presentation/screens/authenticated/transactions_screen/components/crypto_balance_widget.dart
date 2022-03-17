import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/watch_balance.dart';
import 'package:flutter/material.dart';

class CryptoBalanceWidget extends StatelessWidget {
  const CryptoBalanceWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final Amount cryptoAmount = context.watchUserCryptoBalance(token);
    final Amount? fiatAmount = context.watchUserFiatBalance(token);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showFiatAmount = constraints.maxHeight > 75;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  cryptoAmount.format(locale),
                  style: _cryptoBalanceTextStyle,
                  maxLines: 1,
                ),
              ),
              if (fiatAmount != null)
                Flexible(
                  child: Text(
                    showFiatAmount ? '≈ ${fiatAmount.format(locale)}' : '',
                    style: _fiatBalanceTextStyle,
                    maxLines: 1,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

const _fiatBalanceTextStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const _cryptoBalanceTextStyle = TextStyle(
  fontSize: 42,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
