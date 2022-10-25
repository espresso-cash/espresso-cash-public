import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/data/files.dart';
import 'package:cryptoplease/features/onboarding/bl/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignUpFlowScreen extends StatefulWidget {
  const SignUpFlowScreen({Key? key}) : super(key: key);

  @override
  State<SignUpFlowScreen> createState() => _SignUpFlowScreenState();
}

class _SignUpFlowScreenState extends State<SignUpFlowScreen>
    implements SignUpRouter {
  @override
  void onReadTerms() {
    context.router.push(const TermsOfServiceRoute());
  }

  @override
  void onSignIn() {
    context.router.push(const RestoreAccountRoute());
  }

  @override
  void onSignUp() {
    context.router.push(const NoEmailAndPasswordRoute());
  }

  @override
  void onExplainNoEmailAndPasswordCompleted() {
    context.router.push(const RecoveryWarningRoute());
  }

  @override
  void onRecoveryPhraseWarningCompleted() {
    context.router.push(const CreateRecoveryPhraseRoute());
  }

  @override
  void onMnemonicConfirmed() => context.router.push(const CreateProfileRoute());

  @override
  void onRegistered(MyAccount account) {
    context.router.replace(const AuthenticatedFlowRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => SignUpBloc(
              copyToAppDir,
              context.read<AccountsBloc>(),
            ),
          ),
          Provider<SignUpRouter>.value(value: this),
        ],
        child: const AutoRouter(),
      );
}

abstract class SignUpRouter {
  void onSignUp();
  void onSignIn();
  void onReadTerms();
  void onExplainNoEmailAndPasswordCompleted();
  void onRecoveryPhraseWarningCompleted();
  void onMnemonicConfirmed();
  void onRegistered(MyAccount account);
}
