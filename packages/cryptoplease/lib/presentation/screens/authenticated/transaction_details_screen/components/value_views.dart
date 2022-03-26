import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsValue extends StatelessWidget {
  const DetailsValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(value, style: _getTransactionDetailValueTextStyle(context));

  final String value;
}

class DetailsDateValue extends StatelessWidget {
  const DetailsDateValue({
    Key? key,
    required DateTime? dateTime,
  })  : _dateTime = dateTime,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTime = _dateTime;

    if (dateTime == null) {
      return const SizedBox();
    } else {
      final formatter = DateFormat('dd/MM/yyyy HH:mm');

      return Text(
        formatter.format(dateTime),
        style: _getTransactionDetailValueTextStyle(context),
      );
    }
  }

  final DateTime? _dateTime;
}

class DetailsStatusValue extends StatelessWidget {
  const DetailsStatusValue({
    Key? key,
    required TransactionStatus status,
  })  : _status = status,
        super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        _status.getDisplayName(context),
        style: _getTransactionDetailValueTextStyle(context),
      );

  final TransactionStatus _status;
}

class DetailsAddressValue extends StatelessWidget {
  const DetailsAddressValue({
    Key? key,
    required String address,
  })  : _address = address,
        super(key: key);

  @override
  Widget build(BuildContext context) => AddressView(
        address: _address,
        textStyle: _getTransactionDetailValueTextStyle(context),
        decorate: false,
        width: null,
        color: CpColors.secondaryTextColor,
      );

  final String _address;
}

TextStyle? _getTransactionDetailValueTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.subtitle2?.copyWith(
          color: CpColors.secondaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 21,
        );

extension on TransactionStatus {
  String getDisplayName(BuildContext context) {
    switch (this) {
      case TransactionStatus.confirmed:
        return context.l10n.confirmed;
      case TransactionStatus.failed:
        return context.l10n.failed;
      case TransactionStatus.pending:
        return context.l10n.pending;
    }
  }
}
