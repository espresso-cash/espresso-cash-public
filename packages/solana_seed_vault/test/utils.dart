import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';

class FakePublicKeyResponseDto extends PublicKeyResponseDto {
  FakePublicKeyResponseDto()
      : super(
          resolvedDerivationPath: '',
          publicKey: Uint8List(1),
          publicKeyEncoded: '',
        );
}

class FakeImplementationLimitsDto extends ImplementationLimitsDto {
  FakeImplementationLimitsDto()
      : super(
          maxBip32PathDepth: 0,
          maxRequestedPublicKeys: 0,
          maxRequestedSignatures: 0,
          maxSigningRequests: 0,
        );
}

class FakeAccountDto extends AccountDto {
  FakeAccountDto(int index)
      : super(
          id: index,
          name: 'Account $index',
          derivationPath: 'bip32:/m/44\'/501\'/$index\'',
          publicKeyEncoded: '',
          isUserWallet: false,
          isValid: false,
        );
}

class FakeSeedDto extends SeedDto {
  FakeSeedDto(int authToken)
      : super(
          authToken: authToken,
          name: '',
          purpose: 0,
          accounts: List.generate(2, FakeAccountDto.new),
        );
}

class FakeSigningResponseDto extends SigningResponseDto {
  FakeSigningResponseDto(List<AccountDto> signers)
      : super(
          resolvedDerivationPaths:
              signers.map((it) => it.derivationPath).toList(),
          signatures: signers.map((_) => Uint8List(512)).toList(),
        );
}
