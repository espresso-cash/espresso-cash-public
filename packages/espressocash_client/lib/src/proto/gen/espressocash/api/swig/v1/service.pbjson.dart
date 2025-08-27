// This is a generated file - do not edit.
//
// Generated from espressocash/api/swig/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use signingMethodDescriptor instead')
const SigningMethod$json = {
  '1': 'SigningMethod',
  '2': [
    {'1': 'SIGNING_METHOD_UNSPECIFIED', '2': 0},
    {'1': 'SIGNING_METHOD_TRANSACTION', '2': 1},
    {'1': 'SIGNING_METHOD_PAYLOAD', '2': 2},
  ],
};

/// Descriptor for `SigningMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signingMethodDescriptor = $convert.base64Decode(
    'Cg1TaWduaW5nTWV0aG9kEh4KGlNJR05JTkdfTUVUSE9EX1VOU1BFQ0lGSUVEEAASHgoaU0lHTk'
    'lOR19NRVRIT0RfVFJBTlNBQ1RJT04QARIaChZTSUdOSU5HX01FVEhPRF9QQVlMT0FEEAI=');

@$core.Deprecated('Use authorityTypeDescriptor instead')
const AuthorityType$json = {
  '1': 'AuthorityType',
  '2': [
    {'1': 'AUTHORITY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'AUTHORITY_TYPE_ED25519', '2': 1},
    {'1': 'AUTHORITY_TYPE_SECP256K1', '2': 3},
    {'1': 'AUTHORITY_TYPE_SECP256R1', '2': 5},
  ],
};

/// Descriptor for `AuthorityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List authorityTypeDescriptor = $convert.base64Decode(
    'Cg1BdXRob3JpdHlUeXBlEh4KGkFVVEhPUklUWV9UWVBFX1VOU1BFQ0lGSUVEEAASGgoWQVVUSE'
    '9SSVRZX1RZUEVfRUQyNTUxORABEhwKGEFVVEhPUklUWV9UWVBFX1NFQ1AyNTZLMRADEhwKGEFV'
    'VEhPUklUWV9UWVBFX1NFQ1AyNTZSMRAF');

@$core.Deprecated('Use createWalletRequestDescriptor instead')
const CreateWalletRequest$json = {
  '1': 'CreateWalletRequest',
  '2': [
    {'1': 'owner_address', '3': 1, '4': 1, '5': 9, '10': 'ownerAddress'},
    {
      '1': 'passkey_public_key',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'passkeyPublicKey',
      '17': true
    },
    {
      '1': 'privy_public_key',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'privyPublicKey',
      '17': true
    },
    {'1': 'platform', '3': 4, '4': 1, '5': 9, '10': 'platform'},
  ],
  '8': [
    {'1': '_passkey_public_key'},
    {'1': '_privy_public_key'},
  ],
};

/// Descriptor for `CreateWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVXYWxsZXRSZXF1ZXN0EiMKDW93bmVyX2FkZHJlc3MYASABKAlSDG93bmVyQWRkcm'
    'VzcxIxChJwYXNza2V5X3B1YmxpY19rZXkYAiABKAxIAFIQcGFzc2tleVB1YmxpY0tleYgBARIt'
    'ChBwcml2eV9wdWJsaWNfa2V5GAMgASgMSAFSDnByaXZ5UHVibGljS2V5iAEBEhoKCHBsYXRmb3'
    'JtGAQgASgJUghwbGF0Zm9ybUIVChNfcGFzc2tleV9wdWJsaWNfa2V5QhMKEV9wcml2eV9wdWJs'
    'aWNfa2V5');

@$core.Deprecated('Use createWalletResponseDescriptor instead')
const CreateWalletResponse$json = {
  '1': 'CreateWalletResponse',
  '2': [
    {
      '1': 'unsigned_transaction',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'unsignedTransaction'
    },
    {
      '1': 'swig_wallet_address',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
  ],
};

/// Descriptor for `CreateWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVXYWxsZXRSZXNwb25zZRIxChR1bnNpZ25lZF90cmFuc2FjdGlvbhgBIAEoCVITdW'
    '5zaWduZWRUcmFuc2FjdGlvbhIuChNzd2lnX3dhbGxldF9hZGRyZXNzGAIgASgJUhFzd2lnV2Fs'
    'bGV0QWRkcmVzcw==');

@$core.Deprecated('Use signingResultDescriptor instead')
const SigningResult$json = {
  '1': 'SigningResult',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 12, '10': 'signature'},
    {'1': 'prefix', '3': 2, '4': 1, '5': 12, '10': 'prefix'},
    {'1': 'message', '3': 3, '4': 1, '5': 12, '10': 'message'},
  ],
};

/// Descriptor for `SigningResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signingResultDescriptor = $convert.base64Decode(
    'Cg1TaWduaW5nUmVzdWx0EhwKCXNpZ25hdHVyZRgBIAEoDFIJc2lnbmF0dXJlEhYKBnByZWZpeB'
    'gCIAEoDFIGcHJlZml4EhgKB21lc3NhZ2UYAyABKAxSB21lc3NhZ2U=');

@$core.Deprecated('Use authorityInfoDescriptor instead')
const AuthorityInfo$json = {
  '1': 'AuthorityInfo',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.swig.v1.AuthorityType',
      '10': 'type'
    },
  ],
};

/// Descriptor for `AuthorityInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorityInfoDescriptor = $convert.base64Decode(
    'Cg1BdXRob3JpdHlJbmZvEhIKBGRhdGEYASABKAxSBGRhdGESOwoEdHlwZRgCIAEoDjInLmVzcH'
    'Jlc3NvY2FzaC5hcGkuc3dpZy52MS5BdXRob3JpdHlUeXBlUgR0eXBl');

@$core.Deprecated('Use permissionActionDescriptor instead')
const PermissionAction$json = {
  '1': 'PermissionAction',
  '2': [
    {'1': 'permission_type', '3': 1, '4': 1, '5': 13, '10': 'permissionType'},
    {'1': 'permission_data', '3': 2, '4': 1, '5': 12, '10': 'permissionData'},
  ],
};

/// Descriptor for `PermissionAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List permissionActionDescriptor = $convert.base64Decode(
    'ChBQZXJtaXNzaW9uQWN0aW9uEicKD3Blcm1pc3Npb25fdHlwZRgBIAEoDVIOcGVybWlzc2lvbl'
    'R5cGUSJwoPcGVybWlzc2lvbl9kYXRhGAIgASgMUg5wZXJtaXNzaW9uRGF0YQ==');

@$core.Deprecated('Use prepareAddAuthorityRequestDescriptor instead')
const PrepareAddAuthorityRequest$json = {
  '1': 'PrepareAddAuthorityRequest',
  '2': [
    {
      '1': 'swig_wallet_address',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
    {'1': 'signing_role_id', '3': 2, '4': 1, '5': 13, '10': 'signingRoleId'},
    {
      '1': 'new_authority',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.swig.v1.AuthorityInfo',
      '10': 'newAuthority'
    },
    {
      '1': 'permission_actions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.espressocash.api.swig.v1.PermissionAction',
      '10': 'permissionActions'
    },
  ],
};

/// Descriptor for `PrepareAddAuthorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List prepareAddAuthorityRequestDescriptor = $convert.base64Decode(
    'ChpQcmVwYXJlQWRkQXV0aG9yaXR5UmVxdWVzdBIuChNzd2lnX3dhbGxldF9hZGRyZXNzGAEgAS'
    'gJUhFzd2lnV2FsbGV0QWRkcmVzcxImCg9zaWduaW5nX3JvbGVfaWQYAiABKA1SDXNpZ25pbmdS'
    'b2xlSWQSTAoNbmV3X2F1dGhvcml0eRgDIAEoCzInLmVzcHJlc3NvY2FzaC5hcGkuc3dpZy52MS'
    '5BdXRob3JpdHlJbmZvUgxuZXdBdXRob3JpdHkSWQoScGVybWlzc2lvbl9hY3Rpb25zGAQgAygL'
    'MiouZXNwcmVzc29jYXNoLmFwaS5zd2lnLnYxLlBlcm1pc3Npb25BY3Rpb25SEXBlcm1pc3Npb2'
    '5BY3Rpb25z');

@$core.Deprecated('Use prepareAddAuthorityResponseDescriptor instead')
const PrepareAddAuthorityResponse$json = {
  '1': 'PrepareAddAuthorityResponse',
  '2': [
    {
      '1': 'unsigned_transaction',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'unsignedTransaction'
    },
    {'1': 'expected_role_id', '3': 2, '4': 1, '5': 13, '10': 'expectedRoleId'},
    {'1': 'authority_type', '3': 3, '4': 1, '5': 9, '10': 'authorityType'},
    {'1': 'estimated_fee', '3': 4, '4': 1, '5': 4, '10': 'estimatedFee'},
    {'1': 'slot', '3': 5, '4': 1, '5': 4, '10': 'slot'},
    {'1': 'expected_counter', '3': 6, '4': 1, '5': 13, '10': 'expectedCounter'},
    {'1': 'message_hash', '3': 7, '4': 1, '5': 12, '10': 'messageHash'},
  ],
};

/// Descriptor for `PrepareAddAuthorityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List prepareAddAuthorityResponseDescriptor = $convert.base64Decode(
    'ChtQcmVwYXJlQWRkQXV0aG9yaXR5UmVzcG9uc2USMQoUdW5zaWduZWRfdHJhbnNhY3Rpb24YAS'
    'ABKAxSE3Vuc2lnbmVkVHJhbnNhY3Rpb24SKAoQZXhwZWN0ZWRfcm9sZV9pZBgCIAEoDVIOZXhw'
    'ZWN0ZWRSb2xlSWQSJQoOYXV0aG9yaXR5X3R5cGUYAyABKAlSDWF1dGhvcml0eVR5cGUSIwoNZX'
    'N0aW1hdGVkX2ZlZRgEIAEoBFIMZXN0aW1hdGVkRmVlEhIKBHNsb3QYBSABKARSBHNsb3QSKQoQ'
    'ZXhwZWN0ZWRfY291bnRlchgGIAEoDVIPZXhwZWN0ZWRDb3VudGVyEiEKDG1lc3NhZ2VfaGFzaB'
    'gHIAEoDFILbWVzc2FnZUhhc2g=');

@$core.Deprecated('Use submitAddAuthorityRequestDescriptor instead')
const SubmitAddAuthorityRequest$json = {
  '1': 'SubmitAddAuthorityRequest',
  '2': [
    {
      '1': 'signing_result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.swig.v1.SigningResult',
      '10': 'signingResult'
    },
    {
      '1': 'swig_wallet_address',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
    {'1': 'signing_role_id', '3': 3, '4': 1, '5': 13, '10': 'signingRoleId'},
    {
      '1': 'new_authority',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.swig.v1.AuthorityInfo',
      '10': 'newAuthority'
    },
    {
      '1': 'permission_actions',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.espressocash.api.swig.v1.PermissionAction',
      '10': 'permissionActions'
    },
    {'1': 'slot', '3': 6, '4': 1, '5': 4, '10': 'slot'},
    {'1': 'expected_counter', '3': 7, '4': 1, '5': 13, '10': 'expectedCounter'},
    {
      '1': 'authenticator_data',
      '3': 8,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'authenticatorData',
      '17': true
    },
    {
      '1': 'client_data_json',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'clientDataJson',
      '17': true
    },
  ],
  '8': [
    {'1': '_authenticator_data'},
    {'1': '_client_data_json'},
  ],
};

/// Descriptor for `SubmitAddAuthorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitAddAuthorityRequestDescriptor = $convert.base64Decode(
    'ChlTdWJtaXRBZGRBdXRob3JpdHlSZXF1ZXN0Ek4KDnNpZ25pbmdfcmVzdWx0GAEgASgLMicuZX'
    'NwcmVzc29jYXNoLmFwaS5zd2lnLnYxLlNpZ25pbmdSZXN1bHRSDXNpZ25pbmdSZXN1bHQSLgoT'
    'c3dpZ193YWxsZXRfYWRkcmVzcxgCIAEoCVIRc3dpZ1dhbGxldEFkZHJlc3MSJgoPc2lnbmluZ1'
    '9yb2xlX2lkGAMgASgNUg1zaWduaW5nUm9sZUlkEkwKDW5ld19hdXRob3JpdHkYBCABKAsyJy5l'
    'c3ByZXNzb2Nhc2guYXBpLnN3aWcudjEuQXV0aG9yaXR5SW5mb1IMbmV3QXV0aG9yaXR5ElkKEn'
    'Blcm1pc3Npb25fYWN0aW9ucxgFIAMoCzIqLmVzcHJlc3NvY2FzaC5hcGkuc3dpZy52MS5QZXJt'
    'aXNzaW9uQWN0aW9uUhFwZXJtaXNzaW9uQWN0aW9ucxISCgRzbG90GAYgASgEUgRzbG90EikKEG'
    'V4cGVjdGVkX2NvdW50ZXIYByABKA1SD2V4cGVjdGVkQ291bnRlchIyChJhdXRoZW50aWNhdG9y'
    'X2RhdGEYCCABKAxIAFIRYXV0aGVudGljYXRvckRhdGGIAQESLQoQY2xpZW50X2RhdGFfanNvbh'
    'gJIAEoCUgBUg5jbGllbnREYXRhSnNvbogBAUIVChNfYXV0aGVudGljYXRvcl9kYXRhQhMKEV9j'
    'bGllbnRfZGF0YV9qc29u');

@$core.Deprecated('Use submitAddAuthorityResponseDescriptor instead')
const SubmitAddAuthorityResponse$json = {
  '1': 'SubmitAddAuthorityResponse',
  '2': [
    {
      '1': 'transaction_signature',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'transactionSignature'
    },
    {'1': 'role_id', '3': 2, '4': 1, '5': 13, '10': 'roleId'},
    {'1': 'fees_paid_by', '3': 3, '4': 1, '5': 9, '10': 'feesPaidBy'},
    {'1': 'actual_fee', '3': 4, '4': 1, '5': 4, '10': 'actualFee'},
  ],
};

/// Descriptor for `SubmitAddAuthorityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitAddAuthorityResponseDescriptor = $convert.base64Decode(
    'ChpTdWJtaXRBZGRBdXRob3JpdHlSZXNwb25zZRIzChV0cmFuc2FjdGlvbl9zaWduYXR1cmUYAS'
    'ABKAlSFHRyYW5zYWN0aW9uU2lnbmF0dXJlEhcKB3JvbGVfaWQYAiABKA1SBnJvbGVJZBIgCgxm'
    'ZWVzX3BhaWRfYnkYAyABKAlSCmZlZXNQYWlkQnkSHQoKYWN0dWFsX2ZlZRgEIAEoBFIJYWN0dW'
    'FsRmVl');

@$core.Deprecated('Use getWalletAuthoritiesRequestDescriptor instead')
const GetWalletAuthoritiesRequest$json = {
  '1': 'GetWalletAuthoritiesRequest',
  '2': [
    {
      '1': 'swig_wallet_address',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
  ],
};

/// Descriptor for `GetWalletAuthoritiesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletAuthoritiesRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRXYWxsZXRBdXRob3JpdGllc1JlcXVlc3QSLgoTc3dpZ193YWxsZXRfYWRkcmVzcxgBIA'
        'EoCVIRc3dpZ1dhbGxldEFkZHJlc3M=');

@$core.Deprecated('Use getWalletAuthoritiesResponseDescriptor instead')
const GetWalletAuthoritiesResponse$json = {
  '1': 'GetWalletAuthoritiesResponse',
  '2': [
    {
      '1': 'authorities',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.espressocash.api.swig.v1.SWIGAuthority',
      '10': 'authorities'
    },
    {
      '1': 'wallet_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.swig.v1.SWIGWalletInfo',
      '10': 'walletInfo'
    },
  ],
};

/// Descriptor for `GetWalletAuthoritiesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletAuthoritiesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRXYWxsZXRBdXRob3JpdGllc1Jlc3BvbnNlEkkKC2F1dGhvcml0aWVzGAEgAygLMicuZX'
    'NwcmVzc29jYXNoLmFwaS5zd2lnLnYxLlNXSUdBdXRob3JpdHlSC2F1dGhvcml0aWVzEkkKC3dh'
    'bGxldF9pbmZvGAIgASgLMiguZXNwcmVzc29jYXNoLmFwaS5zd2lnLnYxLlNXSUdXYWxsZXRJbm'
    'ZvUgp3YWxsZXRJbmZv');

@$core.Deprecated('Use sWIGAuthorityDescriptor instead')
const SWIGAuthority$json = {
  '1': 'SWIGAuthority',
  '2': [
    {'1': 'role_id', '3': 1, '4': 1, '5': 13, '10': 'roleId'},
    {
      '1': 'authority_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.swig.v1.AuthorityType',
      '10': 'authorityType'
    },
    {
      '1': 'authority_public_key',
      '3': 3,
      '4': 1,
      '5': 12,
      '10': 'authorityPublicKey'
    },
    {
      '1': 'permissions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.espressocash.api.swig.v1.PermissionAction',
      '10': 'permissions'
    },
  ],
};

/// Descriptor for `SWIGAuthority`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sWIGAuthorityDescriptor = $convert.base64Decode(
    'Cg1TV0lHQXV0aG9yaXR5EhcKB3JvbGVfaWQYASABKA1SBnJvbGVJZBJOCg5hdXRob3JpdHlfdH'
    'lwZRgCIAEoDjInLmVzcHJlc3NvY2FzaC5hcGkuc3dpZy52MS5BdXRob3JpdHlUeXBlUg1hdXRo'
    'b3JpdHlUeXBlEjAKFGF1dGhvcml0eV9wdWJsaWNfa2V5GAMgASgMUhJhdXRob3JpdHlQdWJsaW'
    'NLZXkSTAoLcGVybWlzc2lvbnMYBCADKAsyKi5lc3ByZXNzb2Nhc2guYXBpLnN3aWcudjEuUGVy'
    'bWlzc2lvbkFjdGlvblILcGVybWlzc2lvbnM=');

@$core.Deprecated('Use sWIGWalletInfoDescriptor instead')
const SWIGWalletInfo$json = {
  '1': 'SWIGWalletInfo',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 12, '10': 'walletId'},
    {'1': 'total_roles', '3': 2, '4': 1, '5': 13, '10': 'totalRoles'},
    {'1': 'role_counter', '3': 3, '4': 1, '5': 13, '10': 'roleCounter'},
    {
      '1': 'reserved_lamports',
      '3': 4,
      '4': 1,
      '5': 4,
      '10': 'reservedLamports'
    },
  ],
};

/// Descriptor for `SWIGWalletInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sWIGWalletInfoDescriptor = $convert.base64Decode(
    'Cg5TV0lHV2FsbGV0SW5mbxIbCgl3YWxsZXRfaWQYASABKAxSCHdhbGxldElkEh8KC3RvdGFsX3'
    'JvbGVzGAIgASgNUgp0b3RhbFJvbGVzEiEKDHJvbGVfY291bnRlchgDIAEoDVILcm9sZUNvdW50'
    'ZXISKwoRcmVzZXJ2ZWRfbGFtcG9ydHMYBCABKARSEHJlc2VydmVkTGFtcG9ydHM=');

@$core.Deprecated('Use prepareSignV1RequestDescriptor instead')
const PrepareSignV1Request$json = {
  '1': 'PrepareSignV1Request',
  '2': [
    {
      '1': 'swig_wallet_address',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
    {'1': 'signing_role_id', '3': 2, '4': 1, '5': 13, '10': 'signingRoleId'},
    {
      '1': 'wrapped_instructions',
      '3': 3,
      '4': 3,
      '5': 12,
      '10': 'wrappedInstructions'
    },
  ],
};

/// Descriptor for `PrepareSignV1Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List prepareSignV1RequestDescriptor = $convert.base64Decode(
    'ChRQcmVwYXJlU2lnblYxUmVxdWVzdBIuChNzd2lnX3dhbGxldF9hZGRyZXNzGAEgASgJUhFzd2'
    'lnV2FsbGV0QWRkcmVzcxImCg9zaWduaW5nX3JvbGVfaWQYAiABKA1SDXNpZ25pbmdSb2xlSWQS'
    'MQoUd3JhcHBlZF9pbnN0cnVjdGlvbnMYAyADKAxSE3dyYXBwZWRJbnN0cnVjdGlvbnM=');

@$core.Deprecated('Use prepareSignV1ResponseDescriptor instead')
const PrepareSignV1Response$json = {
  '1': 'PrepareSignV1Response',
  '2': [
    {
      '1': 'unsigned_transaction',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'unsignedTransaction'
    },
    {'1': 'authority_type', '3': 2, '4': 1, '5': 9, '10': 'authorityType'},
    {'1': 'estimated_fee', '3': 3, '4': 1, '5': 4, '10': 'estimatedFee'},
    {'1': 'slot', '3': 4, '4': 1, '5': 4, '10': 'slot'},
    {'1': 'expected_counter', '3': 5, '4': 1, '5': 13, '10': 'expectedCounter'},
    {'1': 'message_hash', '3': 6, '4': 1, '5': 12, '10': 'messageHash'},
  ],
};

/// Descriptor for `PrepareSignV1Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List prepareSignV1ResponseDescriptor = $convert.base64Decode(
    'ChVQcmVwYXJlU2lnblYxUmVzcG9uc2USMQoUdW5zaWduZWRfdHJhbnNhY3Rpb24YASABKAxSE3'
    'Vuc2lnbmVkVHJhbnNhY3Rpb24SJQoOYXV0aG9yaXR5X3R5cGUYAiABKAlSDWF1dGhvcml0eVR5'
    'cGUSIwoNZXN0aW1hdGVkX2ZlZRgDIAEoBFIMZXN0aW1hdGVkRmVlEhIKBHNsb3QYBCABKARSBH'
    'Nsb3QSKQoQZXhwZWN0ZWRfY291bnRlchgFIAEoDVIPZXhwZWN0ZWRDb3VudGVyEiEKDG1lc3Nh'
    'Z2VfaGFzaBgGIAEoDFILbWVzc2FnZUhhc2g=');

@$core.Deprecated('Use submitSignV1RequestDescriptor instead')
const SubmitSignV1Request$json = {
  '1': 'SubmitSignV1Request',
  '2': [
    {
      '1': 'signing_result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.swig.v1.SigningResult',
      '10': 'signingResult'
    },
    {
      '1': 'swig_wallet_address',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'swigWalletAddress'
    },
    {'1': 'signing_role_id', '3': 3, '4': 1, '5': 13, '10': 'signingRoleId'},
    {
      '1': 'wrapped_instructions',
      '3': 4,
      '4': 3,
      '5': 12,
      '10': 'wrappedInstructions'
    },
    {'1': 'slot', '3': 5, '4': 1, '5': 4, '10': 'slot'},
    {'1': 'expected_counter', '3': 6, '4': 1, '5': 13, '10': 'expectedCounter'},
    {
      '1': 'unsigned_transaction',
      '3': 7,
      '4': 1,
      '5': 12,
      '10': 'unsignedTransaction'
    },
    {
      '1': 'authenticator_data',
      '3': 8,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'authenticatorData',
      '17': true
    },
    {
      '1': 'client_data_json',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'clientDataJson',
      '17': true
    },
  ],
  '8': [
    {'1': '_authenticator_data'},
    {'1': '_client_data_json'},
  ],
};

/// Descriptor for `SubmitSignV1Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitSignV1RequestDescriptor = $convert.base64Decode(
    'ChNTdWJtaXRTaWduVjFSZXF1ZXN0Ek4KDnNpZ25pbmdfcmVzdWx0GAEgASgLMicuZXNwcmVzc2'
    '9jYXNoLmFwaS5zd2lnLnYxLlNpZ25pbmdSZXN1bHRSDXNpZ25pbmdSZXN1bHQSLgoTc3dpZ193'
    'YWxsZXRfYWRkcmVzcxgCIAEoCVIRc3dpZ1dhbGxldEFkZHJlc3MSJgoPc2lnbmluZ19yb2xlX2'
    'lkGAMgASgNUg1zaWduaW5nUm9sZUlkEjEKFHdyYXBwZWRfaW5zdHJ1Y3Rpb25zGAQgAygMUhN3'
    'cmFwcGVkSW5zdHJ1Y3Rpb25zEhIKBHNsb3QYBSABKARSBHNsb3QSKQoQZXhwZWN0ZWRfY291bn'
    'RlchgGIAEoDVIPZXhwZWN0ZWRDb3VudGVyEjEKFHVuc2lnbmVkX3RyYW5zYWN0aW9uGAcgASgM'
    'UhN1bnNpZ25lZFRyYW5zYWN0aW9uEjIKEmF1dGhlbnRpY2F0b3JfZGF0YRgIIAEoDEgAUhFhdX'
    'RoZW50aWNhdG9yRGF0YYgBARItChBjbGllbnRfZGF0YV9qc29uGAkgASgJSAFSDmNsaWVudERh'
    'dGFKc29uiAEBQhUKE19hdXRoZW50aWNhdG9yX2RhdGFCEwoRX2NsaWVudF9kYXRhX2pzb24=');

@$core.Deprecated('Use submitSignV1ResponseDescriptor instead')
const SubmitSignV1Response$json = {
  '1': 'SubmitSignV1Response',
  '2': [
    {
      '1': 'transaction_signature',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'transactionSignature'
    },
    {'1': 'fees_paid_by', '3': 2, '4': 1, '5': 9, '10': 'feesPaidBy'},
    {'1': 'actual_fee', '3': 3, '4': 1, '5': 4, '10': 'actualFee'},
  ],
};

/// Descriptor for `SubmitSignV1Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitSignV1ResponseDescriptor = $convert.base64Decode(
    'ChRTdWJtaXRTaWduVjFSZXNwb25zZRIzChV0cmFuc2FjdGlvbl9zaWduYXR1cmUYASABKAlSFH'
    'RyYW5zYWN0aW9uU2lnbmF0dXJlEiAKDGZlZXNfcGFpZF9ieRgCIAEoCVIKZmVlc1BhaWRCeRId'
    'CgphY3R1YWxfZmVlGAMgASgEUglhY3R1YWxGZWU=');

const $core.Map<$core.String, $core.dynamic> SWIGServiceBase$json = {
  '1': 'SWIGService',
  '2': [
    {
      '1': 'CreateWallet',
      '2': '.espressocash.api.swig.v1.CreateWalletRequest',
      '3': '.espressocash.api.swig.v1.CreateWalletResponse'
    },
    {
      '1': 'PrepareAddAuthority',
      '2': '.espressocash.api.swig.v1.PrepareAddAuthorityRequest',
      '3': '.espressocash.api.swig.v1.PrepareAddAuthorityResponse'
    },
    {
      '1': 'SubmitAddAuthority',
      '2': '.espressocash.api.swig.v1.SubmitAddAuthorityRequest',
      '3': '.espressocash.api.swig.v1.SubmitAddAuthorityResponse'
    },
    {
      '1': 'GetWalletAuthorities',
      '2': '.espressocash.api.swig.v1.GetWalletAuthoritiesRequest',
      '3': '.espressocash.api.swig.v1.GetWalletAuthoritiesResponse'
    },
    {
      '1': 'PrepareSignV1',
      '2': '.espressocash.api.swig.v1.PrepareSignV1Request',
      '3': '.espressocash.api.swig.v1.PrepareSignV1Response'
    },
    {
      '1': 'SubmitSignV1',
      '2': '.espressocash.api.swig.v1.SubmitSignV1Request',
      '3': '.espressocash.api.swig.v1.SubmitSignV1Response'
    },
  ],
};

@$core.Deprecated('Use sWIGServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SWIGServiceBase$messageJson = {
  '.espressocash.api.swig.v1.CreateWalletRequest': CreateWalletRequest$json,
  '.espressocash.api.swig.v1.CreateWalletResponse': CreateWalletResponse$json,
  '.espressocash.api.swig.v1.PrepareAddAuthorityRequest':
      PrepareAddAuthorityRequest$json,
  '.espressocash.api.swig.v1.AuthorityInfo': AuthorityInfo$json,
  '.espressocash.api.swig.v1.PermissionAction': PermissionAction$json,
  '.espressocash.api.swig.v1.PrepareAddAuthorityResponse':
      PrepareAddAuthorityResponse$json,
  '.espressocash.api.swig.v1.SubmitAddAuthorityRequest':
      SubmitAddAuthorityRequest$json,
  '.espressocash.api.swig.v1.SigningResult': SigningResult$json,
  '.espressocash.api.swig.v1.SubmitAddAuthorityResponse':
      SubmitAddAuthorityResponse$json,
  '.espressocash.api.swig.v1.GetWalletAuthoritiesRequest':
      GetWalletAuthoritiesRequest$json,
  '.espressocash.api.swig.v1.GetWalletAuthoritiesResponse':
      GetWalletAuthoritiesResponse$json,
  '.espressocash.api.swig.v1.SWIGAuthority': SWIGAuthority$json,
  '.espressocash.api.swig.v1.SWIGWalletInfo': SWIGWalletInfo$json,
  '.espressocash.api.swig.v1.PrepareSignV1Request': PrepareSignV1Request$json,
  '.espressocash.api.swig.v1.PrepareSignV1Response': PrepareSignV1Response$json,
  '.espressocash.api.swig.v1.SubmitSignV1Request': SubmitSignV1Request$json,
  '.espressocash.api.swig.v1.SubmitSignV1Response': SubmitSignV1Response$json,
};

/// Descriptor for `SWIGService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List sWIGServiceDescriptor = $convert.base64Decode(
    'CgtTV0lHU2VydmljZRJtCgxDcmVhdGVXYWxsZXQSLS5lc3ByZXNzb2Nhc2guYXBpLnN3aWcudj'
    'EuQ3JlYXRlV2FsbGV0UmVxdWVzdBouLmVzcHJlc3NvY2FzaC5hcGkuc3dpZy52MS5DcmVhdGVX'
    'YWxsZXRSZXNwb25zZRKCAQoTUHJlcGFyZUFkZEF1dGhvcml0eRI0LmVzcHJlc3NvY2FzaC5hcG'
    'kuc3dpZy52MS5QcmVwYXJlQWRkQXV0aG9yaXR5UmVxdWVzdBo1LmVzcHJlc3NvY2FzaC5hcGku'
    'c3dpZy52MS5QcmVwYXJlQWRkQXV0aG9yaXR5UmVzcG9uc2USfwoSU3VibWl0QWRkQXV0aG9yaX'
    'R5EjMuZXNwcmVzc29jYXNoLmFwaS5zd2lnLnYxLlN1Ym1pdEFkZEF1dGhvcml0eVJlcXVlc3Qa'
    'NC5lc3ByZXNzb2Nhc2guYXBpLnN3aWcudjEuU3VibWl0QWRkQXV0aG9yaXR5UmVzcG9uc2UShQ'
    'EKFEdldFdhbGxldEF1dGhvcml0aWVzEjUuZXNwcmVzc29jYXNoLmFwaS5zd2lnLnYxLkdldFdh'
    'bGxldEF1dGhvcml0aWVzUmVxdWVzdBo2LmVzcHJlc3NvY2FzaC5hcGkuc3dpZy52MS5HZXRXYW'
    'xsZXRBdXRob3JpdGllc1Jlc3BvbnNlEnAKDVByZXBhcmVTaWduVjESLi5lc3ByZXNzb2Nhc2gu'
    'YXBpLnN3aWcudjEuUHJlcGFyZVNpZ25WMVJlcXVlc3QaLy5lc3ByZXNzb2Nhc2guYXBpLnN3aW'
    'cudjEuUHJlcGFyZVNpZ25WMVJlc3BvbnNlEm0KDFN1Ym1pdFNpZ25WMRItLmVzcHJlc3NvY2Fz'
    'aC5hcGkuc3dpZy52MS5TdWJtaXRTaWduVjFSZXF1ZXN0Gi4uZXNwcmVzc29jYXNoLmFwaS5zd2'
    'lnLnYxLlN1Ym1pdFNpZ25WMVJlc3BvbnNl');
