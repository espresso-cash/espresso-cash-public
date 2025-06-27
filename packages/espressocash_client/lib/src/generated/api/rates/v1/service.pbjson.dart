//
//  Generated code. Do not modify.
//  source: api/rates/v1/service.proto
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

@$core.Deprecated('Use getRatesRequestDescriptor instead')
const GetRatesRequest$json = {
  '1': 'GetRatesRequest',
};

/// Descriptor for `GetRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRatesRequestDescriptor =
    $convert.base64Decode('Cg9HZXRSYXRlc1JlcXVlc3Q=');

@$core.Deprecated('Use getRatesResponseDescriptor instead')
const GetRatesResponse$json = {
  '1': 'GetRatesResponse',
  '2': [
    {'1': 'usdc', '3': 1, '4': 1, '5': 2, '10': 'usdc'},
  ],
};

/// Descriptor for `GetRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRatesResponseDescriptor =
    $convert.base64Decode('ChBHZXRSYXRlc1Jlc3BvbnNlEhIKBHVzZGMYASABKAJSBHVzZGM=');

@$core.Deprecated('Use getFiatRatesRequestDescriptor instead')
const GetFiatRatesRequest$json = {
  '1': 'GetFiatRatesRequest',
  '2': [
    {'1': 'base', '3': 1, '4': 1, '5': 9, '10': 'base'},
    {'1': 'target', '3': 2, '4': 1, '5': 9, '10': 'target'},
  ],
};

/// Descriptor for `GetFiatRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFiatRatesRequestDescriptor = $convert
    .base64Decode('ChNHZXRGaWF0UmF0ZXNSZXF1ZXN0EhIKBGJhc2UYASABKAlSBGJhc2USFgoGdGFyZ2V0GAIgAS'
        'gJUgZ0YXJnZXQ=');

@$core.Deprecated('Use getFiatRatesResponseDescriptor instead')
const GetFiatRatesResponse$json = {
  '1': 'GetFiatRatesResponse',
  '2': [
    {'1': 'rate', '3': 1, '4': 1, '5': 2, '10': 'rate'},
  ],
};

/// Descriptor for `GetFiatRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFiatRatesResponseDescriptor =
    $convert.base64Decode('ChRHZXRGaWF0UmF0ZXNSZXNwb25zZRISCgRyYXRlGAEgASgCUgRyYXRl');
