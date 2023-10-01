import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/bloc.dart';

extension BuildContextExt on BuildContext {
  Future<void> refreshTransactions() => read<TxUpdaterBloc>().update();
}
