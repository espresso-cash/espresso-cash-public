import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import '../widgets/kyc_page.dart';

// Todo
// This screen should be designed (?)
// Status should be fetched as stream
class KycStatusScreen extends StatelessWidget {
  const KycStatusScreen({super.key, required this.status});

  static Future<bool> push(BuildContext context, ValidationStatus status) =>
      Navigator.of(context)
          .push<bool>(
            MaterialPageRoute(
              builder: (context) => KycStatusScreen(status: status),
            ),
          )
          .then((result) => result ?? false);

  final ValidationStatus status;

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'KYC Status',
        children: [
          Text(_getStatusText()),
        ],
      );

  String _getStatusText() {
    switch (status) {
      case ValidationStatus.pending:
        return 'Your verification is pending. You will be able to proceed after it approved.';
      case ValidationStatus.rejected:
        return 'Your verification failed';
      // ignore: no_default_cases, , check if needed
      default:
        return '';
    }
  }
}
