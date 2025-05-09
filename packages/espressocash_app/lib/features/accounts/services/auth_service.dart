import 'dart:async';

import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';

import '../../../di.dart';
import '../auth_scope.dart';
import '../data/account_repository.dart';

@Singleton(scope: authScope)
class AuthService {
  AuthService(this._ecClient, this._repository);

  final EspressoCashClient _ecClient;
  final AccountRepository _repository;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  @PostConstruct(preResolve: true)
  Future<void> initialize() async {
    final storedToken = await _repository.loadAuthToken();

    if (storedToken != null) {
      await _ecClient.login(token: storedToken);

      return;
    }

    await _login();
  }

  Future<void> _login() async {
    final token = await _ecClient.login();
    await _repository.saveAuthToken(token);
  }

  Future<T> withAuthRetry<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error) {
      if (_isAuthError(error)) {
        if (_isRefreshing) {
          await _refreshCompleter?.future;
        } else {
          await _refreshToken();
        }

        return apiCall();
      }
      rethrow;
    }
  }

  Future<void> _refreshToken() async {
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    try {
      await _login();
      _refreshCompleter?.complete();
    } catch (error) {
      _refreshCompleter?.completeError(error, StackTrace.current);
      rethrow;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  bool _isAuthError(Object error) {
    final errorStr = error.toString().toLowerCase();

    return errorStr.contains('invalid token');
  }
}

extension AuthenticatedClient on EspressoCashClient {
  Future<T> call<T>(Future<T> Function(EspressoCashClient client) call) {
    final authService = sl<AuthService>();

    return authService.withAuthRetry(() => call(this));
  }
}
