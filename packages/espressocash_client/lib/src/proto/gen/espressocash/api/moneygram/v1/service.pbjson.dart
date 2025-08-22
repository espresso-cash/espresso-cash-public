// This is a generated file - do not edit.
//
// Generated from espressocash/api/moneygram/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rampTypeDescriptor instead')
const RampType$json = {
  '1': 'RampType',
  '2': [
    {'1': 'RAMP_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'RAMP_TYPE_ON', '2': 1},
    {'1': 'RAMP_TYPE_OFF', '2': 2},
  ],
};

/// Descriptor for `RampType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rampTypeDescriptor = $convert.base64Decode(
    'CghSYW1wVHlwZRIZChVSQU1QX1RZUEVfVU5TUEVDSUZJRUQQABIQCgxSQU1QX1RZUEVfT04QAR'
    'IRCg1SQU1QX1RZUEVfT0ZGEAI=');

@$core.Deprecated('Use moneygramChallengeSignRequestDescriptor instead')
const MoneygramChallengeSignRequest$json = {
  '1': 'MoneygramChallengeSignRequest',
  '2': [
    {'1': 'signed_tx', '3': 1, '4': 1, '5': 9, '10': 'signedTx'},
  ],
};

/// Descriptor for `MoneygramChallengeSignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneygramChallengeSignRequestDescriptor =
    $convert.base64Decode(
        'Ch1Nb25leWdyYW1DaGFsbGVuZ2VTaWduUmVxdWVzdBIbCglzaWduZWRfdHgYASABKAlSCHNpZ2'
        '5lZFR4');

@$core.Deprecated('Use moneygramChallengeSignResponseDescriptor instead')
const MoneygramChallengeSignResponse$json = {
  '1': 'MoneygramChallengeSignResponse',
  '2': [
    {'1': 'signed_tx', '3': 1, '4': 1, '5': 9, '10': 'signedTx'},
  ],
};

/// Descriptor for `MoneygramChallengeSignResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneygramChallengeSignResponseDescriptor =
    $convert.base64Decode(
        'Ch5Nb25leWdyYW1DaGFsbGVuZ2VTaWduUmVzcG9uc2USGwoJc2lnbmVkX3R4GAEgASgJUghzaW'
        'duZWRUeA==');

@$core.Deprecated('Use swapToSolanaRequestDescriptor instead')
const SwapToSolanaRequest$json = {
  '1': 'SwapToSolanaRequest',
  '2': [
    {
      '1': 'stellar_sender_address',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'stellarSenderAddress'
    },
    {
      '1': 'solana_receiver_address',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'solanaReceiverAddress'
    },
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '10': 'amount'},
  ],
};

/// Descriptor for `SwapToSolanaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List swapToSolanaRequestDescriptor = $convert.base64Decode(
    'ChNTd2FwVG9Tb2xhbmFSZXF1ZXN0EjQKFnN0ZWxsYXJfc2VuZGVyX2FkZHJlc3MYASABKAlSFH'
    'N0ZWxsYXJTZW5kZXJBZGRyZXNzEjYKF3NvbGFuYV9yZWNlaXZlcl9hZGRyZXNzGAIgASgJUhVz'
    'b2xhbmFSZWNlaXZlckFkZHJlc3MSFgoGYW1vdW50GAMgASgJUgZhbW91bnQ=');

@$core.Deprecated('Use swapToStellarRequestDescriptor instead')
const SwapToStellarRequest$json = {
  '1': 'SwapToStellarRequest',
  '2': [
    {
      '1': 'solana_sender_address',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'solanaSenderAddress'
    },
    {
      '1': 'stellar_receiver_address',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'stellarReceiverAddress'
    },
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '10': 'amount'},
    {
      '1': 'priority_fee',
      '3': 4,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'priorityFee',
      '17': true
    },
  ],
  '8': [
    {'1': '_priority_fee'},
  ],
};

/// Descriptor for `SwapToStellarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List swapToStellarRequestDescriptor = $convert.base64Decode(
    'ChRTd2FwVG9TdGVsbGFyUmVxdWVzdBIyChVzb2xhbmFfc2VuZGVyX2FkZHJlc3MYASABKAlSE3'
    'NvbGFuYVNlbmRlckFkZHJlc3MSOAoYc3RlbGxhcl9yZWNlaXZlcl9hZGRyZXNzGAIgASgJUhZz'
    'dGVsbGFyUmVjZWl2ZXJBZGRyZXNzEhYKBmFtb3VudBgDIAEoCVIGYW1vdW50EiYKDHByaW9yaX'
    'R5X2ZlZRgEIAEoBUgAUgtwcmlvcml0eUZlZYgBAUIPCg1fcHJpb3JpdHlfZmVl');

@$core.Deprecated('Use moneygramSwapResponseDescriptor instead')
const MoneygramSwapResponse$json = {
  '1': 'MoneygramSwapResponse',
  '2': [
    {'1': 'encoded_tx', '3': 1, '4': 1, '5': 9, '10': 'encodedTx'},
  ],
};

/// Descriptor for `MoneygramSwapResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneygramSwapResponseDescriptor = $convert.base64Decode(
    'ChVNb25leWdyYW1Td2FwUmVzcG9uc2USHQoKZW5jb2RlZF90eBgBIAEoCVIJZW5jb2RlZFR4');

@$core.Deprecated('Use moneygramFeeRequestDescriptor instead')
const MoneygramFeeRequest$json = {
  '1': 'MoneygramFeeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 9, '10': 'amount'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.moneygram.v1.RampType',
      '10': 'type'
    },
  ],
};

/// Descriptor for `MoneygramFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneygramFeeRequestDescriptor = $convert.base64Decode(
    'ChNNb25leWdyYW1GZWVSZXF1ZXN0EhYKBmFtb3VudBgBIAEoCVIGYW1vdW50EjsKBHR5cGUYAi'
    'ABKA4yJy5lc3ByZXNzb2Nhc2guYXBpLm1vbmV5Z3JhbS52MS5SYW1wVHlwZVIEdHlwZQ==');

@$core.Deprecated('Use moneygramFeeResponseDescriptor instead')
const MoneygramFeeResponse$json = {
  '1': 'MoneygramFeeResponse',
  '2': [
    {'1': 'bridge_fee', '3': 1, '4': 1, '5': 9, '10': 'bridgeFee'},
    {'1': 'moneygram_fee', '3': 2, '4': 1, '5': 9, '10': 'moneygramFee'},
    {
      '1': 'gas_fee_in_usdc',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'gasFeeInUsdc',
      '17': true
    },
    {
      '1': 'priority_fee',
      '3': 4,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'priorityFee',
      '17': true
    },
  ],
  '8': [
    {'1': '_gas_fee_in_usdc'},
    {'1': '_priority_fee'},
  ],
};

/// Descriptor for `MoneygramFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneygramFeeResponseDescriptor = $convert.base64Decode(
    'ChRNb25leWdyYW1GZWVSZXNwb25zZRIdCgpicmlkZ2VfZmVlGAEgASgJUglicmlkZ2VGZWUSIw'
    'oNbW9uZXlncmFtX2ZlZRgCIAEoCVIMbW9uZXlncmFtRmVlEioKD2dhc19mZWVfaW5fdXNkYxgD'
    'IAEoCUgAUgxnYXNGZWVJblVzZGOIAQESJgoMcHJpb3JpdHlfZmVlGAQgASgFSAFSC3ByaW9yaX'
    'R5RmVliAEBQhIKEF9nYXNfZmVlX2luX3VzZGNCDwoNX3ByaW9yaXR5X2ZlZQ==');

@$core.Deprecated('Use fundXlmRequestDescriptor instead')
const FundXlmRequest$json = {
  '1': 'FundXlmRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `FundXlmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundXlmRequestDescriptor = $convert.base64Decode(
    'Cg5GdW5kWGxtUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');

@$core.Deprecated('Use fundXlmResponseDescriptor instead')
const FundXlmResponse$json = {
  '1': 'FundXlmResponse',
};

/// Descriptor for `FundXlmResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundXlmResponseDescriptor =
    $convert.base64Decode('Cg9GdW5kWGxtUmVzcG9uc2U=');

const $core.Map<$core.String, $core.dynamic> MoneygramServiceBase$json = {
  '1': 'MoneygramService',
  '2': [
    {
      '1': 'SignChallenge',
      '2': '.espressocash.api.moneygram.v1.MoneygramChallengeSignRequest',
      '3': '.espressocash.api.moneygram.v1.MoneygramChallengeSignResponse'
    },
    {
      '1': 'SwapToSolana',
      '2': '.espressocash.api.moneygram.v1.SwapToSolanaRequest',
      '3': '.espressocash.api.moneygram.v1.MoneygramSwapResponse'
    },
    {
      '1': 'SwapToStellar',
      '2': '.espressocash.api.moneygram.v1.SwapToStellarRequest',
      '3': '.espressocash.api.moneygram.v1.MoneygramSwapResponse'
    },
    {
      '1': 'CalculateFee',
      '2': '.espressocash.api.moneygram.v1.MoneygramFeeRequest',
      '3': '.espressocash.api.moneygram.v1.MoneygramFeeResponse'
    },
    {
      '1': 'FundXlm',
      '2': '.espressocash.api.moneygram.v1.FundXlmRequest',
      '3': '.espressocash.api.moneygram.v1.FundXlmResponse'
    },
  ],
};

@$core.Deprecated('Use moneygramServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MoneygramServiceBase$messageJson = {
  '.espressocash.api.moneygram.v1.MoneygramChallengeSignRequest':
      MoneygramChallengeSignRequest$json,
  '.espressocash.api.moneygram.v1.MoneygramChallengeSignResponse':
      MoneygramChallengeSignResponse$json,
  '.espressocash.api.moneygram.v1.SwapToSolanaRequest':
      SwapToSolanaRequest$json,
  '.espressocash.api.moneygram.v1.MoneygramSwapResponse':
      MoneygramSwapResponse$json,
  '.espressocash.api.moneygram.v1.SwapToStellarRequest':
      SwapToStellarRequest$json,
  '.espressocash.api.moneygram.v1.MoneygramFeeRequest':
      MoneygramFeeRequest$json,
  '.espressocash.api.moneygram.v1.MoneygramFeeResponse':
      MoneygramFeeResponse$json,
  '.espressocash.api.moneygram.v1.FundXlmRequest': FundXlmRequest$json,
  '.espressocash.api.moneygram.v1.FundXlmResponse': FundXlmResponse$json,
};

/// Descriptor for `MoneygramService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List moneygramServiceDescriptor = $convert.base64Decode(
    'ChBNb25leWdyYW1TZXJ2aWNlEowBCg1TaWduQ2hhbGxlbmdlEjwuZXNwcmVzc29jYXNoLmFwaS'
    '5tb25leWdyYW0udjEuTW9uZXlncmFtQ2hhbGxlbmdlU2lnblJlcXVlc3QaPS5lc3ByZXNzb2Nh'
    'c2guYXBpLm1vbmV5Z3JhbS52MS5Nb25leWdyYW1DaGFsbGVuZ2VTaWduUmVzcG9uc2USeAoMU3'
    'dhcFRvU29sYW5hEjIuZXNwcmVzc29jYXNoLmFwaS5tb25leWdyYW0udjEuU3dhcFRvU29sYW5h'
    'UmVxdWVzdBo0LmVzcHJlc3NvY2FzaC5hcGkubW9uZXlncmFtLnYxLk1vbmV5Z3JhbVN3YXBSZX'
    'Nwb25zZRJ6Cg1Td2FwVG9TdGVsbGFyEjMuZXNwcmVzc29jYXNoLmFwaS5tb25leWdyYW0udjEu'
    'U3dhcFRvU3RlbGxhclJlcXVlc3QaNC5lc3ByZXNzb2Nhc2guYXBpLm1vbmV5Z3JhbS52MS5Nb2'
    '5leWdyYW1Td2FwUmVzcG9uc2USdwoMQ2FsY3VsYXRlRmVlEjIuZXNwcmVzc29jYXNoLmFwaS5t'
    'b25leWdyYW0udjEuTW9uZXlncmFtRmVlUmVxdWVzdBozLmVzcHJlc3NvY2FzaC5hcGkubW9uZX'
    'lncmFtLnYxLk1vbmV5Z3JhbUZlZVJlc3BvbnNlEmgKB0Z1bmRYbG0SLS5lc3ByZXNzb2Nhc2gu'
    'YXBpLm1vbmV5Z3JhbS52MS5GdW5kWGxtUmVxdWVzdBouLmVzcHJlc3NvY2FzaC5hcGkubW9uZX'
    'lncmFtLnYxLkZ1bmRYbG1SZXNwb25zZQ==');
