import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/transactions/create_transaction_link.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/colors.dart';
import '../transaction.dart';
import 'styles.dart';

class CommonTile extends StatelessWidget {
  const CommonTile({
    Key? key,
    required this.txCommon,
  }) : super(key: key);

  final TxCommon txCommon;

  @override
  Widget build(BuildContext context) {
    final signature = txCommon.fetched.id;
    final formattedSignature = signature.toShortAddress();
    final formattedDate = txCommon.fetched.created?.let(context.formatDate);

    return ListTile(
      title: Text(
        context.l10n.transactionTitle(formattedSignature),
        style: titleStyle,
      ),
      subtitle: Text(formattedDate ?? '', style: subtitleStyle),
      leading: CircleAvatar(
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
