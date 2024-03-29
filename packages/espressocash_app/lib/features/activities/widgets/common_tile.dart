import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../gen/assets.gen.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../l10n/device_locale.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../models/transaction.dart';
import 'activity_tile.dart';

class CommonTile extends StatelessWidget {
  const CommonTile({
    super.key,
    required this.txCommon,
  });

  final TxCommon txCommon;

  @override
  Widget build(BuildContext context) {
    final signature = txCommon.tx.id;

    final isOutgoing = txCommon.amount?.let((e) => e.value.isNegative) ?? false;
    final amount = txCommon.amount
        ?.let((e) => e.format(context.locale, maxDecimals: 2))
        .let((e) => e.replaceAll('-', ''));

    return CpActivityTile(
      title: signature.toShortAddress(),
      status: CpActivityTileStatus.success,
      timestamp: txCommon.created?.let(context.formatDate) ?? '',
      outgoingAmount: isOutgoing ? amount : null,
      incomingAmount: isOutgoing ? null : amount,
      icon: Assets.icons.txIcon.svg(),
      onTap: () {
        final link = Uri.parse(createTransactionLink(signature));
        context.openLink(link.toString());
      },
    );
  }
}
