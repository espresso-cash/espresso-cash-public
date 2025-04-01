import 'package:flutter/material.dart';

import '../../../di.dart';
import '../models/kyc_validation_status.dart';
import '../services/pending_kyc_service.dart';

typedef KycStatusListenerBuilder = Widget Function(
  BuildContext context,
  AsyncSnapshot<KycValidationStatus> snapshot,
);

class KycStatusListener extends StatelessWidget {
  const KycStatusListener({
    super.key,
    required this.builder,
    required this.country,
  });

  final KycStatusListenerBuilder builder;
  final String country;

  @override
  Widget build(BuildContext context) => StreamBuilder<KycValidationStatus>(
        stream: sl<PendingKycService>().pollKycStatus(country: country),
        builder: builder,
      );
}
