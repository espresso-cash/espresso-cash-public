import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/amount.dart';
import '../../../../core/balances/context_ext.dart';
import '../../../../core/conversion_rates/context_ext.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/user_preferences.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/slider.dart';
import '../../../../ui/snackbar.dart';
import '../../../../ui/theme.dart';
import '../bl/bloc.dart';

class TokenConfirmScreen extends StatelessWidget {
  const TokenConfirmScreen({
    super.key,
    required this.token,
    required this.to,
    required this.amount,
  });
  final Token token;
  final String to;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final account = context.read<MyAccount>().wallet as LocalWallet;
    final wallet = account.wallet;
    final from = account.wallet?.getAddressForCoin(ethCoinId);

    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final conversionRate =
        context.watchConversionRate(from: token, to: fiatCurrency);

    final fiatAmount = Amount.fromDecimal(
      value: Decimal.parse(amount.toString()),
      currency: const CryptoCurrency(token: Token.eth),
    ).convert(
      rate: conversionRate!,
      to: fiatCurrency,
    );

    return BlocProvider(
      create: (context) => sl<TransferBloc>(),
      child: CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: AppBar(
            title: const Text('Transfer'),
          ),
          body: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              state.maybeWhen(
                success: (val) async {
                  showCpSnackbar(
                    context,
                    message: 'Success!',
                    icon: const Icon(Icons.check, color: Colors.green),
                  );
                  context.notifyBalanceAffected();
                  await context.router.pop();
                  await context.router.pop();
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              if (state.isProcessing()) return const LoadingIndicator();

              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        '$amount ${token.symbol}',
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        '~${fiatAmount.format(
                          DeviceLocale.localeOf(context),
                          roundInteger: true,
                        )}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _Item(
                      title: 'Asset',
                      value: '${token.name} (${token.symbol})',
                    ),
                    _Item(
                      title: 'From',
                      value: from!,
                    ),
                    _Item(title: 'To', value: to),
                    const Spacer(),
                    CpSlider(
                      text: 'Slide to confirm',
                      onSlideCompleted: () {
                        context.read<TransferBloc>().add(
                              TransferEvent.submitted(
                                token: token,
                                destination: to,
                                wallet: wallet!,
                                amount: amount,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      );
}
