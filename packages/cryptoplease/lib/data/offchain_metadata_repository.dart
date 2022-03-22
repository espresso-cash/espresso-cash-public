import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:solana/metaplex.dart';

class OffchainMetadataRepositoryImpl implements OffchainMetadataRepository {
  final Map<String, Future<OffChainMetadata>> _requests = {};
  final Map<String, OffChainMetadata> _data = {};

  @override
  Future<OffChainMetadata> getMetadata(Metadata metadata) async {
    final saved = _data[metadata.mint];
    if (saved != null) {
      return saved;
    }

    return _requests.putIfAbsent(
      metadata.mint,
      () => metadata.getExternalJson().then((data) {
        _data[metadata.mint] = data;

        return data;
      }),
    );
  }
}
