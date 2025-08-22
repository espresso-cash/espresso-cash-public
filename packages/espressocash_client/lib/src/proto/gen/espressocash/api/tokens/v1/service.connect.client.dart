//
//  Generated code. Do not modify.
//  source: espressocash/api/tokens/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapitokensv1service;
import "service.connect.spec.dart" as specs;

extension type TokensServiceClient (connect.Transport _transport) {
  Future<espressocashapitokensv1service.GetTokensMetaResponse> getTokensMeta(
    espressocashapitokensv1service.GetTokensMetaRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TokensService.getTokensMeta,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapitokensv1service.GetTokensFileResponse> getTokensFile(
    espressocashapitokensv1service.GetTokensFileRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TokensService.getTokensFile,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
