import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import '../accounts/module.dart';
import 'data/repository.dart';

class PaymentRequestModule extends SingleChildStatelessWidget {
  const PaymentRequestModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<PaymentRequestRepository>().clear(),
        child: child,
      );
}
