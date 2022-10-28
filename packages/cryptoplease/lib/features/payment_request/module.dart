import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import 'bl/repository.dart';

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
