import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/dynamic_links_notifier.dart';
import '../../../core/flow.dart';
import '../../../core/link_payments.dart';
import '../../../core/router_wrapper.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../saga.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../accounts/services/accounts_bloc.dart';
import '../services/sign_in_bloc.dart';
import 'create_wallet_loading_screen.dart';
import 'get_started_screen.dart';
import 'restore_account_screen.dart';

@RoutePage()
class SignInFlowScreen extends StatefulWidget {
  const SignInFlowScreen({super.key});

  static const route = SignInFlowRoute.new;

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen>
    with RouterWrapper {
  late final SignInBloc _signInBloc;

  void _handleSignInPressed() => router?.push(
        RestoreAccountScreen.route(
          onMnemonicConfirmed: _handleMnemonicConfirmed,
        ),
      );

  void _handleMnemonicConfirmed() =>
      _signInBloc.add(const SignInEvent.submitted());

  @override
  PageRouteInfo get initialRoute => GetStartedScreen.route(
        isSaga: isSaga,
        onSignInPressed: _handleSignInPressed,
      );

  @override
  void initState() {
    super.initState();
    _signInBloc = sl<SignInBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.watch<DynamicLinksNotifier>().link?.let(_parseUri).let((valid) {
      if (valid) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => context.router.push(CreateWalletLoadingScreen.route()),
        );
      }
    });
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<SignInBloc>.value(value: _signInBloc),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) => switch (state.processingState) {
            FlowFailure(:final error) => error.when(
                seedVaultActionCanceled: ignore,
                generic: (e) => showErrorDialog(context, 'Error', e),
              ),
            FlowSuccess(:final result) => context.read<AccountsBloc>().add(
                  AccountsEvent.created(
                    account: result.account,
                    source: state.source,
                  ),
                ),
            _ => null,
          },
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: AutoRouter(key: routerKey),
          ),
        ),
      );
}

bool _parseUri(Uri? link) {
  if (link == null) return false;

  return LinkPayments.tryParse(link) != null;
}
