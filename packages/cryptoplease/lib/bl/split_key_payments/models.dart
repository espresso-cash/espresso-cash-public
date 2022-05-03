import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/config.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class SplitKeyIncomingFirstPart with _$SplitKeyIncomingFirstPart {
  const factory SplitKeyIncomingFirstPart({
    required String keyPart,
    required String tokenAddress,
  }) = _SplitKeyIncomingFirstPart;

  factory SplitKeyIncomingFirstPart.fromJson(Map<String, dynamic> json) =>
      _$SplitKeyIncomingFirstPartFromJson(json);

  static SplitKeyIncomingFirstPart? tryParse(Uri link) {
    final correctSchemeAndHost =
        link.scheme == 'cryptoplease-sol' && link.host == '1' ||
            link.scheme == 'https' &&
                link.host == 'sol.$cpLinkDomain' &&
                (link.path == '/' || link.path == '') ||
            link.scheme == 'https' && link.host == 'sol1.$cpLinkDomain' ||
            link.scheme == 'https' && link.host == link1Host;
    if (!correctSchemeAndHost) return null;

    final tokenAddress = link.queryParameters['token'] ?? Token.sol.address;
    final firstPart = link.queryParameters['key'];

    if (firstPart == null) return null;

    return SplitKeyIncomingFirstPart(
      keyPart: firstPart,
      tokenAddress: tokenAddress,
    );
  }
}

@freezed
class SplitKeySecondLink with _$SplitKeySecondLink {
  const factory SplitKeySecondLink({required String key}) = _SplitKeySecondLink;

  static SplitKeySecondLink? tryParse(Uri uri) {
    final String? secondPart;

    if (uri.scheme == 'cryptoplease-sol' && uri.host == '2' ||
        uri.scheme == 'https' && uri.host == 'sol2.$cpLinkDomain' ||
        uri.scheme == 'https' && uri.host == link2Host) {
      secondPart = uri.queryParameters['key'];
      if (secondPart == null) return null;

      return SplitKeySecondLink(key: secondPart);
    }
    // Old format
    else if (uri.scheme == _ghUrlScheme && uri.host == _ghUrlHost) {
      secondPart = uri.queryParameters[_ghQueryParam];
    } else if (uri.scheme == _cpUrlScheme && uri.host == _cpUrlHost) {
      secondPart = uri.queryParameters[_cpQueryParam];
    } else {
      return null;
    }

    if (secondPart == null) return null;
    if (!secondPart.endsWith(_linkSuffix)) return null;

    return SplitKeySecondLink(
      key: secondPart.substring(0, secondPart.length - _linkSuffix.length),
    );
  }
}

Uri buildFirstLink(IList<int> privateKey, String tokenAddress) => Uri(
      scheme: 'https',
      host: link1Host,
      path: '/',
      queryParameters: <String, String>{
        'key': splitKey(privateKey).first,
        if (tokenAddress != Token.sol.address) 'token': tokenAddress,
      },
    );

Uri buildSecondLink(IList<int> privateKey) =>
    SplitKeySecondLink(key: splitKey(privateKey).last).uri;

extension on SplitKeySecondLink {
  Uri get uri => Uri.parse('https://$link2Host/?key=$key');
}

@visibleForTesting
List<String> splitKey(IList<int> privateKey) {
  final parts = privateKey.splitAt(privateKey.length ~/ 2);

  return [
    base58encode(parts.first.toList()),
    base58encode(parts.second.toList()),
  ];
}

const _linkSuffix = '_a';

const _cpUrlScheme = 'cryptoplease';
const _cpUrlHost = 'sk';
const _cpQueryParam = 'second';
const _ghUrlScheme = 'https';
const _ghUrlHost = 'cryptoplease.github.io';
const _ghQueryParam = 'data';
