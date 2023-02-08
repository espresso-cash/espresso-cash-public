import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/analytics/analytics_manager.dart';
import '../../../core/single_key_payments.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../src/bl/islp_bloc.dart';
import '../src/widgets/link_listener.dart';

extension BuildContextExt on BuildContext {
  Future<void> processISLP(SingleKeyPaymentData payment) async {
    final key = payment.key;

    final escrow = await walletFromKey(encodedKey: key);

    final id = const Uuid().v4();

    sl<AnalyticsManager>().singleLinkReceived();

    read<ISLPBloc>().add(ISLPEvent.create(escrow, id: id));
    await router.push(IncomingSingleLinkRoute(id: id));
  }
}
