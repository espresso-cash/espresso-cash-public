import 'package:solana/metaplex.dart';

abstract class OffchainMetadataRepository {
  Future<OffChainMetadata> getMetadata(Metadata metadata);
}
