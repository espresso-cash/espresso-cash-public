import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:solana/metaplex.dart';

class OffchainMetadataRepositoryImpl implements OffchainMetadataRepository {
  final Map<String, Future<OffChainMetadata>> _requests = {};

  @override
  Future<OffChainMetadata> getMetadata(Metadata metadata) async =>
      _requests.putIfAbsent(
        metadata.mint,
        () => metadata.getExternalJson(),
      );
}
