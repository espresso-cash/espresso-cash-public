import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/add_cash/add_funds_screen.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/loader.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

extension AddCashFlowExt on BuildContext {
  void navigateToAddCash() => router.navigate(
        AddFundsFlowRoute(
          wallet: read<MyAccount>().wallet,
          token: Token.usdc,
        ),
      );
}

class AddFundsFlowScreen extends StatelessWidget {
  const AddFundsFlowScreen({
    Key? key,
    required this.token,
    required this.wallet,
  }) : super(key: key);

  final Token token;
  final Wallet wallet;

  @override
  Widget build(BuildContext context) => BlocProvider<AddFundsBloc>(
        create: (_) => sl<AddFundsBloc>(
          param1: token,
          param2: wallet,
        ),
        child: BlocConsumer<AddFundsBloc, AddFundsState>(
          listener: (context, state) => state.maybeWhen(
            failure: (_) => showWarningDialog(
              context,
              title: context.l10n.buySolFailedTitle,
              message: context.l10n.buySolFailedMessage,
            ),
            success: context.openLink,
            orElse: ignore,
          ),
          builder: (context, state) => CpTheme.dark(
            child: Scaffold(
              backgroundColor: CpColors.darkBackground,
              appBar: CpAppBar(
                leading: const CloseButton(),
                title: Text(context.l10n.addCashTitle.toUpperCase()),
              ),
              body: CpLoader(
                isLoading: state.isProcessing(),
                child: CpContentPadding(
                  child: AddFundsScreen(
                    onFtxSelected: () => context
                        .read<AddFundsBloc>()
                        .add(const AddFundsEvent.ftxRequested()),
                    onMoonpaySelected: () => context
                        .read<AddFundsBloc>()
                        .add(const AddFundsEvent.moonpayRequested()),
                    onKadoSelected: () => context
                        .read<AddFundsBloc>()
                        .add(const AddFundsEvent.kadoRequested()),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
