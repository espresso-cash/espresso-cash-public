import 'package:flutter/material.dart';

import '../../../di.dart';
import '../models/kyc_validation_status.dart';
import '../services/pending_kyc_service.dart';

typedef KycStatusListenerBuilder =
    Widget Function(BuildContext context, AsyncSnapshot<KycValidationStatus> snapshot);

class KycStatusListener extends StatefulWidget {
  const KycStatusListener({super.key, required this.builder, required this.country});

  final KycStatusListenerBuilder builder;
  final String country;

  @override
  State<KycStatusListener> createState() => _KycStatusListenerState();
}

class _KycStatusListenerState extends State<KycStatusListener> {
  late Stream<KycValidationStatus> _stream = sl<PendingKycService>().pollKycStatus(
    country: widget.country,
  );

  @override
  void didUpdateWidget(covariant KycStatusListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.country != widget.country) {
      _stream = sl<PendingKycService>().pollKycStatus(country: widget.country);
    }
  }

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<KycValidationStatus>(stream: _stream, builder: widget.builder);
}
