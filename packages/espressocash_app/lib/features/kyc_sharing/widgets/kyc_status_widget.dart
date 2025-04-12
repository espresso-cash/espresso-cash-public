import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';
import '../../../l10n/l10n.dart';
import '../models/kyc_validation_status.dart';
import 'kyc_status_icon.dart';

class KycStatusWidget extends StatelessWidget {
  const KycStatusWidget(this.status, {super.key});

  final KycValidationStatus status;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      KycStatusIcon(status),
      const SizedBox(width: 4),
      Text(
        switch (status) {
          KycValidationStatus.approved => context.l10n.verified,
          KycValidationStatus.pending => context.l10n.pending,
          KycValidationStatus.unverified => context.l10n.notVerified,
          KycValidationStatus.rejected => context.l10n.error,
        },
        style: TextStyle(
          color: switch (status) {
            KycValidationStatus.approved => CpColors.greenColor,
            KycValidationStatus.pending => CpColors.yellowColor,
            KycValidationStatus.unverified => CpColors.greyColor,
            KycValidationStatus.rejected => CpColors.alertRedColor,
          },
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
