//
//  Generated code. Do not modify.
//  source: espressocash/api/shortener/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapishortenerv1service;

abstract final class ShortenerService {
  /// Fully-qualified name of the ShortenerService service.
  static const name = 'espressocash.api.shortener.v1.ShortenerService';

  static const shortenLink = connect.Spec(
    '/$name/ShortenLink',
    connect.StreamType.unary,
    espressocashapishortenerv1service.ShortenLinkRequest.new,
    espressocashapishortenerv1service.ShortenLinkResponse.new,
  );

  static const expandLink = connect.Spec(
    '/$name/ExpandLink',
    connect.StreamType.unary,
    espressocashapishortenerv1service.ExpandLinkRequest.new,
    espressocashapishortenerv1service.ExpandLinkResponse.new,
  );
}
