import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/transactions/create_transaction_link.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/activity_tile.dart';
import '../../../../ui/colors.dart';
import '../transaction.dart';

class CommonTile extends StatelessWidget {
  const CommonTile({
    Key? key,
    required this.txCommon,
  }) : super(key: key);

  final TxCommon txCommon;

  @override
  Widget build(BuildContext context) {
    final signature = txCommon.tx.id;
    final formattedSignature = signature.toShortAddress();
    final formattedDate = txCommon.created?.let(context.formatDate);

    return ActivityTile(
      title: context.l10n.transactionTitle(formattedSignature),
      subtitle: formattedDate ?? '',
      icon: CircleAvatar(
        radius: 21,
        backgroundColor: CpColors.yellowColor,
        child: Assets.icons.successIconLightBg.svg(),
      ),
      onTap: () {
        final link = Uri.parse(createTransactionLink(signature));
        context.openLink(link.toString());
      },
    );
  }
}
