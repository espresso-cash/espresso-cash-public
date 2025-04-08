import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';
import '../../../gen/assets.gen.dart';
import '../models/kyc_validation_status.dart';

class KycStatusIcon extends StatelessWidget {
  const KycStatusIcon(this.status, {super.key, this.height = 16});

  final KycValidationStatus status;
  final double height;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      Assets.icons.star.svg(color: status.backgroundColor, height: height),
      status.foregroundIcon(height / 2),
    ],
  );
}

extension on KycValidationStatus {
  Color get backgroundColor => switch (this) {
    KycValidationStatus.approved => CpColors.greenColor,
    KycValidationStatus.pending => CpColors.yellowColor,
    KycValidationStatus.unverified => CpColors.greyColor,
    KycValidationStatus.rejected => CpColors.alertRedColor,
  };

  Widget foregroundIcon(double width) => switch (this) {
    KycValidationStatus.approved => Assets.icons.xmark.svg(width: width),
    KycValidationStatus.unverified ||
    KycValidationStatus.pending => Assets.icons.threeDots.svg(width: width),
    KycValidationStatus.rejected => Assets.icons.exclamationMark.svg(height: width),
  };
}
