import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import '../data/token_dto.dart';
import '../data/token_repository.dart';

@lazySingleton
class TokenService {
  TokenService(this._tokenRepository);

  final TokenListRepository _tokenRepository;

  Future<List<TokenDTO>> getAllTokens() => _tokenRepository.getAllTokens();

  Stream<List<TokenDTO>> watchAllTokens() => _tokenRepository.watchAllTokens();

  Future<void> insertToken(TokenDTO tokenDTO) =>
      _tokenRepository.insertToken(tokenDTO);

  Future<void> updateToken(TokenDTO tokenDTO) =>
      _tokenRepository.updateToken(tokenDTO);

  Future<void> deleteToken(TokenDTO tokenDTO) =>
      _tokenRepository.deleteToken(tokenDTO);

  Future<void> clearAllTokens() => _tokenRepository.clearAllTokens();

  Future<void> initializeDatabaseWithJson(Map<String, dynamic> json) async {
    await clearAllTokens();
    for (final tokenData in json['tokens'] as Iterable) {
      final tokenDTO = TokenDTO.fromJson(tokenData as Map<String, dynamic>);
      await insertToken(tokenDTO);
    }
  }

  TokenDTO? findTokenByMint(String mint, List<TokenDTO> tokens) =>
      tokens.firstWhereOrNull((t) => t.address == mint);
}
