import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import 'tokens/token.dart';

part 'tip_payments.freezed.dart';
part 'tip_payments.g.dart';

@freezed
class TipPaymentLink with _$TipPaymentLink {
  const factory TipPaymentLink({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
  }) = _TipPaymentLink;

  factory TipPaymentLink.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentLinkFromJson(json);

  const TipPaymentLink._();

  static TipPaymentLink? tryParse(Uri link) {
    final correctSchemeAndHost =
        link.scheme == 'cryptoplease-sol' && link.host == '1' ||
            link.scheme == 'https' && link.host == link1Host; //TODO
    if (!correctSchemeAndHost) return null;

    final tokenAddress = link.queryParameters['token'];
    if (tokenAddress == null || tokenAddress != Token.usdc.address) return null;

    final firstPart = link.queryParameters['key'];
    if (firstPart == null) return null;

    final apiVersion = link.queryParameters['v'];
    if (apiVersion != 'v2') return null;

    return TipPaymentLink(
      key: firstPart,
      token: Ed25519HDPublicKey.fromBase58(tokenAddress),
    );
  }

  Uri toUri() => Uri(
        scheme: 'https',
        host: link1Host, //TODO host
        path: '/',
        queryParameters: <String, String>{
          'key': key,
          if (token != Token.sol.publicKey) 'token': token.toBase58(),
          'v': 'v2',
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
