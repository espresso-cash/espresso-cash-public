import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../ui/colors.dart';
import '../../../gen/assets.gen.dart';

class KycStatusIcon extends StatelessWidget {
  const KycStatusIcon(
    this.status, {
    super.key,
    this.height = 16,
  });

  final ValidationStatus status;
  final double height;
  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Assets.icons.star.svg(
            color: status.backgroundColor,
            height: height,
          ),
          Assets.icons.xmark.svg(height: height / 2),
        ],
      );
}

extension on ValidationStatus {
  Color get backgroundColor {
    switch (this) {
      case ValidationStatus.approved:
        return CpColors.greenColor;
      case ValidationStatus.pending:
        return CpColors.yellowColor;
      case ValidationStatus.unspecified:
      case ValidationStatus.unverified:
        return CpColors.greyColor;
      case ValidationStatus.rejected:
        return CpColors.alertRedColor;
    }
  }
}
