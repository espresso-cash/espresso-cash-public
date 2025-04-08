import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';

extension AsyncCacheExt<T> on AsyncCache<T> {
  Future<T> fetchIgnoringError(Future<T> Function() callback) =>
      fetch(callback).onError<Exception>((error, stackTrace) {
        invalidate();

        Error.throwWithStackTrace(error, stackTrace);
      });

  AsyncResult<T> fetchEither(Future<T> Function() callback) =>
      fetchIgnoringError(callback).toEither();
}
