import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../core/amount.dart';
import '../../core/analytics/analytics_manager.dart';
import '../../di.dart';
import 'src/bl/bloc.dart';
import 'src/bl/repository.dart';

export 'src/bl/oskp_verifier.dart';
export 'src/bl/outgoing_split_key_payment.dart';

class OSKPModule extends SingleChildStatelessWidget {
  const OSKPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<OSKPBloc>(
            create: (context) => sl<OSKPBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: LogoutListener(
          onLogout: (_) => sl<OSKPRepository>().clear(),
          child: child,
        ),
      );
}

extension BuildContextExt on BuildContext {
  String createOSKP({required CryptoAmount amount}) {
    final id = const Uuid().v4();
    final event = OSKPEvent.create(amount: amount, id: id);
    read<OSKPBloc>().add(event);

    sl<AnalyticsManager>().linksCreated();

    return id;
  }
}
