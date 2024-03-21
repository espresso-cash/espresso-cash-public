import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../config.dart';

part 'link_payments.freezed.dart';
part 'link_payments.g.dart';

@freezed
abstract class LinkPayments with _$LinkPayments {
  const factory LinkPayments({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
  }) = _LinkPayments;

  factory LinkPayments.fromJson(Map<String, dynamic> json) =>
      _$LinkPaymentsFromJson(json);

  const LinkPayments._();

  static LinkPayments? tryParse(Uri link) {
    final isProperHost =
        link.scheme == 'https' && link.host == espressoCashLinkDomain ||
            link.host == 'localhost';

    if ((!isProperHost || link.queryParameters['t'] != 'link') &&
        link.scheme != espressoCashLinkProtocol) {
      return null;
    }

    final key = link.queryParameters['k'];
    if (key == null) return null;

    return LinkPayments(
      key: key,
      token: isProd ? mainnetUsdc : devnetUsdc,
    );
  }

  Uri toDeepLinkUri() => Uri(
        scheme: espressoCashLinkProtocol,
        host: '',
        path: '',
        queryParameters: <String, String>{
          'k': key,
        },
      );

  Uri toShareableLink() => Uri(
        scheme: 'https',
        host: espressoCashLinkDomain,
        path: '',
        queryParameters: <String, String>{
          't': 'link',
          'k': key,
        },
      );
}

class Ed25519HDPublicKeyConverter
    implements JsonConverter<Ed25519HDPublicKey, String> {
  const Ed25519HDPublicKeyConverter();

  @override
  Ed25519HDPublicKey fromJson(String json) =>
      Ed25519HDPublicKey.fromBase58(json);

  @override
  String toJson(Ed25519HDPublicKey object) => object.toBase58();
}
