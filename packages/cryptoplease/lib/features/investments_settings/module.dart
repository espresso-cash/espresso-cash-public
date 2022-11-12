import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import 'src/data/repository.dart';

export 'src/data/repository.dart';

class InvestmentSettingsModule extends SingleChildStatelessWidget {
  const InvestmentSettingsModule({Key? key, Widget? child})
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
