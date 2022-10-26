import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/components/partner_button.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
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
        AddFundsRoute(
          wallet: read<MyAccount>().wallet,
          token: Token.usdc,
        ),
      );
}

class AddFundsScreen extends StatelessWidget {
  const AddFundsScreen({
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
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Text(
                        context.l10n.addCashSubtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14.5),
                      ),
                      const SizedBox(height: 24),
                      PartnerButton(
                        onTap: () => context
                            .read<AddFundsBloc>()
                            .add(const AddFundsEvent.kadoRequested()),
                        image: Assets.images.logoKado,
                        backgroundColor: const Color(0xff5272d6),
                      ),
                      PartnerButton(
                        onTap: () => context
                            .read<AddFundsBloc>()
                            .add(const AddFundsEvent.moonpayRequested()),
                        image: Assets.images.logoMoonpay,
                        backgroundColor: const Color(0xff6800f3),
                      ),
                      PartnerButton(
                        onTap: () => context
                            .read<AddFundsBloc>()
                            .add(const AddFundsEvent.ftxRequested()),
                        image: Assets.images.logoFtx,
                        backgroundColor: const Color(0xff12a8c9),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
