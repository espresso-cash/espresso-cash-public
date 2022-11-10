import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/empty_message_widget.dart';
import '../../../../../ui/tab_bar.dart';
import '../../../../../ui/token_icon.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key, required this.tokens});

  final IList<Token> tokens;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                context.l10n.myPortfolio,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.17,
                  color: CpColors.menuPrimaryTextColor,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 12, bottom: 21),
              sliver: SliverToBoxAdapter(
                child: CpTabBar(
                  tabs: [
                    Tab(text: context.l10n.crypto),
                    Tab(text: context.l10n.stablecoin),
                    Tab(text: context.l10n.all),
                  ],
                ),
              ),
            ),
            if (tokens.isEmpty)
              SliverToBoxAdapter(
                child: CpEmptyMessageWidget(message: context.l10n.loading),
              )
            else
              _BalanceList(tokens: tokens),
          ],
        ),
      );
}

class _BalanceList extends StatefulWidget {
  const _BalanceList({required this.tokens});

  final IList<Token> tokens;

  @override
  State<_BalanceList> createState() => _BalanceListState();
}

class _BalanceListState extends State<_BalanceList> {
  List<Widget> _items = [];
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController?.removeListener(_handleTabUpdate);
    _tabController = DefaultTabController.of(context)
      ?..addListener(_handleTabUpdate);
    _updateItems();
  }

  @override
  void didUpdateWidget(covariant _BalanceList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tokens != widget.tokens) {
      _updateItems();
    }
  }

  void _handleTabUpdate() => setState(_updateItems);

  void _updateItems() {
    final tab = _tabController?.index ?? 0;
    _items = [
      for (final token in widget.tokens)
        if (tab == 0 && !token.isStablecoin ||
            tab == 1 && token.isStablecoin ||
            tab == 2)
          _BalanceItem(token: token),
    ];
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(_items),
      );
}

class _BalanceItem extends StatelessWidget {
  const _BalanceItem({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final fiatAmount = context.watchUserFiatBalance(token);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.router.push(TokenDetailsRoute(token: token)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          decoration: const BoxDecoration(
            color: CpColors.yellowColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CpTokenIcon(token: token, size: 35),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  token.name,
                  style: _titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _AmountDisplay(fiatAmount?.format(locale) ?? '-'),
            ],
          ),
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16.5,
  color: Colors.black,
);

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay(
    this.amount, {
    Key? key,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 115,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: CpColors.darkBackground,
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
        ),
      );
}
