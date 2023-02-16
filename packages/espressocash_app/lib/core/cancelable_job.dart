
import 'package:async/async.dart';
import 'package:meta/meta.dart';

abstract class CancelableJob<T extends Object> {
  @protected
  Future<T?> process();

  @nonVirtual
  CancelableOperation<T> call() {
    Duration backoff = const Duration(seconds: 1);
    final completer = CancelableCompleter<T>();

    Future<void> doProcess() async {
      while (true) {
        if (completer.isCanceled) return;

        final result = await process();

        if (result == null) {
          await Future<void>.delayed(backoff);
          if (backoff < const Duration(seconds: 30)) backoff *= 2;

          continue;
        }

        completer.complete(result);

        return;
      }
    }

    doProcess();

    return completer.operation;
  }
}
