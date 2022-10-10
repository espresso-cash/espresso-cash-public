import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_iskp.freezed.dart';
part 'pending_iskp.g.dart';

@freezed
class ISKPFirstPart with _$ISKPFirstPart {
  const factory ISKPFirstPart({
    required String key,
    required String token,
  }) = _ISKPFirstPart;

  factory ISKPFirstPart.fromJson(Map<String, dynamic> json) =>
      _$ISKPFirstPartFromJson(json);

  static ISKPFirstPart? tryParse(Uri link) {
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

    return ISKPFirstPart(key: firstPart, token: tokenAddress);
  }
}

@freezed
class ISKPSecondPart with _$ISKPSecondPart {
  const factory ISKPSecondPart({required String key}) = _ISKPSecondPart;

  static ISKPSecondPart? tryParse(Uri uri) {
    final String? secondPart;

    if (uri.scheme == 'cryptoplease-sol' && uri.host == '2' ||
        uri.scheme == 'https' && uri.host == 'sol2.$cpLinkDomain' ||
        uri.scheme == 'https' && uri.host == link2Host) {
      secondPart = uri.queryParameters['key'];
      if (secondPart == null) return null;

      return ISKPSecondPart(key: secondPart);
    } else {
      return null;
    }
  }
}
