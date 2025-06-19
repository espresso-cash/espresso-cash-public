//
//  Generated code. Do not modify.
//  source: api/tokens/v1/service.proto
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
final $typed_data.Uint8List getTokensMetaResponseDescriptor =
    $convert.base64Decode('ChVHZXRUb2tlbnNNZXRhUmVzcG9uc2USEAoDbWQ1GAEgASgJUgNtZDU=');

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
    $convert.base64Decode('ChVHZXRUb2tlbnNGaWxlUmVzcG9uc2USGAoHY29udGVudBgBIAEoDFIHY29udGVudA==');
