import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/watch_balance.dart';
import 'package:flutter/material.dart';

class BalanceItem extends StatelessWidget {
  const BalanceItem({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final Amount balance = context.watchUserCryptoBalance(token);
    final fiatAmount = context.watchUserFiatBalance(token);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.router.push(TransactionsRoute(token: token)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TokenIcon(token: token, size: 50),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  token.name,
                  style: _titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  Text(fiatAmount?.format(locale) ?? '-', style: _titleStyle),
                  Text(
                    balance.format(locale, skipSymbol: true),
                    style: _subtitleStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: Colors.black,
);

const _subtitleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 13,
  color: Color.fromARGB(0xff, 0x90, 0x90, 0x90),
);
