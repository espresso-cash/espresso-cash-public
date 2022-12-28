import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';

part 'auth_token_response.freezed.dart';

@freezed
class AuthTokenResponse with _$AuthTokenResponse {
  const factory AuthTokenResponse.success(AuthToken authToken) =
      _AuthTokenResponseSuccess;

  const factory AuthTokenResponse.failure(Exception exception) =
      _AuthTokenResponseFailure;
}
