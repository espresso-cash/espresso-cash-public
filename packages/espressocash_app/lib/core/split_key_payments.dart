import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import 'api_version.dart';
import 'tokens/token.dart';

part 'split_key_payments.freezed.dart';
part 'split_key_payments.g.dart';

enum SplitKeySource { qr, other }

@freezed
class SplitKeyFirstLink with _$SplitKeyFirstLink {
  const factory SplitKeyFirstLink({
    required String key,
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey token,
    required SplitKeyApiVersion apiVersion,
    required SplitKeySource source,
  }) = _SplitKeyFirstLink;

  factory SplitKeyFirstLink.fromJson(Map<String, dynamic> json) =>
      _$SplitKeyFirstLinkFromJson(json);

  const SplitKeyFirstLink._();

  static const _qrSource = 'qr';

  static SplitKeyFirstLink? tryParse(Uri link) {
    if (link.scheme == 'https' && link.host == espressoCashLinkDomain ||
        link.scheme == espressoCashLinkProtocol) {
      final firstPart = link.queryParameters['k1'];
      if (firstPart == null) return null;

      final source = link.queryParameters['source'];

      return SplitKeyFirstLink(
        key: firstPart,
        token: Token.usdc.publicKey,
        apiVersion: SplitKeyApiVersion.smartContract,
        source: source == _qrSource ? SplitKeySource.qr : SplitKeySource.other,
      );
    }

    final correctSchemeAndHost =
        link.scheme == 'cryptoplease-sol' && link.host == '1' ||
            link.scheme == 'https' && link.host == link1Host;
    if (!correctSchemeAndHost) return null;

    final tokenAddress = link.queryParameters['token'];
    if (tokenAddress == null || tokenAddress != Token.usdc.address) return null;

    final firstPart = link.queryParameters['key'];
    if (firstPart == null) return null;

    final apiVersion = link.queryParameters['v'];
    if (apiVersion != 'v2') return null;

    final type = link.queryParameters['type'];
    if (type != null) return null;

    return SplitKeyFirstLink(
      key: firstPart,
      token: Ed25519HDPublicKey.fromBase58(tokenAddress),
      apiVersion: SplitKeyApiVersion.manual,
      source: SplitKeySource.other,
    );
  }

  Uri toUri() {
    switch (apiVersion) {
      case SplitKeyApiVersion.manual:
        return Uri(
          scheme: 'https',
          host: link1Host,
          path: '/',
          queryParameters: <String, String>{
            'key': key,
            if (token != Token.sol.publicKey) 'token': token.toBase58(),
            'v': 'v2',
          },
        );
      case SplitKeyApiVersion.smartContract:
        return Uri(
          scheme: 'https',
          host: espressoCashLinkDomain,
          path: '',
          queryParameters: <String, String>{
            'k1': key,
            if (source == SplitKeySource.qr) 'source': _qrSource,
          },
        );
    }
  }
}

@freezed
class SplitKeySecondLink with _$SplitKeySecondLink {
  const factory SplitKeySecondLink({
    required String key,
    required SplitKeyApiVersion apiVersion,
  }) = _SplitKeySecondLink;

  const SplitKeySecondLink._();

  static SplitKeySecondLink? tryParse(Uri link) {
    if (link.scheme == 'https' && link.host == espressoCashLinkDomain ||
        link.scheme == espressoCashLinkProtocol) {
      final secondPart = link.queryParameters['k2'];
      if (secondPart == null) return null;

      return SplitKeySecondLink(
        key: secondPart,
        apiVersion: SplitKeyApiVersion.smartContract,
      );
    }

    if (link.scheme == 'cryptoplease-sol' && link.host == '2' ||
        link.scheme == 'https' && link.host == link2Host) {
      final String? secondPart;
      secondPart = link.queryParameters['key'];
      if (secondPart == null) return null;

      return SplitKeySecondLink(
        key: secondPart,
        apiVersion: SplitKeyApiVersion.manual,
      );
    }
  }

  Uri toUri() {
    switch (apiVersion) {
      case SplitKeyApiVersion.manual:
        return Uri.parse('https://$link2Host/?key=$key');
      case SplitKeyApiVersion.smartContract:
        return Uri(
          scheme: 'https',
          host: espressoCashLinkDomain,
          path: '',
          queryParameters: <String, String>{
            'k2': key,
          },
        );
    }
  }
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
