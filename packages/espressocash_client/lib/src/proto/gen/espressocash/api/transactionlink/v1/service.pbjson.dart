// This is a generated file - do not edit.
//
// Generated from espressocash/api/transactionlink/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionStatusDescriptor instead')
const TransactionStatus$json = {
  '1': 'TransactionStatus',
  '2': [
    {'1': 'TRANSACTION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'TRANSACTION_STATUS_PENDING', '2': 1},
    {'1': 'TRANSACTION_STATUS_SIGNED', '2': 2},
    {'1': 'TRANSACTION_STATUS_SUBMITTED', '2': 3},
    {'1': 'TRANSACTION_STATUS_CONFIRMED', '2': 4},
    {'1': 'TRANSACTION_STATUS_FAILED', '2': 5},
    {'1': 'TRANSACTION_STATUS_EXPIRED', '2': 6},
  ],
};

/// Descriptor for `TransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionStatusDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvblN0YXR1cxIiCh5UUkFOU0FDVElPTl9TVEFUVVNfVU5TUEVDSUZJRUQQAB'
    'IeChpUUkFOU0FDVElPTl9TVEFUVVNfUEVORElORxABEh0KGVRSQU5TQUNUSU9OX1NUQVRVU19T'
    'SUdORUQQAhIgChxUUkFOU0FDVElPTl9TVEFUVVNfU1VCTUlUVEVEEAMSIAocVFJBTlNBQ1RJT0'
    '5fU1RBVFVTX0NPTkZJUk1FRBAEEh0KGVRSQU5TQUNUSU9OX1NUQVRVU19GQUlMRUQQBRIeChpU'
    'UkFOU0FDVElPTl9TVEFUVVNfRVhQSVJFRBAG');

@$core.Deprecated('Use getOnboardingLinkRequestDescriptor instead')
const GetOnboardingLinkRequest$json = {
  '1': 'GetOnboardingLinkRequest',
  '2': [
    {'1': 'platform', '3': 1, '4': 1, '5': 9, '10': 'platform'},
    {
      '1': 'referral_code',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'referralCode',
      '17': true
    },
    {
      '1': 'metadata',
      '3': 3,
      '4': 3,
      '5': 11,
      '6':
          '.espressocash.api.transactionlink.v1.GetOnboardingLinkRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [GetOnboardingLinkRequest_MetadataEntry$json],
  '8': [
    {'1': '_referral_code'},
  ],
};

@$core.Deprecated('Use getOnboardingLinkRequestDescriptor instead')
const GetOnboardingLinkRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetOnboardingLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnboardingLinkRequestDescriptor = $convert.base64Decode(
    'ChhHZXRPbmJvYXJkaW5nTGlua1JlcXVlc3QSGgoIcGxhdGZvcm0YASABKAlSCHBsYXRmb3JtEi'
    'gKDXJlZmVycmFsX2NvZGUYAiABKAlIAFIMcmVmZXJyYWxDb2RliAEBEmcKCG1ldGFkYXRhGAMg'
    'AygLMksuZXNwcmVzc29jYXNoLmFwaS50cmFuc2FjdGlvbmxpbmsudjEuR2V0T25ib2FyZGluZ0'
    'xpbmtSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoD'
    'a2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIQCg5fcmVmZXJyYWxfY2'
    '9kZQ==');

@$core.Deprecated('Use getOnboardingLinkResponseDescriptor instead')
const GetOnboardingLinkResponse$json = {
  '1': 'GetOnboardingLinkResponse',
  '2': [
    {'1': 'onboarding_url', '3': 1, '4': 1, '5': 9, '10': 'onboardingUrl'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'expires_at', '3': 3, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GetOnboardingLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnboardingLinkResponseDescriptor = $convert.base64Decode(
    'ChlHZXRPbmJvYXJkaW5nTGlua1Jlc3BvbnNlEiUKDm9uYm9hcmRpbmdfdXJsGAEgASgJUg1vbm'
    'JvYXJkaW5nVXJsEh0KCnNlc3Npb25faWQYAiABKAlSCXNlc3Npb25JZBIdCgpleHBpcmVzX2F0'
    'GAMgASgDUglleHBpcmVzQXQ=');

@$core.Deprecated('Use createTransactionLinkRequestDescriptor instead')
const CreateTransactionLinkRequest$json = {
  '1': 'CreateTransactionLinkRequest',
  '2': [
    {'1': 'transaction_type', '3': 1, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'user_wallet', '3': 2, '4': 1, '5': 9, '10': 'userWallet'},
    {'1': 'platform', '3': 3, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'use_swig', '3': 4, '4': 1, '5': 8, '10': 'useSwig'},
    {
      '1': 'payment',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.transactionlink.v1.PaymentParams',
      '9': 0,
      '10': 'payment'
    },
    {
      '1': 'swap',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.transactionlink.v1.SwapParams',
      '9': 0,
      '10': 'swap'
    },
  ],
  '8': [
    {'1': 'params'},
  ],
};

/// Descriptor for `CreateTransactionLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionLinkRequestDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVUcmFuc2FjdGlvbkxpbmtSZXF1ZXN0EikKEHRyYW5zYWN0aW9uX3R5cGUYASABKA'
    'lSD3RyYW5zYWN0aW9uVHlwZRIfCgt1c2VyX3dhbGxldBgCIAEoCVIKdXNlcldhbGxldBIaCghw'
    'bGF0Zm9ybRgDIAEoCVIIcGxhdGZvcm0SGQoIdXNlX3N3aWcYBCABKAhSB3VzZVN3aWcSTgoHcG'
    'F5bWVudBgFIAEoCzIyLmVzcHJlc3NvY2FzaC5hcGkudHJhbnNhY3Rpb25saW5rLnYxLlBheW1l'
    'bnRQYXJhbXNIAFIHcGF5bWVudBJFCgRzd2FwGAYgASgLMi8uZXNwcmVzc29jYXNoLmFwaS50cm'
    'Fuc2FjdGlvbmxpbmsudjEuU3dhcFBhcmFtc0gAUgRzd2FwQggKBnBhcmFtcw==');

@$core.Deprecated('Use paymentParamsDescriptor instead')
const PaymentParams$json = {
  '1': 'PaymentParams',
  '2': [
    {'1': 'recipient', '3': 1, '4': 1, '5': 9, '10': 'recipient'},
    {'1': 'amount', '3': 2, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    {'1': 'memo', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'memo', '17': true},
  ],
  '8': [
    {'1': '_memo'},
  ],
};

/// Descriptor for `PaymentParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentParamsDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50UGFyYW1zEhwKCXJlY2lwaWVudBgBIAEoCVIJcmVjaXBpZW50EhYKBmFtb3VudB'
    'gCIAEoCVIGYW1vdW50EhQKBXRva2VuGAMgASgJUgV0b2tlbhIXCgRtZW1vGAQgASgJSABSBG1l'
    'bW+IAQFCBwoFX21lbW8=');

@$core.Deprecated('Use swapParamsDescriptor instead')
const SwapParams$json = {
  '1': 'SwapParams',
  '2': [
    {'1': 'input_token', '3': 1, '4': 1, '5': 9, '10': 'inputToken'},
    {'1': 'output_token', '3': 2, '4': 1, '5': 9, '10': 'outputToken'},
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'exact_input', '3': 4, '4': 1, '5': 8, '10': 'exactInput'},
    {'1': 'slippage_bps', '3': 5, '4': 1, '5': 9, '10': 'slippageBps'},
  ],
};

/// Descriptor for `SwapParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List swapParamsDescriptor = $convert.base64Decode(
    'CgpTd2FwUGFyYW1zEh8KC2lucHV0X3Rva2VuGAEgASgJUgppbnB1dFRva2VuEiEKDG91dHB1dF'
    '90b2tlbhgCIAEoCVILb3V0cHV0VG9rZW4SFgoGYW1vdW50GAMgASgJUgZhbW91bnQSHwoLZXhh'
    'Y3RfaW5wdXQYBCABKAhSCmV4YWN0SW5wdXQSIQoMc2xpcHBhZ2VfYnBzGAUgASgJUgtzbGlwcG'
    'FnZUJwcw==');

@$core.Deprecated('Use createTransactionLinkResponseDescriptor instead')
const CreateTransactionLinkResponse$json = {
  '1': 'CreateTransactionLinkResponse',
  '2': [
    {'1': 'signing_url', '3': 1, '4': 1, '5': 9, '10': 'signingUrl'},
    {'1': 'tracking_token', '3': 2, '4': 1, '5': 9, '10': 'trackingToken'},
    {'1': 'expires_at', '3': 3, '4': 1, '5': 3, '10': 'expiresAt'},
    {
      '1': 'estimated_fees',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'estimatedFees',
      '17': true
    },
  ],
  '8': [
    {'1': '_estimated_fees'},
  ],
};

/// Descriptor for `CreateTransactionLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionLinkResponseDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVUcmFuc2FjdGlvbkxpbmtSZXNwb25zZRIfCgtzaWduaW5nX3VybBgBIAEoCVIKc2'
    'lnbmluZ1VybBIlCg50cmFja2luZ190b2tlbhgCIAEoCVINdHJhY2tpbmdUb2tlbhIdCgpleHBp'
    'cmVzX2F0GAMgASgDUglleHBpcmVzQXQSKgoOZXN0aW1hdGVkX2ZlZXMYBCABKAlIAFINZXN0aW'
    '1hdGVkRmVlc4gBAUIRCg9fZXN0aW1hdGVkX2ZlZXM=');

@$core.Deprecated('Use getTransactionStatusRequestDescriptor instead')
const GetTransactionStatusRequest$json = {
  '1': 'GetTransactionStatusRequest',
  '2': [
    {'1': 'tracking_token', '3': 1, '4': 1, '5': 9, '10': 'trackingToken'},
  ],
};

/// Descriptor for `GetTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSJQoOdHJhY2tpbmdfdG9rZW4YASABKAlSDX'
        'RyYWNraW5nVG9rZW4=');

@$core.Deprecated('Use getTransactionStatusResponseDescriptor instead')
const GetTransactionStatusResponse$json = {
  '1': 'GetTransactionStatusResponse',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.transactionlink.v1.TransactionStatus',
      '10': 'status'
    },
    {
      '1': 'signature',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'signature',
      '17': true
    },
    {'1': 'error', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'error', '17': true},
    {
      '1': 'confirmed_at',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'confirmedAt',
      '17': true
    },
  ],
  '8': [
    {'1': '_signature'},
    {'1': '_error'},
    {'1': '_confirmed_at'},
  ],
};

/// Descriptor for `GetTransactionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusResponseDescriptor = $convert.base64Decode(
    'ChxHZXRUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNlEk4KBnN0YXR1cxgBIAEoDjI2LmVzcHJlc3'
    'NvY2FzaC5hcGkudHJhbnNhY3Rpb25saW5rLnYxLlRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMS'
    'IQoJc2lnbmF0dXJlGAIgASgJSABSCXNpZ25hdHVyZYgBARIZCgVlcnJvchgDIAEoCUgBUgVlcn'
    'JvcogBARImCgxjb25maXJtZWRfYXQYBCABKANIAlILY29uZmlybWVkQXSIAQFCDAoKX3NpZ25h'
    'dHVyZUIICgZfZXJyb3JCDwoNX2NvbmZpcm1lZF9hdA==');

const $core.Map<$core.String, $core.dynamic> TransactionLinkServiceBase$json = {
  '1': 'TransactionLinkService',
  '2': [
    {
      '1': 'GetOnboardingLink',
      '2': '.espressocash.api.transactionlink.v1.GetOnboardingLinkRequest',
      '3': '.espressocash.api.transactionlink.v1.GetOnboardingLinkResponse'
    },
    {
      '1': 'CreateTransactionLink',
      '2': '.espressocash.api.transactionlink.v1.CreateTransactionLinkRequest',
      '3': '.espressocash.api.transactionlink.v1.CreateTransactionLinkResponse'
    },
    {
      '1': 'GetTransactionStatus',
      '2': '.espressocash.api.transactionlink.v1.GetTransactionStatusRequest',
      '3': '.espressocash.api.transactionlink.v1.GetTransactionStatusResponse'
    },
  ],
};

@$core.Deprecated('Use transactionLinkServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TransactionLinkServiceBase$messageJson = {
  '.espressocash.api.transactionlink.v1.GetOnboardingLinkRequest':
      GetOnboardingLinkRequest$json,
  '.espressocash.api.transactionlink.v1.GetOnboardingLinkRequest.MetadataEntry':
      GetOnboardingLinkRequest_MetadataEntry$json,
  '.espressocash.api.transactionlink.v1.GetOnboardingLinkResponse':
      GetOnboardingLinkResponse$json,
  '.espressocash.api.transactionlink.v1.CreateTransactionLinkRequest':
      CreateTransactionLinkRequest$json,
  '.espressocash.api.transactionlink.v1.PaymentParams': PaymentParams$json,
  '.espressocash.api.transactionlink.v1.SwapParams': SwapParams$json,
  '.espressocash.api.transactionlink.v1.CreateTransactionLinkResponse':
      CreateTransactionLinkResponse$json,
  '.espressocash.api.transactionlink.v1.GetTransactionStatusRequest':
      GetTransactionStatusRequest$json,
  '.espressocash.api.transactionlink.v1.GetTransactionStatusResponse':
      GetTransactionStatusResponse$json,
};

/// Descriptor for `TransactionLinkService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List transactionLinkServiceDescriptor = $convert.base64Decode(
    'ChZUcmFuc2FjdGlvbkxpbmtTZXJ2aWNlEpIBChFHZXRPbmJvYXJkaW5nTGluaxI9LmVzcHJlc3'
    'NvY2FzaC5hcGkudHJhbnNhY3Rpb25saW5rLnYxLkdldE9uYm9hcmRpbmdMaW5rUmVxdWVzdBo+'
    'LmVzcHJlc3NvY2FzaC5hcGkudHJhbnNhY3Rpb25saW5rLnYxLkdldE9uYm9hcmRpbmdMaW5rUm'
    'VzcG9uc2USngEKFUNyZWF0ZVRyYW5zYWN0aW9uTGluaxJBLmVzcHJlc3NvY2FzaC5hcGkudHJh'
    'bnNhY3Rpb25saW5rLnYxLkNyZWF0ZVRyYW5zYWN0aW9uTGlua1JlcXVlc3QaQi5lc3ByZXNzb2'
    'Nhc2guYXBpLnRyYW5zYWN0aW9ubGluay52MS5DcmVhdGVUcmFuc2FjdGlvbkxpbmtSZXNwb25z'
    'ZRKbAQoUR2V0VHJhbnNhY3Rpb25TdGF0dXMSQC5lc3ByZXNzb2Nhc2guYXBpLnRyYW5zYWN0aW'
    '9ubGluay52MS5HZXRUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QaQS5lc3ByZXNzb2Nhc2guYXBp'
    'LnRyYW5zYWN0aW9ubGluay52MS5HZXRUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNl');
