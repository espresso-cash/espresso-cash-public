import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../utils/flow.dart';
import '../../accounts/services/account_service.dart';
import '../services/sign_in_bloc.dart';
import 'get_started_screen.dart';
import 'restore_account_screen.dart';

class SignInFlowScreen extends StatefulWidget {
  const SignInFlowScreen({super.key});

  static void open(BuildContext context, {NavigatorState? navigator}) =>
      (navigator ?? Navigator.of(context, rootNavigator: true))
          .pushAndRemoveUntil<void>(
        MaterialPageRoute(builder: (context) => const SignInFlowScreen()),
        F,
      );

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen> {
  final _bloc = sl<SignInBloc>();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _handleSignInPressed() => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => RestoreAccountScreen(
            onSubmit: _handleRestore,
          ),
        ),
      );

  void _handleCreateLocalPressed() =>
      _bloc.add(const SignInEvent.newLocalWalletRequested());

  void _handleRestore(String phrase) {
    _bloc
      ..add(SignInEvent.existingLocalWalletRequested(phrase))
      ..add(const SignInEvent.submitted());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SignInBloc, SignInState>(
        bloc: _bloc,
        listener: (context, state) => switch (state.processingState) {
          FlowFailure(:final error) => error.when(
              seedVaultActionCanceled: ignore,
              generic: (e) => showErrorDialog(context, 'Error', e),
            ),
          FlowSuccess(:final result) => runWithLoader(
              context,
              () => sl<AccountService>()
                  .logIn(source: state.source, account: result),
            ),
          _ => null,
        },
        builder: (context, state) => CpLoader(
          isLoading: state.processingState.isProcessing,
          child: GetStartedScreen(
            onSignInPressed: _handleSignInPressed,
            onLocalPressed: _handleCreateLocalPressed,
          ),
        ),
      );
}
