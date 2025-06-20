//
//  Generated code. Do not modify.
//  source: api/referrals/v1/service.proto
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

@$core.Deprecated('Use addReferralRequestDescriptor instead')
const AddReferralRequest$json = {
  '1': 'AddReferralRequest',
  '2': [
    {'1': 'ambassador_address', '3': 1, '4': 1, '5': 9, '10': 'ambassadorAddress'},
  ],
};

/// Descriptor for `AddReferralRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addReferralRequestDescriptor = $convert
    .base64Decode('ChJBZGRSZWZlcnJhbFJlcXVlc3QSLQoSYW1iYXNzYWRvcl9hZGRyZXNzGAEgASgJUhFhbWJhc3'
        'NhZG9yQWRkcmVzcw==');

@$core.Deprecated('Use addReferralResponseDescriptor instead')
const AddReferralResponse$json = {
  '1': 'AddReferralResponse',
};

/// Descriptor for `AddReferralResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addReferralResponseDescriptor =
    $convert.base64Decode('ChNBZGRSZWZlcnJhbFJlc3BvbnNl');

@$core.Deprecated('Use getStatsRequestDescriptor instead')
const GetStatsRequest$json = {
  '1': 'GetStatsRequest',
};

/// Descriptor for `GetStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatsRequestDescriptor =
    $convert.base64Decode('Cg9HZXRTdGF0c1JlcXVlc3Q=');

@$core.Deprecated('Use getStatsResponseDescriptor instead')
const GetStatsResponse$json = {
  '1': 'GetStatsResponse',
  '2': [
    {'1': 'referral_count', '3': 1, '4': 1, '5': 5, '10': 'referralCount'},
  ],
};

/// Descriptor for `GetStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatsResponseDescriptor = $convert
    .base64Decode('ChBHZXRTdGF0c1Jlc3BvbnNlEiUKDnJlZmVycmFsX2NvdW50GAEgASgFUg1yZWZlcnJhbENvdW'
        '50');

@$core.Deprecated('Use verifyRequestDescriptor instead')
const VerifyRequest$json = {
  '1': 'VerifyRequest',
};

/// Descriptor for `VerifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyRequestDescriptor = $convert.base64Decode('Cg1WZXJpZnlSZXF1ZXN0');

@$core.Deprecated('Use verifyResponseDescriptor instead')
const VerifyResponse$json = {
  '1': 'VerifyResponse',
  '2': [
    {'1': 'is_ambassador', '3': 1, '4': 1, '5': 8, '10': 'isAmbassador'},
    {'1': 'is_referral', '3': 2, '4': 1, '5': 8, '10': 'isReferral'},
  ],
};

/// Descriptor for `VerifyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyResponseDescriptor = $convert
    .base64Decode('Cg5WZXJpZnlSZXNwb25zZRIjCg1pc19hbWJhc3NhZG9yGAEgASgIUgxpc0FtYmFzc2Fkb3ISHw'
        'oLaXNfcmVmZXJyYWwYAiABKAhSCmlzUmVmZXJyYWw=');
