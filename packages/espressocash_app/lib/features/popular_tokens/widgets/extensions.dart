import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/bloc.dart';

extension BuildContextExt on BuildContext {
  Future<void> refreshPopularTokens() => read<PopularTokenBloc>().refresh();
}
