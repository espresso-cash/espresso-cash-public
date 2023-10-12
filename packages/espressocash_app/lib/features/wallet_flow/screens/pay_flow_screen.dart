import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/theme.dart';
import '../widgets/pay_page.dart';

@RoutePage()
class PayFlowScreen extends StatelessWidget {
  const PayFlowScreen({
    super.key,
    required this.onLink,
    required this.onManual,
  });
  final VoidCallback onLink;
  final VoidCallback onManual;

  static const route = PayFlowRoute.new;

  @override
  Widget build(BuildContext context) => PayPage(
        title: context.l10n.walletTransactionMethodTitle,
        headerIcon: Assets.images.identityGraphic,
        headerBackground: Assets.images.sendMoneyBg,
        headerContent: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                context.l10n.walletEspressoPayLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            CpButton(
              text: context.l10n.send,
              width: double.infinity,
              size: CpButtonSize.big,
              trailing: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: _Arrow(),
              ),
              onPressed: onLink,
            ),
            const SizedBox(height: 36),
          ],
        ),
        content: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 27),
              const _OthersTitle(),
              const SizedBox(height: 5),
              _Item(
                title: context.l10n.walletManualPayLabel,
                onTap: onManual,
              ),
            ],
          ),
        ),
      );
}

class _OthersTitle extends StatelessWidget {
  const _OthersTitle();

  @override
  Widget build(BuildContext context) => Text(
        context.l10n.walletPayOther,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: CpTheme.of(context).primaryTextColor,
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 18,
        ),
        child: ListTile(
          tileColor: const Color(0xff413D3F),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(63)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const _Arrow(color: Colors.white),
          onTap: onTap,
        ),
      );
}

class _Arrow extends StatelessWidget {
  const _Arrow({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: Assets.icons.arrow.svg(
          height: 14,
          color: color ?? const Color(0xFF2D2B2C),
        ),
      );
}
