import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/watch_balance.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SelectableBalanceItem extends StatelessWidget {
  const SelectableBalanceItem({
    Key? key,
    required this.token,
    required this.onSelect,
  }) : super(key: key);

  final Token token;
  final ValueSetter<Token> onSelect;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final balance = context.watchUserCryptoBalance(token);

    return InkWell(
      onTap: () => onSelect(token),
      child: Card(
        color: CpColors.accentDarkBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: TokenIcon(size: 40, token: token),
            title: Text(
              token.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(balance.format(locale)),
          ),
        ),
      ),
    );
  }
}
