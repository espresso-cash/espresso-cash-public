import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticated({
    required String address,
    required String chainId,
  }) = AuthAuthenticated;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.error() = AuthError;
}
