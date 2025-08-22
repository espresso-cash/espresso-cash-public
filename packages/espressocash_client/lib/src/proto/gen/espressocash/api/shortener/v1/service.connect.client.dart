//
//  Generated code. Do not modify.
//  source: espressocash/api/shortener/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapishortenerv1service;
import "service.connect.spec.dart" as specs;

extension type ShortenerServiceClient (connect.Transport _transport) {
  Future<espressocashapishortenerv1service.ShortenLinkResponse> shortenLink(
    espressocashapishortenerv1service.ShortenLinkRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ShortenerService.shortenLink,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapishortenerv1service.ExpandLinkResponse> expandLink(
    espressocashapishortenerv1service.ExpandLinkRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ShortenerService.expandLink,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
