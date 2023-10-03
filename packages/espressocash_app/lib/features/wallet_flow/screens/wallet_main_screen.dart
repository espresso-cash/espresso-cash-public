import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/tokens/token.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/theme.dart';
import '../../../ui/usdc_info.dart';
import '../../conversion_rates/widgets/amount_with_equivalent.dart';

class WalletMainScreen extends StatefulWidget {
  const WalletMainScreen({
    super.key,
    required this.onScan,
    required this.onAmountChanged,
    required this.onRequest,
    required this.onPay,
    required this.amount,
    required this.token,
    this.shakeKey,
    this.error = '',
  });

  final VoidCallback onScan;
  final VoidCallback onRequest;
  final VoidCallback onPay;
  final ValueSetter<Decimal> onAmountChanged;
  final FiatAmount amount;
  final Token token;
  final Key? shakeKey;
  final String error;

  @override
  State<WalletMainScreen> createState() => _ScreenState();
}

class _ScreenState extends State<WalletMainScreen> {
  late final TextEditingController _amountController;
  // ignore: dispose-fields, it's not created in this class
  TabController? _tabController;

  WalletOperation _action = WalletOperation.pay;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _amountController.addListener(_updateValue);
  }

  @override
  void dispose() {
    _amountController
      ..removeListener(_updateValue)
      ..dispose();
    _tabController?.removeListener(_handleTabUpdate);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WalletMainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newAmount = widget.amount.decimal;
    final locale = DeviceLocale.localeOf(context);
    final currentAmount = _amountController.text.toDecimalOrZero(locale);
    if (newAmount != oldWidget.amount.decimal && newAmount != currentAmount) {
      _amountController.text = newAmount.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController?.removeListener(_handleTabUpdate);
    _tabController = DefaultTabController.of(context)
      ..addListener(_handleTabUpdate);
    _updateAction();
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    widget.onAmountChanged(amount);
  }

  void _handleTabUpdate() => setState(_updateAction);

  void _updateAction() {
    final tab = _tabController?.index ?? 0;

    _action = WalletOperation.values[tab];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(
          leading: Center(
            child: CpIconButton(
              onPressed: widget.onScan,
              icon: Assets.icons.qrScanner.svg(color: Colors.white),
              variant: CpIconButtonVariant.black,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: 220,
              child: CpTabBar(
                tabs: [
                  Tab(text: context.l10n.pay),
                  Tab(text: context.l10n.receive),
                ],
                variant: CpTabBarVariant.black,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              AmountWithEquivalent(
                inputController: _amountController,
                token: widget.token,
                collapsed: false,
                shakeKey: widget.shakeKey,
                error: widget.error,
              ),
              const SizedBox(height: 8),
              UsdcInfoWidget(isSmall: width < 400),
              Expanded(
                child: AmountKeypad(
                  controller: _amountController,
                  maxDecimals: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CpButton(
                  text: _action.buttonLabel(context),
                  minWidth: width,
                  onPressed: () {
                    switch (_action) {
                      case WalletOperation.pay:
                        widget.onPay();
                      case WalletOperation.request:
                        widget.onRequest();
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

extension on WalletOperation {
  String buttonLabel(BuildContext context) {
    switch (this) {
      case WalletOperation.pay:
        return context.l10n.pay;
      case WalletOperation.request:
        return context.l10n.receive;
    }
  }
}

enum WalletOperation { pay, request }
