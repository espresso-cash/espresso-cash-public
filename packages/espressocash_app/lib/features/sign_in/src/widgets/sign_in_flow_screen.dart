import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/split_key_payments.dart';
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
          BlocProvider(create: (_) => sl<SignInBloc>()),
          Provider<SignInRouter>.value(value: this),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) => state.processingState.maybeWhen(
            failure: (it) => it.when(
              seedVaultActionCanceled: ignore,
              generic: (e) => showErrorDialog(context, 'Error', e),
            ),
            success: (result) => context.read<AccountsBloc>().add(
                  AccountsEvent.created(
                    account: result.account,
                    source: state.source,
                    hasFinishedOnboarding: result.hasFinishedOnboarding,
                  ),
                ),
            orElse: ignore,
          ),
          builder: (context, state) {
            final isValidLink =
                context.watch<DynamicLinksNotifier>().link.let(_parseUri);

            return CpLoader(
              isLoading: state.processingState.isProcessing(),
              child: AutoRouter.declarative(
                routes: (_) => [
                  if (isValidLink)
                    const CreateWalletLoadingRoute()
                  else
                    const SignUpFlowRoute(),
                ],
              ),
            );
          },
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

bool _parseUri(Uri? link) {
  if (link == null) return false;

  final firstPartLink = SplitKeyFirstLink.tryParse(link);
  if (firstPartLink != null) {
    return true;
  }

  return false;
}
