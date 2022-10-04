import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
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
              myAccount: context.read<MyAccount>(),
              cryptopleaseClient: context.read<CryptopleaseClient>(),
              repository: context.read<OutgoingTransferRepository>(),
            ),
          ),
        ],
        child: child,
      );
}
