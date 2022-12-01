import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import '../popular_tokens/module.dart';
import 'src/data/repository.dart';

export 'src/presentation/components/portfolio_widget.dart';
export 'src/presentation/investments_zero_balance_switch.dart';
export 'src/presentation/my_portfolio.dart';

class InvestmentModule extends SingleChildStatelessWidget {
  const InvestmentModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<InvestmentSettingsRepository>(
            create: (context) => sl<InvestmentSettingsRepository>(),
          ),
          const PopularTokensModule(),
          LogoutListener(
            onLogout: (context) =>
                context.read<InvestmentSettingsRepository>().clear(),
          ),
        ],
        child: child,
      );
}
