import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class AddFundsScreen extends StatelessWidget {
  const AddFundsScreen({
    Key? key,
    required this.wallet,
    required this.token,
  }) : super(key: key);

  final Wallet wallet;
  final Token token;

  @override
  Widget build(BuildContext context) => BlocProvider<AddFundsBloc>(
        create: (context) => AddFundsBloc(
          wallet: wallet,
          token: token,
          repository: context.read<AddFundsRepository>(),
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
          builder: (context, state) => Scaffold(
            appBar: CpAppBar(
              leading: const BackButton(),
              title: Text(context.l10n.addCash),
            ),
            body: CpLoader(
              isLoading: state.isProcessing(),
              child: CpContentPadding(
                child: ListView(
                  children: [
                    // TODO(rhbrunetto): add to arb file
                    const Text(
                      'Select a partner to add funds to your wallet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    CpActionSelectorButton(
                      text: 'Moonpay',
                      onPressed: () => context
                          .read<AddFundsBloc>()
                          .add(const AddFundsEvent.moonpayRequested()),
                    ),
                    CpActionSelectorButton(
                      text: 'Kado',
                      onPressed: () => context
                          .read<AddFundsBloc>()
                          .add(const AddFundsEvent.kadoRequested()),
                    ),
                    CpActionSelectorButton(
                      text: 'FTX',
                      onPressed: () => context
                          .read<AddFundsBloc>()
                          .add(const AddFundsEvent.ftxRequested()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
