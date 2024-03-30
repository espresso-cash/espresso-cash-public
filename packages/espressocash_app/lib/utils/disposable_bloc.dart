import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

mixin DisposableBloc<Event, State> on Bloc<Event, State> implements Disposable {
  @override
  Future<void> onDispose() => close();
}
