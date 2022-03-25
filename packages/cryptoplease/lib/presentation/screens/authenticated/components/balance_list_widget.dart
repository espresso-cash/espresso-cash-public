import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/balance_item.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class BalanceListWidget extends StatelessWidget {
  const BalanceListWidget({
    Key? key,
    required this.tokens,
    required this.isLoading,
    required this.emptyWidget,
  }) : super(key: key);

  final Iterable<Token> tokens;
  final bool isLoading;
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) => CpHeaderedListContent(
        padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
        itemCount: tokens.length,
        itemBuilder: (context, index) => BalanceItem(
          token: tokens.elementAt(index),
        ),
        emptyWidget: isLoading
            ? CpEmptyMessageWidget(message: context.l10n.loading)
            : emptyWidget,
      );
}
