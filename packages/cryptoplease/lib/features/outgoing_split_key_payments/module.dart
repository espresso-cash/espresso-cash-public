import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class OSKPModule extends SingleChildStatelessWidget {
  const OSKPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<OSKPBloc>(
            create: (context) => sl<OSKPBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: child,
      );
}
