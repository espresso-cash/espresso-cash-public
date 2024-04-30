import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil<void>(
        MaterialPageRoute(builder: (context) => const SignInFlowScreen()),
        F,
      );

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen> {
  final _navigator = GlobalKey<NavigatorState>();

  void _handleSignInPressed() => _navigator.currentState?.pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const RestoreAccountScreen(),
        ),
      );

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
                    .logIn(source: state.source, account: result),
              ),
            _ => null,
          },
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: HeroControllerScope(
              controller: HeroController(),
              child: Navigator(
                key: _navigator,
                onGenerateInitialRoutes: (navigator, initialRoute) => [
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder: _fadeTransitionBuilder,
                    pageBuilder: (context, _, __) => GetStartedScreen(
                      onSignInPressed: _handleSignInPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

Widget _fadeTransitionBuilder(
  BuildContext _,
  Animation<double> animation,
  Animation<double> __,
  Widget child,
) =>
    FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    );
