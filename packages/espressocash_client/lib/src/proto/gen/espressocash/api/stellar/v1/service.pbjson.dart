// This is a generated file - do not edit.
//
// Generated from espressocash/api/stellar/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use submitTransactionRequestDescriptor instead')
const SubmitTransactionRequest$json = {
  '1': 'SubmitTransactionRequest',
  '2': [
    {'1': 'xdr_transaction', '3': 1, '4': 1, '5': 9, '10': 'xdrTransaction'},
  ],
};

/// Descriptor for `SubmitTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionRequestDescriptor =
    $convert.base64Decode(
        'ChhTdWJtaXRUcmFuc2FjdGlvblJlcXVlc3QSJwoPeGRyX3RyYW5zYWN0aW9uGAEgASgJUg54ZH'
        'JUcmFuc2FjdGlvbg==');

@$core.Deprecated('Use submitTransactionResponseDescriptor instead')
const SubmitTransactionResponse$json = {
  '1': 'SubmitTransactionResponse',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '10': 'hash'},
    {'1': 'successful', '3': 2, '4': 1, '5': 8, '10': 'successful'},
    {'1': 'ledger', '3': 3, '4': 1, '5': 3, '10': 'ledger'},
    {'1': 'result_xdr', '3': 4, '4': 1, '5': 9, '10': 'resultXdr'},
    {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SubmitTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitTransactionResponseDescriptor = $convert.base64Decode(
    'ChlTdWJtaXRUcmFuc2FjdGlvblJlc3BvbnNlEhIKBGhhc2gYASABKAlSBGhhc2gSHgoKc3VjY2'
    'Vzc2Z1bBgCIAEoCFIKc3VjY2Vzc2Z1bBIWCgZsZWRnZXIYAyABKANSBmxlZGdlchIdCgpyZXN1'
    'bHRfeGRyGAQgASgJUglyZXN1bHRYZHISFAoFZXJyb3IYBSABKAlSBWVycm9y');

@$core.Deprecated('Use getTransactionRequestDescriptor instead')
const GetTransactionRequest$json = {
  '1': 'GetTransactionRequest',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '10': 'hash'},
  ],
};

/// Descriptor for `GetTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRUcmFuc2FjdGlvblJlcXVlc3QSEgoEaGFzaBgBIAEoCVIEaGFzaA==');

@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse$json = {
  '1': 'GetTransactionResponse',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '10': 'hash'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'ledger', '3': 3, '4': 1, '5': 3, '10': 'ledger'},
    {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `GetTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionResponseDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2FjdGlvblJlc3BvbnNlEhIKBGhhc2gYASABKAlSBGhhc2gSFgoGc3RhdHVzGA'
    'IgASgJUgZzdGF0dXMSFgoGbGVkZ2VyGAMgASgDUgZsZWRnZXISFAoFZXJyb3IYBCABKAlSBWVy'
    'cm9y');

const $core.Map<$core.String, $core.dynamic> StellarServiceBase$json = {
  '1': 'StellarService',
  '2': [
    {
      '1': 'SubmitTransaction',
      '2': '.espressocash.api.stellar.v1.SubmitTransactionRequest',
      '3': '.espressocash.api.stellar.v1.SubmitTransactionResponse'
    },
    {
      '1': 'GetTransaction',
      '2': '.espressocash.api.stellar.v1.GetTransactionRequest',
      '3': '.espressocash.api.stellar.v1.GetTransactionResponse'
    },
  ],
};

@$core.Deprecated('Use stellarServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    StellarServiceBase$messageJson = {
  '.espressocash.api.stellar.v1.SubmitTransactionRequest':
      SubmitTransactionRequest$json,
  '.espressocash.api.stellar.v1.SubmitTransactionResponse':
      SubmitTransactionResponse$json,
  '.espressocash.api.stellar.v1.GetTransactionRequest':
      GetTransactionRequest$json,
  '.espressocash.api.stellar.v1.GetTransactionResponse':
      GetTransactionResponse$json,
};

/// Descriptor for `StellarService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List stellarServiceDescriptor = $convert.base64Decode(
    'Cg5TdGVsbGFyU2VydmljZRKCAQoRU3VibWl0VHJhbnNhY3Rpb24SNS5lc3ByZXNzb2Nhc2guYX'
    'BpLnN0ZWxsYXIudjEuU3VibWl0VHJhbnNhY3Rpb25SZXF1ZXN0GjYuZXNwcmVzc29jYXNoLmFw'
    'aS5zdGVsbGFyLnYxLlN1Ym1pdFRyYW5zYWN0aW9uUmVzcG9uc2USeQoOR2V0VHJhbnNhY3Rpb2'
    '4SMi5lc3ByZXNzb2Nhc2guYXBpLnN0ZWxsYXIudjEuR2V0VHJhbnNhY3Rpb25SZXF1ZXN0GjMu'
    'ZXNwcmVzc29jYXNoLmFwaS5zdGVsbGFyLnYxLkdldFRyYW5zYWN0aW9uUmVzcG9uc2U=');
