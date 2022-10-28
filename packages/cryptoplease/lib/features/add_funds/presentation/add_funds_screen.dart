import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

import '../../../core/presentation/utils.dart';
import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../ui/partner_button.dart';
import '../../../ui/theme.dart';
import '../bl/add_funds_bloc.dart';

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
