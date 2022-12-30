import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization_result.freezed.dart';

@freezed
class AuthorizationResult<T> with _$AuthorizationResult<T> {
  const factory AuthorizationResult.success(T data) =
      _AuthorizationResultSuccess;
  const factory AuthorizationResult.failed(Exception e) =
      _AuthorizationResultFailed;
}
