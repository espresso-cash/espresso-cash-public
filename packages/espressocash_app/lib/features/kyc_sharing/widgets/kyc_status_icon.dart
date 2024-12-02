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
          status.foregroundIcon(height / 2),
        ],
      );
}

extension on ValidationStatus {
  Color get backgroundColor => switch (this) {
        ValidationStatus.approved => CpColors.greenColor,
        ValidationStatus.pending => CpColors.yellowColor,
        ValidationStatus.unspecified ||
        ValidationStatus.unverified =>
          CpColors.greyColor,
        ValidationStatus.rejected => CpColors.alertRedColor,
      };

  Widget foregroundIcon(double width) => switch (this) {
        ValidationStatus.approved => Assets.icons.xmark.svg(width: width),
        ValidationStatus.unspecified ||
        ValidationStatus.unverified ||
        ValidationStatus.pending =>
          Assets.icons.threeDots.svg(width: width),
        ValidationStatus.rejected =>
          Assets.icons.exclamationMark.svg(height: width),
      };
}
