import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/data/payment_request_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class PaymentRequestModule extends SingleChildStatelessWidget {
  const PaymentRequestModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<PaymentRequestRepository>(
            create: (_) =>
                DbPaymentRequestRepository(context.read<MyDatabase>()),
          ),
        ],
        child: _Content(child: child),
      );
}

class _Content extends StatelessWidget {
  const _Content({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (s1, s2) => s1.account != s2.account,
        listener: (context, state) {
          if (state.account == null) {
            context.read<OutgoingTransferRepository>().clear();
          }
        },
        child: child,
      );
}
