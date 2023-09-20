import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import 'tokens/token.dart';

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
    if (link.scheme != 'https' || link.host != espressoCashLinkDomain) {
      return null;
    }

    final firstPart = link.queryParameters['k'];
    if (firstPart == null) return null;

    return LinkPayments(
      key: firstPart,
      token: Token.usdc.publicKey,
    );
  }

  Uri toUri() => Uri(
        scheme: 'https',
        host: espressoCashLinkDomain,
        path: '',
        queryParameters: <String, String>{
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
