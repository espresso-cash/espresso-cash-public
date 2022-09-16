import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class RequestPayModule extends SingleChildStatelessWidget {
  const RequestPayModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<RequestPayBloc>(
            create: (_) => RequestPayBloc(
              balances: context.read<BalancesBloc>().state.balances,
            ),
          ),
        ],
        child: child,
      );
}
