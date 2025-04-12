import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../intercom/services/intercom_service.dart';
import '../../router/service/navigation_service.dart';
import '../models/kyc_validation_status.dart';
import '../services/pending_kyc_service.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_listener.dart';
import '../widgets/kyc_page.dart';

class KycStatusScreen extends StatelessWidget {
  const KycStatusScreen({
    super.key,
    this.onAddCashPressed,
    this.onCashOutPressed,
    required this.country,
  });

  final VoidCallback? onAddCashPressed;
  final VoidCallback? onCashOutPressed;
  final String country;

  static Future<bool> push(
    BuildContext context, {
    VoidCallback? onAddCashPressed,
    VoidCallback? onCashOutPressed,
    required String country,
  }) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder:
              (context) => KycStatusScreen(
                onAddCashPressed: onAddCashPressed,
                onCashOutPressed: onCashOutPressed,
                country: country,
              ),
        ),
      )
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycStatusListener(
    country: country,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const KycPage(children: [Center(child: CircularProgressIndicator())]);
      }

      final status = snapshot.data;

      if (status == null) return const SizedBox.shrink();

      void removePendingKyc() {
        if (status == KycValidationStatus.approved) {
          sl<PendingKycService>().remove();
        }
      }

      return KycPage(
        icon: status.kycIcon,
        children: [
          switch (status) {
            KycValidationStatus.unverified || KycValidationStatus.pending => KycHeader(
              title: context.l10n.kycPendingStatusTitle,
              description: context.l10n.kycPendingStatusDescription,
            ),
            KycValidationStatus.approved => KycHeader(
              title: context.l10n.kycApprovedStatusTitle,
              description: context.l10n.kycApprovedStatusDescription,
            ),
            KycValidationStatus.rejected => KycHeader(
              title: context.l10n.kycRejectedStatusTitle,
              description: context.l10n.kycRejectedStatusDescription,
            ),
          },
          const SizedBox(height: 14),
          if (status.isPending)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(context.l10n.kycPendingStatusDescription2, style: _textStyle),
                  const SizedBox(height: 14),
                  Text(context.l10n.kycPendingStatusDescription3, style: _textStyle),
                ],
              ),
            )
          else if (status == KycValidationStatus.approved) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(context.l10n.kycApprovedStatusDescription2, style: _textStyle),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(context.l10n.kycApprovedStatusDescription3, style: _textStyle),
            ),
          ],
          const SizedBox(height: 16),
          const Spacer(),
          if (status == KycValidationStatus.approved &&
              onAddCashPressed != null &&
              onCashOutPressed != null) ...[
            CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.ramp_btnAddCash,
              onPressed: () {
                Navigator.of(context).pop();
                onAddCashPressed?.call();
                removePendingKyc();
              },
            ),
            CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.ramp_btnCashOut,
              onPressed: () {
                Navigator.of(context).pop();
                onCashOutPressed?.call();
                removePendingKyc();
              },
            ),
          ] else
            CpBottomButton(
              horizontalPadding: 16,
              text: switch (status) {
                KycValidationStatus.rejected => context.l10n.contactUs,
                KycValidationStatus.pending => context.l10n.activityButton,
                KycValidationStatus.approved || KycValidationStatus.unverified => context.l10n.ok,
              },
              onPressed: () {
                switch (status) {
                  case KycValidationStatus.rejected:
                    sl<IntercomService>().displayMessenger();
                  case KycValidationStatus.pending:
                    sl<HomeNavigationService>().openActivitiesTab(context);
                  case KycValidationStatus.approved:
                    removePendingKyc();
                    Navigator.of(context).pop();
                  case KycValidationStatus.unverified:
                    Navigator.of(context).pop();
                }
              },
            ),
        ],
      );
    },
  );
}

const _textStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  height: 21 / 16,
  letterSpacing: .19,
);
