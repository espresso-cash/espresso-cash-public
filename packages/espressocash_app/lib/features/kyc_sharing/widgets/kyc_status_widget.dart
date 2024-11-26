import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../ui/colors.dart';
import '../../../l10n/l10n.dart';
import 'kyc_status_icon.dart';

class KycStatusWidget extends StatelessWidget {
  const KycStatusWidget(this.status, {super.key});

  final ValidationStatus status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String statusText;
    switch (status) {
      case ValidationStatus.approved:
        backgroundColor = CpColors.greenColor;
        statusText = context.l10n.verified;
      case ValidationStatus.pending:
        backgroundColor = CpColors.yellowColor;
        statusText = context.l10n.pending;
      case ValidationStatus.unspecified:
      case ValidationStatus.unverified:
        backgroundColor = CpColors.greyColor;
        statusText = context.l10n.notVerified;
      case ValidationStatus.rejected:
        backgroundColor = CpColors.alertRedColor;
        statusText = context.l10n.error;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        KycStatusIcon(status),
        const SizedBox(width: 4),
        Text(
          statusText,
          style: TextStyle(
            color: backgroundColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
