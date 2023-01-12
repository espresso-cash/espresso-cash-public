import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../src/bl/bloc.dart';

extension BuildContextExt on BuildContext {
  String createOSKP({required CryptoAmount amount}) {
    final id = const Uuid().v4();
    final event = OSKPEvent.create(amount: amount, id: id);
    read<OSKPBloc>().add(event);

    sl<AnalyticsManager>().linksCreated();

    return id;
  }
}
