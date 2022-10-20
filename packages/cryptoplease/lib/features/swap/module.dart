import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class SwapModule extends SingleChildStatelessWidget {
  const SwapModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<SwapVerifierBloc>(
            create: (context) => sl<SwapVerifierBloc>(
              param1: context.read<MyAccount>(),
            ),
          ),
        ],
        child: child,
      );
}
