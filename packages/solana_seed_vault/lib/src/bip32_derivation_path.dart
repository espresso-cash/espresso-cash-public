import 'package:solana_seed_vault/solana_seed_vault.dart';

class Bip32DerivationPath {
  static Uri toUri(List<BipLevel> bipLevels) {
    final pathSegments = [
      '',
      _bip32UriMasterKeyIndicator,
      ...bipLevels.map(
        (it) {
          if (it.hardened) {
            return '${it.index}$_bipUriHardenedIndexIdentifier';
          } else {
            return it.index.toString();
          }
        },
      ),
    ];

    return Uri(
      scheme: _bip32UriScheme,
      pathSegments: pathSegments,
    );
  }

  static List<BipLevel> fromUri(Uri uri) {
    if (!uri.hasAbsolutePath) {
      throw UnsupportedError('BIP32 URI must be hierarchical');
    }
    if (uri.isAbsolute && !uri.isScheme(_bip32UriScheme)) {
      throw UnsupportedError(
        'BIP32 URI absolute scheme must be $_bip32UriScheme',
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
    if (path.isEmpty || path.first != _bip32UriMasterKeyIndicator) {
      throw UnsupportedError(
        'BIP32 URI path must start with a master key indicator',
      );
    }

    return path.skip(1).map(
      (it) {
        final hardened = it.endsWith(_bipUriHardenedIndexIdentifier);
        final index = int.tryParse(
          it.substring(
            0,
            it.length - (hardened ? _bipUriHardenedIndexIdentifier.length : 0),
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

const String _bip32UriScheme = 'bip32';
const String _bip32UriMasterKeyIndicator = 'm';
const String _bipUriHardenedIndexIdentifier = '\'';
