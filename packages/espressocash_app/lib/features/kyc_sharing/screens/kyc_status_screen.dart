import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import '../../../di.dart';
import '../../../ui/button.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import '../widgets/kyc_page.dart';

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
    _kycService.subscribe();
  }

  @override
  void dispose() {
    _kycService
      ..unsubscribe()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: _kycService,
        builder: (context, userData, child) => userData == null
            ? const CircularProgressIndicator()
            : KycPage(
                title: 'Verification Status',
                children: [
                  const Spacer(),
                  Text(
                    _getStatusText(userData.kycStatus),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CpButton(
                      width: double.infinity,
                      text: 'Create Order',
                      onPressed:
                          (userData.kycStatus == ValidationStatus.approved)
                              ? () => Navigator.pop(context, true)
                              : null,
                    ),
                  ),
                ],
              ),
      );

  String _getStatusText(ValidationStatus status) {
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
