import 'package:flutter/material.dart';

import '../../../di.dart';
import '../models/kyc_validation_status.dart';
import '../services/pending_kyc_service.dart';

typedef KycStatusListenerBuilder = Widget Function(
  BuildContext context,
  KycValidationStatus status,
);

class KycStatusListener extends StatelessWidget {
  const KycStatusListener({
    super.key,
    required this.builder,
  });

  final KycStatusListenerBuilder builder;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<KycValidationStatus?>(
        valueListenable: sl<PendingKycService>(),
        builder: (context, status, _) => status == null
            ? const Center(child: CircularProgressIndicator())
            : builder(context, status),
      );
}
