import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import 'src/bl/repository.dart';
import 'src/presentation/link_details/routes.dart';
import 'src/presentation/link_request/routes.dart';

export 'src/bl/payment_request.dart';
export 'src/bl/payment_request_verifier/bloc.dart';
export 'src/bl/repository.dart';
export 'src/presentation/formatted_amount.dart';

const paymentRequestRoutes = [
  ...linkDetailsRoutes,
  ...linkRequestRoutes,
];

class PaymentRequestModule extends SingleChildStatelessWidget {
  const PaymentRequestModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (s1, s2) => s1.account != s2.account,
        listener: (context, state) {
          if (state.account == null) {
            sl<PaymentRequestRepository>().clear();
          }
        },
        child: child,
      );
}
