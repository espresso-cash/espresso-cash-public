import 'package:async/async.dart';
import 'package:meta/meta.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class CancelableJob<T extends Object> {
  const CancelableJob();

  @protected
  Future<T?> process();

  @nonVirtual
  CancelableOperation<T> call() {
    Duration backoff = const Duration(seconds: 1);
    final completer = CancelableCompleter<T>();
    final transaction = Sentry.startTransaction(runtimeType.toString(), 'call');

    Future<void> finishTransaction() async {
      transaction
        ..setMeasurement(
          'backoff',
          backoff.inSeconds,
          unit: DurationSentryMeasurementUnit.second,
        )
        ..setData('backoff', backoff.inSeconds);
      await transaction.finish();
    }

    Future<void> doProcess() async {
      while (true) {
        if (completer.isCanceled) {
          await finishTransaction();

          return;
        }

        final result = await process();

        if (result == null) {
          await Future<void>.delayed(backoff);
          if (backoff < const Duration(seconds: 30)) backoff *= 2;

          continue;
        }

        completer.complete(result);

        await finishTransaction();

        return;
      }
    }

    doProcess();

    return completer.operation;
  }
}
