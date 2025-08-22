// This is a generated file - do not edit.
//
// Generated from espressocash/api/shortener/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use shortenLinkRequestDescriptor instead')
const ShortenLinkRequest$json = {
  '1': 'ShortenLinkRequest',
  '2': [
    {'1': 'full_link', '3': 1, '4': 1, '5': 9, '10': 'fullLink'},
  ],
};

/// Descriptor for `ShortenLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shortenLinkRequestDescriptor =
    $convert.base64Decode(
        'ChJTaG9ydGVuTGlua1JlcXVlc3QSGwoJZnVsbF9saW5rGAEgASgJUghmdWxsTGluaw==');

@$core.Deprecated('Use shortenLinkResponseDescriptor instead')
const ShortenLinkResponse$json = {
  '1': 'ShortenLinkResponse',
  '2': [
    {'1': 'short_link', '3': 1, '4': 1, '5': 9, '10': 'shortLink'},
  ],
};

/// Descriptor for `ShortenLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shortenLinkResponseDescriptor = $convert.base64Decode(
    'ChNTaG9ydGVuTGlua1Jlc3BvbnNlEh0KCnNob3J0X2xpbmsYASABKAlSCXNob3J0TGluaw==');

@$core.Deprecated('Use expandLinkRequestDescriptor instead')
const ExpandLinkRequest$json = {
  '1': 'ExpandLinkRequest',
  '2': [
    {'1': 'short_link', '3': 1, '4': 1, '5': 9, '10': 'shortLink'},
  ],
};

/// Descriptor for `ExpandLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expandLinkRequestDescriptor = $convert.base64Decode(
    'ChFFeHBhbmRMaW5rUmVxdWVzdBIdCgpzaG9ydF9saW5rGAEgASgJUglzaG9ydExpbms=');

@$core.Deprecated('Use expandLinkResponseDescriptor instead')
const ExpandLinkResponse$json = {
  '1': 'ExpandLinkResponse',
  '2': [
    {'1': 'full_link', '3': 1, '4': 1, '5': 9, '10': 'fullLink'},
  ],
};

/// Descriptor for `ExpandLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expandLinkResponseDescriptor =
    $convert.base64Decode(
        'ChJFeHBhbmRMaW5rUmVzcG9uc2USGwoJZnVsbF9saW5rGAEgASgJUghmdWxsTGluaw==');

const $core.Map<$core.String, $core.dynamic> ShortenerServiceBase$json = {
  '1': 'ShortenerService',
  '2': [
    {
      '1': 'ShortenLink',
      '2': '.espressocash.api.shortener.v1.ShortenLinkRequest',
      '3': '.espressocash.api.shortener.v1.ShortenLinkResponse'
    },
    {
      '1': 'ExpandLink',
      '2': '.espressocash.api.shortener.v1.ExpandLinkRequest',
      '3': '.espressocash.api.shortener.v1.ExpandLinkResponse'
    },
  ],
};

@$core.Deprecated('Use shortenerServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ShortenerServiceBase$messageJson = {
  '.espressocash.api.shortener.v1.ShortenLinkRequest': ShortenLinkRequest$json,
  '.espressocash.api.shortener.v1.ShortenLinkResponse':
      ShortenLinkResponse$json,
  '.espressocash.api.shortener.v1.ExpandLinkRequest': ExpandLinkRequest$json,
  '.espressocash.api.shortener.v1.ExpandLinkResponse': ExpandLinkResponse$json,
};

/// Descriptor for `ShortenerService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List shortenerServiceDescriptor = $convert.base64Decode(
    'ChBTaG9ydGVuZXJTZXJ2aWNlEnQKC1Nob3J0ZW5MaW5rEjEuZXNwcmVzc29jYXNoLmFwaS5zaG'
    '9ydGVuZXIudjEuU2hvcnRlbkxpbmtSZXF1ZXN0GjIuZXNwcmVzc29jYXNoLmFwaS5zaG9ydGVu'
    'ZXIudjEuU2hvcnRlbkxpbmtSZXNwb25zZRJxCgpFeHBhbmRMaW5rEjAuZXNwcmVzc29jYXNoLm'
    'FwaS5zaG9ydGVuZXIudjEuRXhwYW5kTGlua1JlcXVlc3QaMS5lc3ByZXNzb2Nhc2guYXBpLnNo'
    'b3J0ZW5lci52MS5FeHBhbmRMaW5rUmVzcG9uc2U=');
