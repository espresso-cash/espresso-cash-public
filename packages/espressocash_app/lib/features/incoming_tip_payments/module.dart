import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/it_bloc.dart';
import 'src/bl/it_repository.dart';
import 'src/widgets/link_listener.dart';

class ITModule extends SingleChildStatelessWidget {
  const ITModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<ITBloc>(
            create: (context) => sl<ITBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
          LogoutListener(
            onLogout: (_) => sl<ITRepository>().clear(),
          ),
        ],
        child: TipLinkListener(child: child ?? const SizedBox.shrink()),
      );
}
