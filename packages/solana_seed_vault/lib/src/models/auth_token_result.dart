import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_result.freezed.dart';

typedef AuthToken = int;

@freezed
class AuthTokenResult with _$AuthTokenResult {
  const factory AuthTokenResult.success(AuthToken authToken) = _ATRSuccess;

  const factory AuthTokenResult.failure(Exception exception) = _ATRFailure;
}
