//
//  Generated code. Do not modify.
//  source: espressocash/api/tokens/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapitokensv1service;

abstract final class TokensService {
  /// Fully-qualified name of the TokensService service.
  static const name = 'espressocash.api.tokens.v1.TokensService';

  static const getTokensMeta = connect.Spec(
    '/$name/GetTokensMeta',
    connect.StreamType.unary,
    espressocashapitokensv1service.GetTokensMetaRequest.new,
    espressocashapitokensv1service.GetTokensMetaResponse.new,
  );

  static const getTokensFile = connect.Spec(
    '/$name/GetTokensFile',
    connect.StreamType.unary,
    espressocashapitokensv1service.GetTokensFileRequest.new,
    espressocashapitokensv1service.GetTokensFileResponse.new,
  );
}
