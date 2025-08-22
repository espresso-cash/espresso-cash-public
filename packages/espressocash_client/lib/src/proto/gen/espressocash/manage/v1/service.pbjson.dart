// This is a generated file - do not edit.
//
// Generated from espressocash/manage/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use updateRatesRequestDescriptor instead')
const UpdateRatesRequest$json = {
  '1': 'UpdateRatesRequest',
};

/// Descriptor for `UpdateRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRatesRequestDescriptor =
    $convert.base64Decode('ChJVcGRhdGVSYXRlc1JlcXVlc3Q=');

@$core.Deprecated('Use updateRatesResponseDescriptor instead')
const UpdateRatesResponse$json = {
  '1': 'UpdateRatesResponse',
};

/// Descriptor for `UpdateRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRatesResponseDescriptor =
    $convert.base64Decode('ChNVcGRhdGVSYXRlc1Jlc3BvbnNl');

@$core.Deprecated('Use checkTransactionsRequestDescriptor instead')
const CheckTransactionsRequest$json = {
  '1': 'CheckTransactionsRequest',
};

/// Descriptor for `CheckTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTransactionsRequestDescriptor =
    $convert.base64Decode('ChhDaGVja1RyYW5zYWN0aW9uc1JlcXVlc3Q=');

@$core.Deprecated('Use checkTransactionsResponseDescriptor instead')
const CheckTransactionsResponse$json = {
  '1': 'CheckTransactionsResponse',
};

/// Descriptor for `CheckTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTransactionsResponseDescriptor =
    $convert.base64Decode('ChlDaGVja1RyYW5zYWN0aW9uc1Jlc3BvbnNl');

@$core.Deprecated('Use getPlatformAccountInfoRequestDescriptor instead')
const GetPlatformAccountInfoRequest$json = {
  '1': 'GetPlatformAccountInfoRequest',
};

/// Descriptor for `GetPlatformAccountInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformAccountInfoRequestDescriptor =
    $convert.base64Decode('Ch1HZXRQbGF0Zm9ybUFjY291bnRJbmZvUmVxdWVzdA==');

@$core.Deprecated('Use getPlatformAccountInfoResponseDescriptor instead')
const GetPlatformAccountInfoResponse$json = {
  '1': 'GetPlatformAccountInfoResponse',
  '2': [
    {'1': 'public_key', '3': 1, '4': 1, '5': 9, '10': 'publicKey'},
    {'1': 'balance', '3': 2, '4': 1, '5': 4, '10': 'balance'},
  ],
};

/// Descriptor for `GetPlatformAccountInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformAccountInfoResponseDescriptor =
    $convert.base64Decode(
        'Ch5HZXRQbGF0Zm9ybUFjY291bnRJbmZvUmVzcG9uc2USHQoKcHVibGljX2tleRgBIAEoCVIJcH'
        'VibGljS2V5EhgKB2JhbGFuY2UYAiABKARSB2JhbGFuY2U=');

const $core.Map<$core.String, $core.dynamic> ManageServiceBase$json = {
  '1': 'ManageService',
  '2': [
    {
      '1': 'UpdateRates',
      '2': '.espressocash.manage.v1.UpdateRatesRequest',
      '3': '.espressocash.manage.v1.UpdateRatesResponse'
    },
    {
      '1': 'CheckTransactions',
      '2': '.espressocash.manage.v1.CheckTransactionsRequest',
      '3': '.espressocash.manage.v1.CheckTransactionsResponse'
    },
    {
      '1': 'GetPlatformAccountInfo',
      '2': '.espressocash.manage.v1.GetPlatformAccountInfoRequest',
      '3': '.espressocash.manage.v1.GetPlatformAccountInfoResponse'
    },
  ],
};

@$core.Deprecated('Use manageServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ManageServiceBase$messageJson = {
  '.espressocash.manage.v1.UpdateRatesRequest': UpdateRatesRequest$json,
  '.espressocash.manage.v1.UpdateRatesResponse': UpdateRatesResponse$json,
  '.espressocash.manage.v1.CheckTransactionsRequest':
      CheckTransactionsRequest$json,
  '.espressocash.manage.v1.CheckTransactionsResponse':
      CheckTransactionsResponse$json,
  '.espressocash.manage.v1.GetPlatformAccountInfoRequest':
      GetPlatformAccountInfoRequest$json,
  '.espressocash.manage.v1.GetPlatformAccountInfoResponse':
      GetPlatformAccountInfoResponse$json,
};

/// Descriptor for `ManageService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List manageServiceDescriptor = $convert.base64Decode(
    'Cg1NYW5hZ2VTZXJ2aWNlEmYKC1VwZGF0ZVJhdGVzEiouZXNwcmVzc29jYXNoLm1hbmFnZS52MS'
    '5VcGRhdGVSYXRlc1JlcXVlc3QaKy5lc3ByZXNzb2Nhc2gubWFuYWdlLnYxLlVwZGF0ZVJhdGVz'
    'UmVzcG9uc2USeAoRQ2hlY2tUcmFuc2FjdGlvbnMSMC5lc3ByZXNzb2Nhc2gubWFuYWdlLnYxLk'
    'NoZWNrVHJhbnNhY3Rpb25zUmVxdWVzdBoxLmVzcHJlc3NvY2FzaC5tYW5hZ2UudjEuQ2hlY2tU'
    'cmFuc2FjdGlvbnNSZXNwb25zZRKHAQoWR2V0UGxhdGZvcm1BY2NvdW50SW5mbxI1LmVzcHJlc3'
    'NvY2FzaC5tYW5hZ2UudjEuR2V0UGxhdGZvcm1BY2NvdW50SW5mb1JlcXVlc3QaNi5lc3ByZXNz'
    'b2Nhc2gubWFuYWdlLnYxLkdldFBsYXRmb3JtQWNjb3VudEluZm9SZXNwb25zZQ==');
