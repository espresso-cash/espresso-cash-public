import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/file_manager.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../bl/sign_in_bloc.dart';

class SignInFlowScreen extends StatefulWidget {
  const SignInFlowScreen({Key? key}) : super(key: key);

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen>
    implements SignInRouter {
  @override
  void onSignIn() => context.router.push(const RestoreAccountRoute());

  @override
  void onMnemonicConfirmed() => context.router.push(const SignInProfileRoute());

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => SignInBloc(
              sl<FileManager>(),
              context.read<AccountsBloc>(),
            ),
          ),
          Provider<SignInRouter>.value(value: this),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) => state.processingState.maybeWhen(
            error: (e) => showErrorDialog(context, 'Error', e),
            orElse: ignore,
          ),
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: const AutoRouter(),
          ),
        ),
      );
}

abstract class SignInRouter {
  void onSignIn();
  void onMnemonicConfirmed();
}

extension SignInRouterExt on BuildContext {
  SignInRouter get signInRouter => read<SignInRouter>();
}
