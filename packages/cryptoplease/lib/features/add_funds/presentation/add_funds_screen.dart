import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/loader.dart';
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
        create: (_) => sl<AddFundsBloc>(),
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
                    ListTile(
                      title: const Text('Moonpay'),
                      onTap: () => context
                          .read<AddFundsBloc>()
                          .add(const AddFundsEvent.moonpayRequested()),
                    ),
                    ListTile(
                      title: const Text('Kado'),
                      onTap: () => context
                          .read<AddFundsBloc>()
                          .add(const AddFundsEvent.kadoRequested()),
                    ),
                    ListTile(
                      title: const Text('FTX'),
                      onTap: () => context
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
