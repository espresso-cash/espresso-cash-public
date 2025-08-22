// This is a generated file - do not edit.
//
// Generated from espressocash/api/users/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'signer_address', '3': 1, '4': 1, '5': 9, '10': 'signerAddress'},
    {'1': 'wallet_address', '3': 2, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'proof_signature', '3': 3, '4': 1, '5': 9, '10': 'proofSignature'},
    {'1': 'proof_message', '3': 4, '4': 1, '5': 9, '10': 'proofMessage'},
    {'1': 'type_of_signer', '3': 5, '4': 1, '5': 9, '10': 'typeOfSigner'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSJQoOc2lnbmVyX2FkZHJlc3MYASABKAlSDXNpZ25lckFkZHJlc3MSJQ'
    'oOd2FsbGV0X2FkZHJlc3MYAiABKAlSDXdhbGxldEFkZHJlc3MSJwoPcHJvb2Zfc2lnbmF0dXJl'
    'GAMgASgJUg5wcm9vZlNpZ25hdHVyZRIjCg1wcm9vZl9tZXNzYWdlGAQgASgJUgxwcm9vZk1lc3'
    'NhZ2USJAoOdHlwZV9vZl9zaWduZXIYBSABKAlSDHR5cGVPZlNpZ25lcg==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert
    .base64Decode('Cg1Mb2dpblJlc3BvbnNlEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use getWalletProofMessageRequestDescriptor instead')
const GetWalletProofMessageRequest$json = {
  '1': 'GetWalletProofMessageRequest',
  '2': [
    {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
  ],
};

/// Descriptor for `GetWalletProofMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletProofMessageRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRXYWxsZXRQcm9vZk1lc3NhZ2VSZXF1ZXN0EiUKDndhbGxldF9hZGRyZXNzGAEgASgJUg'
        '13YWxsZXRBZGRyZXNz');

@$core.Deprecated('Use getWalletProofMessageResponseDescriptor instead')
const GetWalletProofMessageResponse$json = {
  '1': 'GetWalletProofMessageResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetWalletProofMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletProofMessageResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRXYWxsZXRQcm9vZk1lc3NhZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use updateCountryRequestDescriptor instead')
const UpdateCountryRequest$json = {
  '1': 'UpdateCountryRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `UpdateCountryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCountryRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVDb3VudHJ5UmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cnlDb2'
    'Rl');

@$core.Deprecated('Use updateCountryResponseDescriptor instead')
const UpdateCountryResponse$json = {
  '1': 'UpdateCountryResponse',
};

/// Descriptor for `UpdateCountryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCountryResponseDescriptor =
    $convert.base64Decode('ChVVcGRhdGVDb3VudHJ5UmVzcG9uc2U=');

const $core.Map<$core.String, $core.dynamic> UserServiceBase$json = {
  '1': 'UserService',
  '2': [
    {
      '1': 'Login',
      '2': '.espressocash.api.users.v1.LoginRequest',
      '3': '.espressocash.api.users.v1.LoginResponse'
    },
    {
      '1': 'GetWalletProofMessage',
      '2': '.espressocash.api.users.v1.GetWalletProofMessageRequest',
      '3': '.espressocash.api.users.v1.GetWalletProofMessageResponse'
    },
    {
      '1': 'UpdateCountry',
      '2': '.espressocash.api.users.v1.UpdateCountryRequest',
      '3': '.espressocash.api.users.v1.UpdateCountryResponse'
    },
  ],
};

@$core.Deprecated('Use userServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UserServiceBase$messageJson = {
  '.espressocash.api.users.v1.LoginRequest': LoginRequest$json,
  '.espressocash.api.users.v1.LoginResponse': LoginResponse$json,
  '.espressocash.api.users.v1.GetWalletProofMessageRequest':
      GetWalletProofMessageRequest$json,
  '.espressocash.api.users.v1.GetWalletProofMessageResponse':
      GetWalletProofMessageResponse$json,
  '.espressocash.api.users.v1.UpdateCountryRequest': UpdateCountryRequest$json,
  '.espressocash.api.users.v1.UpdateCountryResponse':
      UpdateCountryResponse$json,
};

/// Descriptor for `UserService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List userServiceDescriptor = $convert.base64Decode(
    'CgtVc2VyU2VydmljZRJaCgVMb2dpbhInLmVzcHJlc3NvY2FzaC5hcGkudXNlcnMudjEuTG9naW'
    '5SZXF1ZXN0GiguZXNwcmVzc29jYXNoLmFwaS51c2Vycy52MS5Mb2dpblJlc3BvbnNlEooBChVH'
    'ZXRXYWxsZXRQcm9vZk1lc3NhZ2USNy5lc3ByZXNzb2Nhc2guYXBpLnVzZXJzLnYxLkdldFdhbG'
    'xldFByb29mTWVzc2FnZVJlcXVlc3QaOC5lc3ByZXNzb2Nhc2guYXBpLnVzZXJzLnYxLkdldFdh'
    'bGxldFByb29mTWVzc2FnZVJlc3BvbnNlEnIKDVVwZGF0ZUNvdW50cnkSLy5lc3ByZXNzb2Nhc2'
    'guYXBpLnVzZXJzLnYxLlVwZGF0ZUNvdW50cnlSZXF1ZXN0GjAuZXNwcmVzc29jYXNoLmFwaS51'
    'c2Vycy52MS5VcGRhdGVDb3VudHJ5UmVzcG9uc2U=');
