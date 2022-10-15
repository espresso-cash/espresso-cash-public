import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<ODPBloc>(
            create: (context) => sl<ODPBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: child,
      );
}
