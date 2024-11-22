import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../ui/colors.dart';
import 'kyc_status_icon.dart';

class KycStatusWidget extends StatelessWidget {
  const KycStatusWidget(
    this.status, {
    super.key,
  });

  final ValidationStatus status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String statusText;
    switch (status) {
      case ValidationStatus.approved:
        backgroundColor = CpColors.greenColor;
        statusText = 'Verified';
      case ValidationStatus.pending:
        backgroundColor = CpColors.yellowColor;
        statusText = 'Pending';
      case ValidationStatus.unspecified:
      case ValidationStatus.unverified:
        backgroundColor = CpColors.greyColor;
        statusText = 'Not Verified';
      case ValidationStatus.rejected:
        backgroundColor = CpColors.alertRedColor;
        statusText = 'Error';
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
