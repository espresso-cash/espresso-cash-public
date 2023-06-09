import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../core/split_key_payments.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../../../../saga.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../bl/sign_in_bloc.dart';

@RoutePage()
class SignInFlowScreen extends StatefulWidget {
  const SignInFlowScreen({super.key});

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen>
    with RouterWrapper
    implements SignInRouter {
  @override
  void onSignIn() => context.router.push(const RestoreAccountRoute());

  @override
  void onMnemonicConfirmed() => context.router.push(const SignInProfileRoute());

  @override
  PageRouteInfo get initialRoute => GetStartedRoute(isSaga: isSaga);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.watch<DynamicLinksNotifier>().link?.let(_parseUri).let((valid) {
      if (valid) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => context.router.push(const CreateWalletLoadingRoute()),
        );
      }
    });
  }

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
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing(),
            child: AutoRouter(key: routerKey),
          ),
        ),
      );
}

abstract class SignInRouter {
  const SignInRouter();

  void onSignIn();
  void onMnemonicConfirmed();
}

extension SignInRouterExt on BuildContext {
  SignInRouter get signInRouter => read<SignInRouter>();
}

bool _parseUri(Uri? link) {
  if (link == null) return false;

  return SplitKeyFirstLink.tryParse(link) != null;
}
