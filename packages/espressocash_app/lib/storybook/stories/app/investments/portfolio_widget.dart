import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../../core/tokens/token_list.dart';
import '../../../../core/user_preferences.dart';
import '../../../../di.dart';
import '../../../../features/conversion_rates/data/repository.dart';
import '../../../../features/investments/widgets/portfolio_widget.dart';
import '../app_wrapper.dart';

final appPortfolioWidget = Story(
  name: 'App/Investments/PortfolioWidget',
  builder: (context) => MultiProvider(
    providers: [
      Provider(create: (_) => UserPreferences()),
      ChangeNotifierProvider.value(value: sl<ConversionRatesRepository>())
    ],
    child: AppWrapper(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Center(child: Text('Some header')),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: PortfolioWidget(tokens: _tokens),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Center(child: Text('Some footer')),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

final _tokens = TokenList()
    .tokens
    .where((t) => ['SOL', 'USDT', 'USDC'].contains(t.symbol))
    .toIList();
