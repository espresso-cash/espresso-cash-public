import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';
import 'token_dto.dart';

@singleton
class TokenListRepository {
  TokenListRepository(this._db);

  final MyDatabase _db;

  Future<List<TokenDTO>> getAllTokens() async {
    final tokens = await _db.tokenDao.getAllTokens();
    return tokens.map(_mapToTokenDTO).toList();
  }

  Stream<List<TokenDTO>> watchAllTokens() => _db.tokenDao
      .watchAllTokens()
      .map((tokens) => tokens.map(_mapToTokenDTO).toList());

  Future<void> insertToken(TokenDTO tokenDTO) async {
    final token = _mapFromTokenDTO(tokenDTO);
    await _db.tokenDao.insertToken(token);
  }

  Future<void> updateToken(TokenDTO tokenDTO) async {}

  Future<void> deleteToken(TokenDTO tokenDTO) async {}

  Future<void> clearAllTokens() async {
    await _db.tokenDao.clearAllTokens();
  }

  TokenDTO _mapToTokenDTO(TokenRow token) => TokenDTO(
        chainId: token.chainId,
        address: token.address,
        symbol: token.symbol,
        name: token.name,
        decimals: token.decimals,
        logoURI: token.logoURI,
        tags: token.tags,
        extensions: ExtensionsDTO(coingeckoId: token.extensions?.coingeckoId),
      );

  TokenRow _mapFromTokenDTO(TokenDTO tokenDTO) => TokenRow(
        chainId: tokenDTO.chainId,
        address: tokenDTO.address,
        symbol: tokenDTO.symbol,
        name: tokenDTO.name,
        decimals: tokenDTO.decimals,
        logoURI: tokenDTO.logoURI,
        tags: tokenDTO.tags,
        extensions: tokenDTO.extensions == null
            ? null
            : Extensions(coingeckoId: tokenDTO.extensions!.coingeckoId),
      );
}
