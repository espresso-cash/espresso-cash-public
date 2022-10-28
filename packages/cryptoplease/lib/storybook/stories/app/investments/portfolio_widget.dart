import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../../app/screens/authenticated/investments/components/portfolio_widget.dart';
import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../core/user_preferences.dart';
import '../../../../di.dart';
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
