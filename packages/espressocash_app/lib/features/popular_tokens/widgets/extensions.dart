import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/bl/bloc.dart';

extension BuildContextExt on BuildContext {
  Future<void> refreshPopularTokens() => read<PopularTokenBloc>().refresh();
}
