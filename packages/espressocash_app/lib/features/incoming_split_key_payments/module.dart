import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/iskp_repository.dart';
import 'src/widgets/pending_iskp_listener.dart';

class ISKPModule extends SingleChildStatelessWidget {
  const ISKPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<ISKPBloc>(
            create: (context) => sl<ISKPBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: LogoutListener(
          onLogout: (_) => sl<ISKPRepository>().clear(),
          child: PendingISKPListener(child: child ?? const SizedBox.shrink()),
        ),
      );
}
