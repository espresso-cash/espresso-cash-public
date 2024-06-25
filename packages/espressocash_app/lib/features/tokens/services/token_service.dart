import 'package:injectable/injectable.dart';

import '../data/token_repository.dart';

@lazySingleton
class TokenService {
  const TokenService(this.tokenRepository);

  final TokenListRepository tokenRepository;
}
