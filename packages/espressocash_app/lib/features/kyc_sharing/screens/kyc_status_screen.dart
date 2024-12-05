import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../intercom/services/intercom_service.dart';
import '../../router/service/navigation_service.dart';
import '../models/kyc_validation_status.dart';
import '../utils/kyc_utils.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_listener.dart';
import '../widgets/kyc_page.dart';

class KycStatusScreen extends StatelessWidget {
  const KycStatusScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const KycStatusScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycListener(
        builder: (context, userData) {
          final status = userData.kycStatus.toKycValidationStatus();

          return KycPage(
            icon: status.kycIcon,
            children: [
              switch (status) {
                KycValidationStatus.unverified ||
                KycValidationStatus.pending =>
                  KycHeader(
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
                      Text(
                        context.l10n.kycPendingStatusDescription2,
                        style: _textStyle,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        context.l10n.kycPendingStatusDescription3,
                        style: _textStyle,
                      ),
                    ],
                  ),
                )
              else if (status == KycValidationStatus.approved)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    context.l10n.kycApprovedStatusDescription2,
                    style: _textStyle,
                  ),
                ),
              const Spacer(),
              CpBottomButton(
                text: switch (status) {
                  KycValidationStatus.rejected => context.l10n.contactUs,
                  KycValidationStatus.pending => context.l10n.activityButton,
                  KycValidationStatus.approved ||
                  KycValidationStatus.unverified =>
                    context.l10n.ok,
                },
                onPressed: () {
                  switch (status) {
                    case KycValidationStatus.rejected:
                      sl<IntercomService>().displayMessenger();
                    case KycValidationStatus.pending:
                      sl<HomeNavigationService>().openActivitiesTab(context);
                    case KycValidationStatus.approved:
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
