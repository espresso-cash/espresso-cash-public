//
//  Generated code. Do not modify.
//  source: api/users/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'proof_signature', '3': 2, '4': 1, '5': 9, '10': 'proofSignature'},
    {'1': 'proof_message', '3': 3, '4': 1, '5': 9, '10': 'proofMessage'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert
    .base64Decode('CgxMb2dpblJlcXVlc3QSJQoOd2FsbGV0X2FkZHJlc3MYASABKAlSDXdhbGxldEFkZHJlc3MSJw'
        'oPcHJvb2Zfc2lnbmF0dXJlGAIgASgJUg5wcm9vZlNpZ25hdHVyZRIjCg1wcm9vZl9tZXNzYWdl'
        'GAMgASgJUgxwcm9vZk1lc3NhZ2U=');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor =
    $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use getWalletProofMessageRequestDescriptor instead')
const GetWalletProofMessageRequest$json = {
  '1': 'GetWalletProofMessageRequest',
  '2': [
    {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
  ],
};

/// Descriptor for `GetWalletProofMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletProofMessageRequestDescriptor = $convert
    .base64Decode('ChxHZXRXYWxsZXRQcm9vZk1lc3NhZ2VSZXF1ZXN0EiUKDndhbGxldF9hZGRyZXNzGAEgASgJUg'
        '13YWxsZXRBZGRyZXNz');

@$core.Deprecated('Use getWalletProofMessageResponseDescriptor instead')
const GetWalletProofMessageResponse$json = {
  '1': 'GetWalletProofMessageResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetWalletProofMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletProofMessageResponseDescriptor = $convert
    .base64Decode('Ch1HZXRXYWxsZXRQcm9vZk1lc3NhZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use updateCountryRequestDescriptor instead')
const UpdateCountryRequest$json = {
  '1': 'UpdateCountryRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `UpdateCountryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCountryRequestDescriptor = $convert
    .base64Decode('ChRVcGRhdGVDb3VudHJ5UmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cnlDb2'
        'Rl');

@$core.Deprecated('Use updateCountryResponseDescriptor instead')
const UpdateCountryResponse$json = {
  '1': 'UpdateCountryResponse',
};

/// Descriptor for `UpdateCountryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCountryResponseDescriptor =
    $convert.base64Decode('ChVVcGRhdGVDb3VudHJ5UmVzcG9uc2U=');
