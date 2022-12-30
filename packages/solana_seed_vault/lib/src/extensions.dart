import 'package:dfunc/dfunc.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/filter.dart';
import 'package:solana_seed_vault/src/models/signing_request.dart';
import 'package:solana_seed_vault/src/models/signing_response.dart';

extension SigningRequestExt on SigningRequest {
  SigningRequestDto toDto() => SigningRequestDto(
        payload: payload,
        requestedSignatures:
            requestedSignatures.map((it) => it.toString()).toList(),
      );
}

extension SigningResponseExt on SigningResponseDto {
  SigningResponse toModel() => SigningResponse(
        signatures: signatures.compact().toList(),
        resolvedDerivationPaths:
            resolvedDerivationPaths.compact().map(Uri.parse).toList(),
      );
}

extension AccountDtoExt on List<AccountDto?> {
  List<Account> toModelList() => this
      .compact()
      .map(
        (it) => Account(
          id: it.id,
          name: it.name,
          derivationPath: Uri.parse(it.derivationPath),
          publicKeyEncoded: it.publicKeyEncoded,
          isUserWallet: it.isUserWallet,
          isValid: it.isValid,
        ),
      )
      .toList();
}

extension AccountFilterExt on AccountFilter {
  AccountFilterDto? toDto() => when(
        always(null),
        byId: (id) => AccountFilterDto(
          key: AccountFilterColumnDto.id,
          value: id.toString(),
        ),
        byName: (name) => AccountFilterDto(
          key: AccountFilterColumnDto.name,
          value: name,
        ),
        byDerivationPath: (derivationPath) => AccountFilterDto(
          key: AccountFilterColumnDto.derivationPath,
          value: derivationPath.toString(),
        ),
        byPublicKeyEncoded: (publicKeyEncoded) => AccountFilterDto(
          key: AccountFilterColumnDto.publicKeyEncoded,
          value: publicKeyEncoded.toString(),
        ),
        byIsUserWallet: (isUserWallet) => AccountFilterDto(
          key: AccountFilterColumnDto.isUserWallet,
          value: isUserWallet.toString(),
        ),
        byIsValid: (isValid) => AccountFilterDto(
          key: AccountFilterColumnDto.isValid,
          value: isValid.toString(),
        ),
      );
}
