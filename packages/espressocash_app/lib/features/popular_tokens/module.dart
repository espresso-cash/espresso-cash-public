import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../accounts/module.dart';
import 'data/repository.dart';
import 'services/bloc.dart';

class PopularTokensModule extends SingleChildStatelessWidget {
  const PopularTokensModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<PopularTokenBloc>(
            create: (context) => sl<PopularTokenBloc>()..add(const Init()),
          ),
          LogoutListener(
            onLogout: (_) => sl<PopularTokenRepository>().clear(),
          ),
        ],
        child: child,
      );
}
