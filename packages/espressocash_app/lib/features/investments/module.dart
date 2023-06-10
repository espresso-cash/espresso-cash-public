import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/data/repository.dart';

class InvestmentModule extends SingleChildStatelessWidget {
  const InvestmentModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<InvestmentSettingsRepository>(
            create: (context) => sl<InvestmentSettingsRepository>(),
          ),
          LogoutListener(
            onLogout: (context) =>
                context.read<InvestmentSettingsRepository>().clear(),
          ),
        ],
        child: child,
      );
}
