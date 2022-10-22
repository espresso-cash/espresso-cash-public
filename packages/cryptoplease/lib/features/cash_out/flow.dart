import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/cash_out/cash_out_screen.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';

extension CashOutFlowExt on BuildContext {
  void navigateToCashOut() => router.navigate(const CashOutFlowRoute());
}

class CashOutFlowScreen extends StatefulWidget {
  const CashOutFlowScreen({Key? key}) : super(key: key);

  @override
  State<CashOutFlowScreen> createState() => _CashOutFlowScreenState();
}

class _CashOutFlowScreenState extends State<CashOutFlowScreen> {
  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CloseButton(),
            title: Text(context.l10n.cashOut.toUpperCase()),
          ),
          body: CpContentPadding(
            child: CashOutScreen(
              onFtxSelected: () => context.openLink(ftxSupportUrl),
            ),
          ),
        ),
      );
}
