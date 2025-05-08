import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';

import '../auth_scope.dart';
import '../data/account_repository.dart';

@Singleton(scope: authScope)
class AuthService {
  const AuthService(this._ecClient, this._repository);

  final EspressoCashClient _ecClient;
  final AccountRepository _repository;

  @PostConstruct(preResolve: true)
  Future<void> initialize() async {
    final storedToken = await _repository.loadAuthToken();

    if (storedToken != null) {
      await _ecClient.login(token: storedToken);

      return;
    }

    final token = await _ecClient.login();
    await _repository.saveAuthToken(token);
  }
}
