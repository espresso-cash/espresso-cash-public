import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_snapshot.freezed.dart';

@freezed
class AsyncSnapshotResult<T> with _$AsyncSnapshotResult<T> {
  const factory AsyncSnapshotResult.loading() = AsyncSnapshotLoading;
  const factory AsyncSnapshotResult.error(Object error) = AsyncSnapshotError;
  const factory AsyncSnapshotResult.data(T data) = AsyncSnapshotData;
}

extension AsyncSnapshotExt<T> on AsyncSnapshot<T> {
  AsyncSnapshotResult<T> toResult() {
    if (hasError) {
      // ignore: avoid-non-null-assertion, checked for hasError
      return AsyncSnapshotResult.error(error!);
    } else if (hasData) {
      return AsyncSnapshotResult.data(data as T);
    }

    return const AsyncSnapshotResult.loading();
  }
}
