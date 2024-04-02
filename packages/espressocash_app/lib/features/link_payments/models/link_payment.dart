import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../../tokens/token.dart';

part 'link_payment.freezed.dart';
part 'link_payment.g.dart';

@freezed
abstract class LinkPayment with _$LinkPayment {
  const factory LinkPayment({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
  }) = _LinkPayment;

  factory LinkPayment.fromJson(Map<String, dynamic> json) =>
      _$LinkPaymentFromJson(json);

  const LinkPayment._();

  static LinkPayment? tryParse(Uri link) {
    final isProperHost =
        link.scheme == 'https' && link.host == espressoCashLinkDomain ||
            link.host == 'localhost';

    if ((!isProperHost || link.queryParameters['t'] != 'link') &&
        link.scheme != espressoCashLinkProtocol) {
      return null;
    }

    final key = link.queryParameters['k'];
    if (key == null) return null;

    return LinkPayment(
      key: key,
      token: Token.usdc.publicKey,
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
