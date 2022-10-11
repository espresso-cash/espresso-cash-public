import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'split_key_payments.freezed.dart';
part 'split_key_payments.g.dart';

@freezed
class SplitKeyFirstLink with _$SplitKeyFirstLink {
  const factory SplitKeyFirstLink({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
  }) = _SplitKeyFirstLink;

  factory SplitKeyFirstLink.fromJson(Map<String, dynamic> json) =>
      _$SplitKeyFirstLinkFromJson(json);

  const SplitKeyFirstLink._();

  static SplitKeyFirstLink? tryParse(Uri link) {
    final correctSchemeAndHost =
        link.scheme == 'cryptoplease-sol' && link.host == '1' ||
            link.scheme == 'https' &&
                link.host == 'sol.$cpLinkDomain' &&
                (link.path == '/' || link.path == '') ||
            link.scheme == 'https' && link.host == 'sol1.$cpLinkDomain' ||
            link.scheme == 'https' && link.host == link1Host;
    if (!correctSchemeAndHost) return null;

    final tokenAddress = link.queryParameters['token'];
    if (tokenAddress == null || tokenAddress != Token.usdc.address) return null;

    final firstPart = link.queryParameters['key'];
    if (firstPart == null) return null;

    final apiVersion = link.queryParameters['v'];
    if (apiVersion != 'v2') return null;

    return SplitKeyFirstLink(
      key: firstPart,
      token: Ed25519HDPublicKey.fromBase58(tokenAddress),
    );
  }

  Uri toUri() => Uri(
        scheme: 'https',
        host: link1Host,
        path: '/',
        queryParameters: <String, String>{
          'key': key,
          if (token != Token.sol.publicKey) 'token': token.toBase58(),
          'v': 'v2',
        },
      );
}

@freezed
class SplitKeySecondLink with _$SplitKeySecondLink {
  const factory SplitKeySecondLink({
    required String key,
  }) = _SplitKeySecondLink;

  const SplitKeySecondLink._();

  static SplitKeySecondLink? tryParse(Uri uri) {
    final String? secondPart;

    if (uri.scheme == 'cryptoplease-sol' && uri.host == '2' ||
        uri.scheme == 'https' && uri.host == 'sol2.$cpLinkDomain' ||
        uri.scheme == 'https' && uri.host == link2Host) {
      secondPart = uri.queryParameters['key'];
      if (secondPart == null) return null;

      return SplitKeySecondLink(key: secondPart);
    } else {
      return null;
    }
  }

  Uri toUri() => Uri.parse('https://$link2Host/?key=$key');
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
