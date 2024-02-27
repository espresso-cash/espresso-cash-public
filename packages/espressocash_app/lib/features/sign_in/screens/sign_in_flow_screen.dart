import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/flow.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../accounts/services/account_service.dart';
import '../services/sign_in_bloc.dart';

@RoutePage()
class SignInFlowScreen extends StatelessWidget {
  const SignInFlowScreen({super.key, required this.child});

  static const route = SignInFlowRoute.new;

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<SignInBloc>(create: (context) => sl<SignInBloc>()),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) => switch (state.processingState) {
            FlowFailure(:final error) => error.when(
                seedVaultActionCanceled: ignore,
                generic: (e) => showErrorDialog(context, 'Error', e),
              ),
            FlowSuccess(:final result) => runWithLoader(
                context,
                () => sl<AccountService>()
                    .logIn(source: state.source, account: result.account),
              ),
            _ => null,
          },
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: HeroControllerScope(
              controller: HeroController(),
              child: child,
            ),
          ),
        ),
      );
}
