import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:recase/recase.dart';

import 'wrapper.dart';

@isTest
void testGoldensWidget(
  String name,
  Widget widget, {
  FutureOr<void> Function()? setUp,
  CustomPump? customPump,
  bool? skip,
}) {
  final snakeName = name.snakeCase;

  testGoldens(name, skip: skip, (tester) async {
    await setUp?.call();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: Wrapper(child: widget),
        name: snakeName,
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, snakeName, customPump: customPump);
  });
}

void whenListen<S>(
  BlocBase<S> bloc, {
  Stream<S>? stream,
  S? initialState,
}) {
  if (stream == null) {
    if (initialState == null) {
      throw ArgumentError('Provide either stream or initialState');
    }

    stream = Stream.value(initialState);
  }

  final broadcastStream = stream.asBroadcastStream();

  if (initialState != null) {
    when(bloc.state).thenReturn(initialState);
  }

  when(bloc.stream).thenAnswer(
    (_) => broadcastStream.map((state) {
      when(bloc.state).thenReturn(state);

      return state;
    }),
  );
}
