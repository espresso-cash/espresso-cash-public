import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import 'src/bl/conversion_rates_bloc.dart';
import 'src/bl/repository.dart';

class ConversionRatesModule extends SingleChildStatelessWidget {
  const ConversionRatesModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ConversionRatesRepository>.value(
            value: sl<ConversionRatesRepository>(),
          ),
          BlocProvider(create: (_) => sl<ConversionRatesBloc>())
        ],
        child: child,
      );
}
