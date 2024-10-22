import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import '../../../di.dart';
import '../../../ui/button.dart';
import '../../ramp/partners/kyc/services/xflow_off_ramp_order_service.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_section.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const KycStatusScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  late final KycSharingService _kycService;

  @override
  void initState() {
    super.initState();
    _kycService = sl<KycSharingService>();
    _kycService.subscribeToUserData();
  }

  @override
  void dispose() {
    _kycService.unsubscribeFromUserData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: _kycService,
        builder: (context, userData, child) {
          if (userData == null) {
            return const CircularProgressIndicator();
          }

          return KycPage(
            title: 'Verification Status',
            children: [
              const Spacer(),
              Text(
                getStatusText(userData.kycStatus),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              if (userData.kycStatus != ValidationStatus.approved) ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CpButton(
                    width: double.infinity,
                    text: 'Create Order',
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ]
            ],
          );
        },
      );

  String getStatusText(ValidationStatus status) {
    switch (status) {
      case ValidationStatus.approved:
        return 'Great! You can proceed with you order now.';
      case ValidationStatus.pending:
        return 'Your verification is pending. You will be able to proceed after it approved.';
      case ValidationStatus.rejected:
        return 'Your verification failed.';
      // ignore: no_default_cases, , check if needed
      default:
        return 'Your data is unverified.';
    }
  }
}
