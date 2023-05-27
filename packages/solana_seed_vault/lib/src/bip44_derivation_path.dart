import 'package:solana_seed_vault/solana_seed_vault.dart';

class Bip44DerivationPath {
  static Uri toUri(List<BipLevel> bipLevels) {
    final pathSegments = bipLevels.map(
      (it) => it.hardened
          ? '${it.index}${WalletContractV1.bipUriHardenedIndexIdentifier}'
          : it.index.toString(),
    );

    return Uri(
      scheme: WalletContractV1.bip44UriScheme,
      pathSegments: pathSegments.toList()..insert(0, ''),
    );
  }

  static Bip44Data fromUri(Uri uri) {
    if (!uri.hasAbsolutePath) {
      throw UnsupportedError('BIP44 URI must be hierarchical');
    }
    if (!uri.isAbsolute || !uri.isScheme(WalletContractV1.bip44UriScheme)) {
      throw UnsupportedError(
        'BIP44 URI must be absolute with scheme ${WalletContractV1.bip44UriScheme}',
      );
    }
    if (uri.hasAuthority) {
      throw UnsupportedError('BIP44 URI authority must be null');
    }
    if (uri.hasQuery) {
      throw UnsupportedError('BIP44 URI query must be null');
    }
    if (uri.hasFragment) {
      throw UnsupportedError('BIP44 URI fragment must be null');
    }

    final path = uri.pathSegments;
    if (path.isEmpty || path.length > 3) {
      throw UnsupportedError(
        'BIP44 URI path must contain between 1 and 3 elements',
      );
    }

    final levels = path.map(
      (it) {
        final hardened =
            it.endsWith(WalletContractV1.bipUriHardenedIndexIdentifier);
        final index = int.tryParse(
          it.substring(
            0,
            it.length -
                (hardened
                    ? WalletContractV1.bipUriHardenedIndexIdentifier.length
                    : 0),
          ),
        );
        if (index == null) {
          throw UnsupportedError(
            'Path element $it could not be parsed as a BIP44 level',
          );
        }

        return BipLevel(index: index, hardened: hardened);
      },
    );

    BipLevel? getLevelOrNull(int index) {
      if (levels.length <= index) return null;

      return levels.elementAt(index);
    }

    final account = getLevelOrNull(0);
    if (account == null) {
      throw AssertionError('Account must not be null');
    }

    return Bip44Data(
      account: account,
      change: getLevelOrNull(1),
      addressIndex: getLevelOrNull(2),
    );
  }
}
