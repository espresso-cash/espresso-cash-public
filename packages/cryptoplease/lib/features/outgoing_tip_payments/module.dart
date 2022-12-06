import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/amount.dart';
import '../../core/analytics/analytics_manager.dart';
import '../../di.dart';
import 'src/bl/bloc.dart';

export 'src/bl/outgoing_tip_payment.dart';
export 'src/bl/outgoing_tip_verifier.dart';
export 'src/bl/repository.dart';

class OTModule extends SingleChildStatelessWidget {
  const OTModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<OTBloc>(
            create: (context) => sl<OTBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: child,
      );
}

extension BuildContextExt on BuildContext {
  String createOT({required CryptoAmount amount}) {
    final id = const Uuid().v4();
    final event = OTEvent.create(amount: amount, id: id);
    read<OTBloc>().add(event);

    sl<AnalyticsManager>().tipLinkCreated();

    return id;
  }
}
