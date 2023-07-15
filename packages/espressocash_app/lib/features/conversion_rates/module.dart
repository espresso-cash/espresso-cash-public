import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/currency.dart';
import '../../di.dart';
import '../balances/data/balances_repository.dart';
import 'data/repository.dart';
import 'services/conversion_rates_bloc.dart';

class ConversionRatesModule extends SingleChildStatelessWidget {
  const ConversionRatesModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ConversionRatesRepository>.value(
            value: sl<ConversionRatesRepository>(),
          ),
          BlocProvider(
            create: (context) => sl<ConversionRatesBloc>()
              ..add(
                ConversionRatesEvent.init(
                  userTokens: sl<BalancesRepository>().watchUserTokens(),
                  userCurrency: defaultFiatCurrency,
                ),
              ),
          )
        ],
        child: child,
      );
}
