import 'package:solana_seed_vault/solana_seed_vault.dart';

class Bip32DerivationPath {
  static Uri toUri(List<BipLevel> bipLevels) {
    final pathSegments = [
      '',
      WalletContractV1.bip32UriMasterKeyIndicator,
      ...bipLevels.map(
        (it) => it.hardened
            ? '${it.index}${WalletContractV1.bipUriHardenedIndexIdentifier}'
            : it.index.toString(),
      ),
    ];

    return Uri(
      scheme: WalletContractV1.bip32UriScheme,
      pathSegments: pathSegments,
    );
  }

  static List<BipLevel> fromUri(Uri uri) {
    if (!uri.hasAbsolutePath) {
      throw UnsupportedError('BIP32 URI must be hierarchical');
    }
    if (uri.isAbsolute && !uri.isScheme(WalletContractV1.bip32UriScheme)) {
      throw UnsupportedError(
        'BIP32 URI absolute scheme must be ${WalletContractV1.bip32UriScheme}',
      );
    }
    if (uri.hasAuthority) {
      throw UnsupportedError('BIP32 URI authority must be null');
    }
    if (uri.hasQuery) {
      throw UnsupportedError('BIP32 URI query must be null');
    }
    if (uri.hasFragment) {
      throw UnsupportedError('BIP32 URI fragment must be null');
    }

    final path = uri.pathSegments;
    if (path.isEmpty ||
        path.first != WalletContractV1.bip32UriMasterKeyIndicator) {
      throw UnsupportedError(
        'BIP32 URI path must start with a master key indicator',
      );
    }

    return path.skip(1).map(
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
            'Path element $it could not be parsed as a BIP32 level',
          );
        }

        return BipLevel(index: index, hardened: hardened);
      },
    ).toList();
  }
}
