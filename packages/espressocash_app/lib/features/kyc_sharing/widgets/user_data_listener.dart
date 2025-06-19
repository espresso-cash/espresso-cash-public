import 'package:brij_client/brij_client.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../services/kyc_service.dart';

typedef UserDataBuilder = Widget Function(BuildContext context, UserData userData);

class UserDataListener extends StatelessWidget {
  const UserDataListener({super.key, required this.builder});

  final UserDataBuilder builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
    valueListenable: sl<KycSharingService>(),
    builder:
        (context, userData, _) =>
            userData == null
                ? const Center(child: CircularProgressIndicator())
                : builder(context, userData),
  );
}
