import '../../features/blockchain/models/blockchain.dart';
import 'db_landing.dart';

extension BlockchainExt on Blockchain {
  BlockchainDto toDto() => switch (this) {
        Blockchain.arbitrum => BlockchainDto.arbitrum,
        Blockchain.polygon => BlockchainDto.polygon,
        Blockchain.ethereum => BlockchainDto.ethereum,
      };
}

extension BlockchainDtoExt on BlockchainDto {
  Blockchain toModel() => switch (this) {
        BlockchainDto.arbitrum => Blockchain.arbitrum,
        BlockchainDto.polygon => Blockchain.polygon,
        BlockchainDto.ethereum => Blockchain.ethereum,
      };
}
