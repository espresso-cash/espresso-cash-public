import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../src/bl/bloc.dart';

extension BuildContextExt on BuildContext {
  String createOT({required CryptoAmount amount}) {
    final id = const Uuid().v4();
    final event = OTEvent.create(amount: amount, id: id);
    read<OTBloc>().add(event);

    sl<AnalyticsManager>().tipLinkCreated();

    return id;
  }
}
