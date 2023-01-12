import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/bloc.dart';
import 'src/bl/repository.dart';

class OTModule extends SingleChildStatelessWidget {
  const OTModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<OTBloc>(
            create: (context) => sl<OTBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
          LogoutListener(
            onLogout: (_) => sl<OTRepository>().clear(),
          ),
        ],
        child: child,
      );
}
