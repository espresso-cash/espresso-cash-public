import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import 'tokens/token.dart';

part 'tip_payments.freezed.dart';
part 'tip_payments.g.dart';

@freezed
class TipPaymentData with _$TipPaymentData {
  const factory TipPaymentData({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
  }) = _TipPaymentLink;

  factory TipPaymentData.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentDataFromJson(json);

  const TipPaymentData._();

  static TipPaymentData? tryParse(Uri link) {
    final correctSchemeAndHost = link.scheme == 'https' && link.host == tipHost;
    if (!correctSchemeAndHost) return null;

    final tokenAddress = link.queryParameters['token'];
    if (tokenAddress == null || tokenAddress != Token.usdc.address) return null;

    final key = link.queryParameters['key'];
    if (key == null) return null;

    final apiVersion = link.queryParameters['v'];
    if (apiVersion != 'v2') return null;

    return TipPaymentData(
      key: key,
      token: Ed25519HDPublicKey.fromBase58(tokenAddress),
    );
  }

  Uri toUri() => Uri(
        scheme: 'https',
        host: tipHost,
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
