import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SelectableBalanceItem extends StatelessWidget {
  const SelectableBalanceItem({
    Key? key,
    required this.token,
    required this.onSelect,
    this.balance,
  }) : super(key: key);

  final Token token;
  final ValueSetter<Token> onSelect;
  final Amount? balance;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final balance = this.balance;

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
            subtitle: balance == null ? null : Text(balance.format(locale)),
          ),
        ),
      ),
    );
  }
}
