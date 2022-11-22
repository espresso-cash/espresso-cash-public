import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/repository.dart';

export 'src/bl/payment_request.dart';
export 'src/bl/payment_request_verifier/bloc.dart';
export 'src/bl/repository.dart';
export 'src/presentation/formatted_amount.dart';

class PaymentRequestModule extends SingleChildStatelessWidget {
  const PaymentRequestModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: () => sl<PaymentRequestRepository>().clear(),
        child: child,
      );
}
