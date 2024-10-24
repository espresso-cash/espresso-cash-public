import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../ui/colors.dart';
import '../../../gen/assets.gen.dart';

class KycStatusIcon extends StatelessWidget {
  const KycStatusIcon(
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
        backgroundColor = CpColors.greenLightColor;
        statusText = 'Verified';
      case ValidationStatus.pending:
        backgroundColor = CpColors.yellowColor;
        statusText = 'Pending';
      case ValidationStatus.unspecified:
      case ValidationStatus.unverified:
        backgroundColor = CpColors.lightGrey;
        statusText = 'Not Verified';
      case ValidationStatus.rejected:
        backgroundColor = CpColors.errorChipColor;
        statusText = 'Error';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Assets.icons.star.svg(color: backgroundColor),
            Assets.icons.xmark.svg(),
          ],
        ),
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
