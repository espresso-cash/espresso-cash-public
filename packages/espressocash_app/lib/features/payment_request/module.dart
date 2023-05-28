import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/repository.dart';

class PaymentRequestModule extends SingleChildStatelessWidget {
  const PaymentRequestModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<PaymentRequestRepository>().clear(),
        child: LogoutListener(
          onLogout: (_) => sl<PaymentRequestRepository>().clear(),
          child: child,
        ),
      );
}
