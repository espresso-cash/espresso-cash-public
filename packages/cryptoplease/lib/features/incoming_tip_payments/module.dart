import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/tip_payments.dart';
import '../../di.dart';
import '../../routes.gr.dart';
import 'src/bl/it_bloc.dart';
import 'src/presentation/link_listener.dart';

export 'src/bl/it_repository.dart';

class ITModule extends SingleChildStatelessWidget {
  const ITModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<ITBloc>(
            create: (context) => sl<ITBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: TipLinkListener(child: child ?? const SizedBox.shrink()),
      );
}

extension BuildContextExt on BuildContext {
  Future<void> processIT(TipPaymentData tipPayment) async {
    final key = tipPayment.key;

    final escrow = await walletFromKey(encodedKey: key);

    final id = const Uuid().v4();

    read<ITBloc>().add(ITEvent.create(escrow, id: id));
    await router.push(IncomingTipRoute(id: id));
  }
}
