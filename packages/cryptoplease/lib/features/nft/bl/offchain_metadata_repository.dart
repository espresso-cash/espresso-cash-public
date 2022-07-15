import 'package:solana/metaplex.dart';

class OffchainMetadataRepository {
  final Map<String, Future<OffChainMetadata>> _requests = {};

  Future<OffChainMetadata> getMetadata(Metadata metadata) async =>
      _requests.putIfAbsent(
        metadata.mint,
        () => metadata.getExternalJson(),
      );
}
