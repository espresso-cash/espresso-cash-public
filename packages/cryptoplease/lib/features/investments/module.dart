import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import 'src/data/repository.dart';

export 'src/data/repository.dart';
export 'src/presentation/components/portfolio_widget.dart';
export 'src/presentation/portfolio.dart';
export 'src/presentation/settings.dart';

class InvestmentModule extends SingleChildStatelessWidget {
  const InvestmentModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: sl<InvestmentSettingsRepository>(),
          )
        ],
        child: child,
      );
}
