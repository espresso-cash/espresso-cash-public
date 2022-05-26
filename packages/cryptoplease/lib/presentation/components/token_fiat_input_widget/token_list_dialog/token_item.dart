import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenItem extends StatelessWidget {
  const TokenItem({
    Key? key,
    required this.token,
    required this.onSelected,
  }) : super(key: key);

  final ValueSetter<Token> onSelected;
  final Token token;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => onSelected(token),
        leading: TokenIcon(token: token, size: 40),
        title: Text(
          token.symbol,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(fontWeight: FontWeight.normal),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          token.name,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                color: CpColors.secondaryTextColor,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      );
}
