import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void setUpLogging() {
  if (!kDebugMode) return;

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) {
    developer.log('${r.loggerName}: ${r.message}', level: r.level.value);
  });
}

class Observer extends BlocObserver {
  final _logger = Logger('BlocObserver');

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.info(event);
    Sentry.addBreadcrumb(
      Breadcrumb(
        category: bloc.runtimeType.toString(),
        message: event.runtimeType.toString(),
      ),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.shout('Error in $bloc', error, stackTrace);
    Sentry.captureException(error, stackTrace: stackTrace);
  }
}
