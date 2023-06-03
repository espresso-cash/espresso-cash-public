import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../core/tokens/token.dart';
import '../../di.dart';
import 'src/bloc.dart';

class TokenChartModule extends SingleChildStatelessWidget {
  const TokenChartModule(this.token, {super.key, super.child});

  final Token token;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocProvider<TokenChartBloc>(
        create: (_) => sl<TokenChartBloc>(param1: token)
          ..add(const FetchChartRequested(interval: defaultChartInterval)),
        child: child,
      );
}
