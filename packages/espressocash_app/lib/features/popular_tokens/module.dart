import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/module.dart';
import '../../core/user_preferences.dart';
import '../../di.dart';
import 'src/bl/bloc.dart';
import 'src/bl/repository.dart';

class PopularTokensModule extends SingleChildStatelessWidget {
  const PopularTokensModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<PopularTokenBloc>(
            create: (context) => sl<PopularTokenBloc>(
              param1: context.read<UserPreferences>().fiatCurrency,
            )..add(const Init()),
          ),
          LogoutListener(
            onLogout: (_) => sl<PopularTokenRepository>().clear(),
          ),
        ],
        child: child,
      );
}
