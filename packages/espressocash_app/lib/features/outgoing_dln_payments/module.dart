import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import '../accounts/module.dart';
import 'data/repository.dart';

class OutgoingDlnModule extends SingleChildStatelessWidget {
  const OutgoingDlnModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<OutgoingDlnPaymentRepository>().clear(),
        child: child,
      );
}
