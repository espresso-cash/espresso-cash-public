import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../../conversion_rates/bl/conversion_rates_bloc.dart';
import '../bl/balances_bloc.dart';
import '../refresh_balance.dart';

final _logger = Logger('RefreshBalanceWrapper');

typedef RefreshBalancesBuilder = Widget Function(BuildContext, AsyncCallback);

class RefreshBalancesWrapper extends StatefulWidget {
  const RefreshBalancesWrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final RefreshBalancesBuilder builder;

  @override
  State<RefreshBalancesWrapper> createState() => _RefreshBalancesWrapperState();
}

class _RefreshBalancesWrapperState extends State<RefreshBalancesWrapper> {
  @override
  void initState() {
    super.initState();
    context.refreshBalances();
  }

  Future<void> _onRefreshWithErrorHandling(BuildContext context) =>
      context.refreshBalances().doOnLeftAsync(
        (error) {
          if (error is BalancesRequestException) {
            _showFetchBalancesErrorToast(context);
          } else if (error is ConversionRatesRequestException) {
            _showConversionRatesFetchErrorToast(context);
          } else {
            _logger.severe('Failed to update', error);
          }
        },
      );

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        () => _onRefreshWithErrorHandling(context),
      );
}

void _showFetchBalancesErrorToast(BuildContext context) => showCpSnackbar(
      context,
      message: context.l10n.cannotConnectToTheNetwork,
      icon: Assets.icons.toastWarning.image(),
    );

void _showConversionRatesFetchErrorToast(BuildContext context) =>
    showCpSnackbar(
      context,
      message: context.l10n.weWereUnableToFetchTokenPrice,
      icon: Assets.icons.toastWarning.image(),
    );
