import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/item/transaction_item_bloc.dart';
import 'package:cryptoplease/bl/transactions/list/transactions_bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/transaction_details_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.token,
  }) : super(key: key);

  final Transaction transaction;
  final Token token;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    super.initState();
    // Initialize the undetermined data
    context.read<TransactionItemBloc>().add(
          TransactionItemEvent.initialized(
            transaction: widget.transaction,
            token: widget.token,
          ),
        );
  }

  void _showTransactionDetails() {
    context.router.push(
      TransactionDetailsRoute(
        data: TransactionDetailsScreenData(
          transactionSignature: widget.transaction.hash,
          token: widget.token,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final state = context.watch<TransactionItemBloc>().state;

    return transaction.map(
      transfer: (transaction) {
        final signedAmount = state.signedAmount;
        final amount = Amount.fromToken(
          value: signedAmount ?? 0,
          token: widget.token,
        );

        return _TransactionItemContent(
          onTap: _showTransactionDetails,
          type: state.transactionType,
          status: state.transactionStatus,
          amount: amount.format(DeviceLocale.localeOf(context)),
          date: transaction.blockTime,
          memo: transaction.memo,
        );
      },
      generic: (_) => _GenericTransactionItemContent(
        onTap: _showTransactionDetails,
        status: state.transactionStatus,
        signature: transaction.hash,
        date: transaction.blockTime,
      ),
    );
  }
}

class _GenericTransactionItemContent extends StatelessWidget {
  const _GenericTransactionItemContent({
    Key? key,
    required this.status,
    required this.date,
    required this.signature,
    required this.onTap,
  }) : super(key: key);

  final String signature;
  final TransactionItemStatus status;
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final trimmedSignature =
        '${signature.substring(0, 6)}\u2026${signature.substring(signature.length - 6)}';

    switch (status) {
      case TransactionItemStatus.succeeded:
        return _CommonItemContent(
          onTap: onTap,
          icon: Assets.icons.txSucceeded,
          title: context.l10n.txSuccess(trimmedSignature),
          date: date,
        );
      case TransactionItemStatus.failed:
        return _CommonItemContent(
          onTap: onTap,
          icon: Assets.icons.txFailed,
          title: context.l10n.txFailed(trimmedSignature),
          date: date,
        );
      case TransactionItemStatus.loading:
        return _CommonItemContent(
          onTap: null,
          icon: null,
          title: context.l10n.loading,
          date: date,
        );
    }
  }
}

class _TransactionItemContent extends StatelessWidget {
  const _TransactionItemContent({
    Key? key,
    required this.type,
    required this.status,
    required this.amount,
    required this.date,
    required this.memo,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  final TransactionType type;
  final TransactionItemStatus status;
  final String amount;
  final DateTime? date;

  // TODO(IA): display the memo at some point
  final String? memo;

  @override
  Widget build(BuildContext context) {
    // TODO(IA): somehow show the status if it is failed
    if (status == TransactionItemStatus.loading) {
      return _CommonItemContent(
        onTap: null,
        icon: null,
        title: context.l10n.loading,
        date: date,
      );
    }
    final textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Colors.black,
        );

    switch (type) {
      case TransactionType.incoming:
        return _CommonItemContent(
          icon: Assets.icons.incoming,
          title: context.l10n.received,
          date: date,
          trailing: Text(amount, style: textStyle),
          onTap: onTap,
        );
      case TransactionType.outgoing:
        return _CommonItemContent(
          icon: Assets.icons.outgoing,
          title: context.l10n.sent,
          date: date,
          trailing: Text(amount, style: textStyle),
          onTap: onTap,
        );
      default:
        throw FormatException('invalid transaction type $type');
    }
  }
}

class _CommonItemContent extends StatelessWidget {
  const _CommonItemContent({
    Key? key,
    required this.icon,
    required this.title,
    required this.date,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  final SvgGenImage? icon;
  final VoidCallback? onTap;
  final String title;
  final DateTime? date;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Colors.black,
        );

    final timeStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          color: CpColors.secondaryTextColor,
          fontSize: 13,
        );

    final date = this.date;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      leading: icon?.svg(width: 50),
      title: Text(title, style: titleStyle),
      subtitle: Text(
        date == null
            ? ''
            : DateTimeFormat.relative(date, appendIfAfter: context.l10n.ago),
        style: timeStyle,
      ),
      trailing: trailing,
    );
  }
}
