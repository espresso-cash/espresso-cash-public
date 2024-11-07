import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/utils/kyc_utils.dart';
import '../../kyc_sharing/widgets/kyc_status_icon.dart';
import '../../ramp/partners/kyc/widgets/launch.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import '../../ramp_partner/models/ramp_type.dart';

class CpKycTile extends StatelessWidget {
  const CpKycTile({
    super.key,
    required this.title,
    required this.timestamp,
    this.incomingAmount,
    this.outgoingAmount,
    this.onTap,
    required this.preOrder,
    required this.rampType,
  });

  final String title;
  final String timestamp;
  final String? incomingAmount;
  final String? outgoingAmount;
  final VoidCallback? onTap;
  final PreOrderData? preOrder;
  final RampType rampType;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) => user == null
            ? const SizedBox.shrink()
            : _KycTileContent(
                user: user,
                title: title,
                timestamp: timestamp,
                incomingAmount: incomingAmount,
                outgoingAmount: outgoingAmount,
                preOrder: preOrder,
                rampType: rampType,
              ),
      );
}

class _KycTileContent extends StatelessWidget {
  const _KycTileContent({
    required this.user,
    required this.title,
    required this.timestamp,
    required this.incomingAmount,
    required this.outgoingAmount,
    required this.preOrder,
    required this.rampType,
  });

  final UserData user;
  final String title;
  final String timestamp;
  final String? incomingAmount;
  final String? outgoingAmount;
  final PreOrderData? preOrder;
  final RampType rampType;

  @override
  Widget build(BuildContext context) {
    final incomingAmount = this.incomingAmount;
    final outgoingAmount = this.outgoingAmount;

    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 6),
      padding: const EdgeInsets.only(top: 6, right: 20, left: 20, bottom: 26),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: KycStatusIcon(user.kycStatus, height: 42),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: _titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (incomingAmount != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('+$incomingAmount', style: _inAmountStyle),
                  ),
                if (outgoingAmount != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('-$outgoingAmount', style: _titleStyle),
                  ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.kycStatus.subtitle(context),
                  style: _subtitleStyle,
                ),
                Text(timestamp, style: _subtitleStyle),
              ],
            ),
          ),
          Text(
            user.kycStatus.description(context),
            textAlign: TextAlign.center,
            style: _subtitleStyle,
          ),
          const SizedBox(height: 16),
          switch (rampType) {
            RampType.onRamp => user.kycStatus.onRampButton(context, preOrder),
            RampType.offRamp => user.kycStatus.offRampButton(context, preOrder),
          },
        ],
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

const _inAmountStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: CpColors.greenLightColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  letterSpacing: .19,
);

extension on ValidationStatus {
  String subtitle(BuildContext context) {
    switch (this) {
      case ValidationStatus.approved:
        return context.l10n.verified;
      case ValidationStatus.pending:
        return context.l10n.activities_lblInProgress;
      case ValidationStatus.rejected:
        return context.l10n.failed;
      case ValidationStatus.unverified:
      case ValidationStatus.unspecified:
        return 'Unverified';
    }
  }

  String description(BuildContext context) {
    switch (this) {
      case ValidationStatus.approved:
        return context.l10n.kycTileDescriptionApproved;
      case ValidationStatus.pending:
        return context.l10n.kycTileDescriptionPending;
      case ValidationStatus.rejected:
        return context.l10n.kycTileDescriptionRejected;
      case ValidationStatus.unverified:
      case ValidationStatus.unspecified:
        return context.l10n.kycTileDescriptionUnverified;
    }
  }

  Widget onRampButton(
    BuildContext context,
    PreOrderData? preOrder,
  ) {
    String title;

    switch (this) {
      case ValidationStatus.approved:
      case ValidationStatus.unverified:
      case ValidationStatus.unspecified:
        title = context.l10n.continueDeposit;

      case ValidationStatus.pending:
        title = context.l10n.seeDetails;

      case ValidationStatus.rejected:
        title = context.l10n.retryVerification;
    }

    return CpButton(
      minWidth: 180,
      text: title,
      onPressed: () async {
        final data = await context.ensureProfileData(RampType.onRamp);
        if (context.mounted && data != null) {
          await context.launchKycOnRamp(
            profile: data,
            preOrder: preOrder,
          );
        }
      },
    );
  }

  Widget offRampButton(
    BuildContext context,
    PreOrderData? preOrder,
  ) {
    String title;

    switch (this) {
      case ValidationStatus.approved:
      case ValidationStatus.unverified:
      case ValidationStatus.unspecified:
        title = context.l10n.continueWithdrawal;

      case ValidationStatus.pending:
        title = context.l10n.seeDetails;

      case ValidationStatus.rejected:
        title = context.l10n.retryVerification;
    }

    return CpButton(
      minWidth: 180,
      text: title,
      onPressed: () async {
        final data = await context.ensureProfileData(RampType.offRamp);
        if (context.mounted && data != null) {
          await context.launchKycOffRamp(
            profile: data,
            preOrder: preOrder,
          );
        }
      },
    );
  }
}
