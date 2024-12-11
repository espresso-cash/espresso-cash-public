import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../services/kyc_service.dart';

typedef KycBuilder = Widget Function(
  BuildContext context,
  UserData userData,
);

class KycListener extends StatelessWidget {
  const KycListener({
    super.key,
    required this.builder,
  });

  final KycBuilder builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, userData, _) => userData == null
            ? const Center(child: CircularProgressIndicator())
            : builder(context, userData),
      );
}
