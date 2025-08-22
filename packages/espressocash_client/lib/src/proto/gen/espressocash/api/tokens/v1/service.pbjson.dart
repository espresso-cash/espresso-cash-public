// This is a generated file - do not edit.
//
// Generated from espressocash/api/tokens/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getTokensMetaRequestDescriptor instead')
const GetTokensMetaRequest$json = {
  '1': 'GetTokensMetaRequest',
};

/// Descriptor for `GetTokensMetaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTokensMetaRequestDescriptor =
    $convert.base64Decode('ChRHZXRUb2tlbnNNZXRhUmVxdWVzdA==');

@$core.Deprecated('Use getTokensMetaResponseDescriptor instead')
const GetTokensMetaResponse$json = {
  '1': 'GetTokensMetaResponse',
  '2': [
    {'1': 'md5', '3': 1, '4': 1, '5': 9, '10': 'md5'},
  ],
};

/// Descriptor for `GetTokensMetaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTokensMetaResponseDescriptor = $convert
    .base64Decode('ChVHZXRUb2tlbnNNZXRhUmVzcG9uc2USEAoDbWQ1GAEgASgJUgNtZDU=');

@$core.Deprecated('Use getTokensFileRequestDescriptor instead')
const GetTokensFileRequest$json = {
  '1': 'GetTokensFileRequest',
};

/// Descriptor for `GetTokensFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTokensFileRequestDescriptor =
    $convert.base64Decode('ChRHZXRUb2tlbnNGaWxlUmVxdWVzdA==');

@$core.Deprecated('Use getTokensFileResponseDescriptor instead')
const GetTokensFileResponse$json = {
  '1': 'GetTokensFileResponse',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 12, '10': 'content'},
  ],
};

/// Descriptor for `GetTokensFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTokensFileResponseDescriptor =
    $convert.base64Decode(
        'ChVHZXRUb2tlbnNGaWxlUmVzcG9uc2USGAoHY29udGVudBgBIAEoDFIHY29udGVudA==');

const $core.Map<$core.String, $core.dynamic> TokensServiceBase$json = {
  '1': 'TokensService',
  '2': [
    {
      '1': 'GetTokensMeta',
      '2': '.espressocash.api.tokens.v1.GetTokensMetaRequest',
      '3': '.espressocash.api.tokens.v1.GetTokensMetaResponse'
    },
    {
      '1': 'GetTokensFile',
      '2': '.espressocash.api.tokens.v1.GetTokensFileRequest',
      '3': '.espressocash.api.tokens.v1.GetTokensFileResponse'
    },
  ],
};

@$core.Deprecated('Use tokensServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TokensServiceBase$messageJson = {
  '.espressocash.api.tokens.v1.GetTokensMetaRequest': GetTokensMetaRequest$json,
  '.espressocash.api.tokens.v1.GetTokensMetaResponse':
      GetTokensMetaResponse$json,
  '.espressocash.api.tokens.v1.GetTokensFileRequest': GetTokensFileRequest$json,
  '.espressocash.api.tokens.v1.GetTokensFileResponse':
      GetTokensFileResponse$json,
};

/// Descriptor for `TokensService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List tokensServiceDescriptor = $convert.base64Decode(
    'Cg1Ub2tlbnNTZXJ2aWNlEnQKDUdldFRva2Vuc01ldGESMC5lc3ByZXNzb2Nhc2guYXBpLnRva2'
    'Vucy52MS5HZXRUb2tlbnNNZXRhUmVxdWVzdBoxLmVzcHJlc3NvY2FzaC5hcGkudG9rZW5zLnYx'
    'LkdldFRva2Vuc01ldGFSZXNwb25zZRJ0Cg1HZXRUb2tlbnNGaWxlEjAuZXNwcmVzc29jYXNoLm'
    'FwaS50b2tlbnMudjEuR2V0VG9rZW5zRmlsZVJlcXVlc3QaMS5lc3ByZXNzb2Nhc2guYXBpLnRv'
    'a2Vucy52MS5HZXRUb2tlbnNGaWxlUmVzcG9uc2U=');
