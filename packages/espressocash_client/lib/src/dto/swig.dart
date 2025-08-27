import 'dart:typed_data';

// SWIG Service DTOs

// Authority Types (from API doc)
class AuthorityType {
  static const int ed25519 = 1;
  static const int secp256k1 = 3;
  static const int secp256r1 = 5;
  
  static const String ed25519String = 'AUTHORITY_TYPE_ED25519';
  static const String secp256k1String = 'AUTHORITY_TYPE_SECP256K1';
  static const String secp256r1String = 'AUTHORITY_TYPE_SECP256R1';
}

// Permission Types (from API doc)
class PermissionType {
  static const int solLimit = 1;
  static const int all = 7;
}

// CreateWallet
class CreateWalletRequestDto {
  const CreateWalletRequestDto({
    required this.ownerAddress,
    required this.platform,
  });

  final String ownerAddress;
  final String platform;
}

class CreateWalletResponseDto {
  const CreateWalletResponseDto({
    required this.unsignedTransaction,
    required this.swigWalletAddress,
  });

  final String unsignedTransaction;
  final String swigWalletAddress;
}

// GetWalletAuthorities
class GetWalletAuthoritiesRequestDto {
  const GetWalletAuthoritiesRequestDto({
    required this.swigWalletAddress,
  });

  final String swigWalletAddress;
}

class GetWalletAuthoritiesResponseDto {
  const GetWalletAuthoritiesResponseDto({
    required this.authorities,
  });

  final List<SWIGAuthorityDto> authorities;
}

// PrepareAddAuthority
class PrepareAddAuthorityRequestDto {
  const PrepareAddAuthorityRequestDto({
    required this.swigWalletAddress,
    required this.signingRoleId,
    required this.newAuthority,
    required this.permissionActions,
  });

  final String swigWalletAddress;
  final int signingRoleId;
  final AuthorityInfoDto newAuthority;
  final List<PermissionActionDto> permissionActions;
}

class PrepareAddAuthorityResponseDto {
  const PrepareAddAuthorityResponseDto({
    required this.unsignedTransaction,
    required this.messageHash,
    required this.slot,
    required this.expectedCounter,
  });

  final String unsignedTransaction;
  final String messageHash;
  final int slot;
  final int expectedCounter;
}

// SubmitAddAuthority
class SubmitAddAuthorityRequestDto {
  const SubmitAddAuthorityRequestDto({
    required this.signingResult,
    required this.swigWalletAddress,
    required this.signingRoleId,
    required this.newAuthority,
    required this.permissionActions,
    required this.slot,
    required this.expectedCounter,
    this.authenticatorData,
    this.clientDataJson,
  });

  final SigningResultDto signingResult;
  final String swigWalletAddress;
  final int signingRoleId;
  final AuthorityInfoDto newAuthority;
  final List<PermissionActionDto> permissionActions;
  final int slot;
  final int expectedCounter;
  final String? authenticatorData;
  final String? clientDataJson;
}

class SubmitAddAuthorityResponseDto {
  const SubmitAddAuthorityResponseDto({
    required this.transactionSignature,
    required this.roleId,
    this.newAuthorityRoleId,
  });

  final String transactionSignature;
  final int roleId;
  final int? newAuthorityRoleId;
}

// PrepareSignV1
class PrepareSignV1RequestDto {
  const PrepareSignV1RequestDto({
    required this.swigWalletAddress,
    required this.signingRoleId,
    required this.wrappedInstructions,
  });

  final String swigWalletAddress;
  final int signingRoleId;
  final List<String> wrappedInstructions; // Base64 encoded JSONs
}

class PrepareSignV1ResponseDto {
  const PrepareSignV1ResponseDto({
    required this.unsignedTransaction,
    required this.messageHash,
    required this.authorityType,
    required this.slot,
    required this.expectedCounter,
  });

  final Uint8List unsignedTransaction; // Raw bytes as per API doc
  final String messageHash;
  final String authorityType;
  final int slot;
  final int expectedCounter;
}

// SubmitSignV1
class SubmitSignV1RequestDto {
  const SubmitSignV1RequestDto({
    required this.signingResult,
    required this.swigWalletAddress,
    required this.signingRoleId,
    required this.wrappedInstructions,
    required this.slot,
    required this.expectedCounter,
    required this.unsignedTransaction,
    this.authenticatorData,
    this.clientDataJson,
  });

  final SigningResultDto signingResult;
  final String swigWalletAddress;
  final int signingRoleId;
  final List<String> wrappedInstructions;
  final int slot;
  final int expectedCounter;
  final String unsignedTransaction;
  final String? authenticatorData;
  final String? clientDataJson;
}

class SubmitSignV1ResponseDto {
  const SubmitSignV1ResponseDto({
    required this.transactionSignature,
    this.feesPaidBy,
    this.actualFee,
  });

  final String transactionSignature;
  final String? feesPaidBy;
  final int? actualFee;
}

// Supporting DTOs
class SigningResultDto {
  const SigningResultDto({
    required this.signature,
    required this.prefix,
    required this.message,
  });

  final String signature; // Base64 encoded
  final String prefix; // Base64 encoded
  final String message; // Base64 encoded
}

class AuthorityInfoDto {
  const AuthorityInfoDto({
    required this.data,
    required this.type,
  });

  final String data; // Base64 encoded public key data
  final String type; // Authority type string
}

class PermissionActionDto {
  const PermissionActionDto({
    required this.permissionType,
    required this.permissionData,
  });

  final int permissionType;
  final String permissionData; // Base64 encoded
}

class SWIGAuthorityDto {
  const SWIGAuthorityDto({
    required this.roleId,
    required this.authorityType,
    required this.permissions,
  });

  final int roleId;
  final String authorityType;
  final List<PermissionActionDto> permissions;
}