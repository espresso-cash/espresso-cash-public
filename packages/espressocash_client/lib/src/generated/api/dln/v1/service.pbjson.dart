//
//  Generated code. Do not modify.
//  source: api/dln/v1/service.proto
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

@$core.Deprecated('Use dlnOrderStatusDescriptor instead')
const DlnOrderStatus$json = {
  '1': 'DlnOrderStatus',
  '2': [
    {'1': 'DLN_ORDER_STATUS_NONE', '2': 0},
    {'1': 'DLN_ORDER_STATUS_CREATED', '2': 1},
    {'1': 'DLN_ORDER_STATUS_FULFILLED', '2': 2},
    {'1': 'DLN_ORDER_STATUS_SENT_UNLOCK', '2': 3},
    {'1': 'DLN_ORDER_STATUS_ORDER_CANCELLED', '2': 4},
    {'1': 'DLN_ORDER_STATUS_SENT_ORDER_CANCEL', '2': 5},
    {'1': 'DLN_ORDER_STATUS_CLAIMED_UNLOCK', '2': 6},
    {'1': 'DLN_ORDER_STATUS_CLAIMED_ORDER_CANCEL', '2': 7},
  ],
};

/// Descriptor for `DlnOrderStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List dlnOrderStatusDescriptor = $convert
    .base64Decode('Cg5EbG5PcmRlclN0YXR1cxIZChVETE5fT1JERVJfU1RBVFVTX05PTkUQABIcChhETE5fT1JERV'
        'JfU1RBVFVTX0NSRUFURUQQARIeChpETE5fT1JERVJfU1RBVFVTX0ZVTEZJTExFRBACEiAKHERM'
        'Tl9PUkRFUl9TVEFUVVNfU0VOVF9VTkxPQ0sQAxIkCiBETE5fT1JERVJfU1RBVFVTX09SREVSX0'
        'NBTkNFTExFRBAEEiYKIkRMTl9PUkRFUl9TVEFUVVNfU0VOVF9PUkRFUl9DQU5DRUwQBRIjCh9E'
        'TE5fT1JERVJfU1RBVFVTX0NMQUlNRURfVU5MT0NLEAYSKQolRExOX09SREVSX1NUQVRVU19DTE'
        'FJTUVEX09SREVSX0NBTkNFTBAH');

@$core.Deprecated('Use getOutgoingQuoteRequestDescriptor instead')
const GetOutgoingQuoteRequest$json = {
  '1': 'GetOutgoingQuoteRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'receiver_address', '3': 2, '4': 1, '5': 9, '10': 'receiverAddress'},
    {'1': 'receiver_blockchain', '3': 3, '4': 1, '5': 9, '10': 'receiverBlockchain'},
  ],
};

/// Descriptor for `GetOutgoingQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOutgoingQuoteRequestDescriptor = $convert
    .base64Decode('ChdHZXRPdXRnb2luZ1F1b3RlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudBIpChByZW'
        'NlaXZlcl9hZGRyZXNzGAIgASgJUg9yZWNlaXZlckFkZHJlc3MSLwoTcmVjZWl2ZXJfYmxvY2tj'
        'aGFpbhgDIAEoCVIScmVjZWl2ZXJCbG9ja2NoYWlu');

@$core.Deprecated('Use getOutgoingQuoteResponseDescriptor instead')
const GetOutgoingQuoteResponse$json = {
  '1': 'GetOutgoingQuoteResponse',
  '2': [
    {'1': 'input_amount', '3': 1, '4': 1, '5': 3, '10': 'inputAmount'},
    {'1': 'receiver_amount', '3': 2, '4': 1, '5': 3, '10': 'receiverAmount'},
    {'1': 'encoded_tx', '3': 3, '4': 1, '5': 9, '10': 'encodedTx'},
    {'1': 'fee_in_usdc', '3': 4, '4': 1, '5': 3, '10': 'feeInUsdc'},
    {'1': 'slot', '3': 5, '4': 1, '5': 4, '10': 'slot'},
  ],
};

/// Descriptor for `GetOutgoingQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOutgoingQuoteResponseDescriptor = $convert
    .base64Decode('ChhHZXRPdXRnb2luZ1F1b3RlUmVzcG9uc2USIQoMaW5wdXRfYW1vdW50GAEgASgDUgtpbnB1dE'
        'Ftb3VudBInCg9yZWNlaXZlcl9hbW91bnQYAiABKANSDnJlY2VpdmVyQW1vdW50Eh0KCmVuY29k'
        'ZWRfdHgYAyABKAlSCWVuY29kZWRUeBIeCgtmZWVfaW5fdXNkYxgEIAEoA1IJZmVlSW5Vc2RjEh'
        'IKBHNsb3QYBSABKARSBHNsb3Q=');

@$core.Deprecated('Use getOrderStatusRequestDescriptor instead')
const GetOrderStatusRequest$json = {
  '1': 'GetOrderStatusRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `GetOrderStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderStatusRequestDescriptor =
    $convert.base64Decode('ChVHZXRPcmRlclN0YXR1c1JlcXVlc3QSGQoIb3JkZXJfaWQYASABKAlSB29yZGVySWQ=');

@$core.Deprecated('Use getOrderStatusResponseDescriptor instead')
const GetOrderStatusResponse$json = {
  '1': 'GetOrderStatusResponse',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.dln.v1.DlnOrderStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `GetOrderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderStatusResponseDescriptor = $convert
    .base64Decode('ChZHZXRPcmRlclN0YXR1c1Jlc3BvbnNlEj8KBnN0YXR1cxgBIAEoDjInLmVzcHJlc3NvY2FzaC'
        '5hcGkuZGxuLnYxLkRsbk9yZGVyU3RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use getOrderIdRequestDescriptor instead')
const GetOrderIdRequest$json = {
  '1': 'GetOrderIdRequest',
  '2': [
    {'1': 'tx_id', '3': 1, '4': 1, '5': 9, '10': 'txId'},
  ],
};

/// Descriptor for `GetOrderIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderIdRequestDescriptor =
    $convert.base64Decode('ChFHZXRPcmRlcklkUmVxdWVzdBITCgV0eF9pZBgBIAEoCVIEdHhJZA==');

@$core.Deprecated('Use getOrderIdResponseDescriptor instead')
const GetOrderIdResponse$json = {
  '1': 'GetOrderIdResponse',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'orderId', '17': true},
  ],
  '8': [
    {'1': '_order_id'},
  ],
};

/// Descriptor for `GetOrderIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderIdResponseDescriptor = $convert
    .base64Decode('ChJHZXRPcmRlcklkUmVzcG9uc2USHgoIb3JkZXJfaWQYASABKAlIAFIHb3JkZXJJZIgBAUILCg'
        'lfb3JkZXJfaWQ=');

@$core.Deprecated('Use getIncomingQuoteRequestDescriptor instead')
const GetIncomingQuoteRequest$json = {
  '1': 'GetIncomingQuoteRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'sender_address', '3': 2, '4': 1, '5': 9, '10': 'senderAddress'},
    {'1': 'sender_blockchain', '3': 3, '4': 1, '5': 9, '10': 'senderBlockchain'},
    {'1': 'receiver_address', '3': 4, '4': 1, '5': 9, '10': 'receiverAddress'},
    {
      '1': 'solana_reference_address',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'solanaReferenceAddress',
      '17': true
    },
  ],
  '8': [
    {'1': '_solana_reference_address'},
  ],
};

/// Descriptor for `GetIncomingQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomingQuoteRequestDescriptor = $convert
    .base64Decode('ChdHZXRJbmNvbWluZ1F1b3RlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudBIlCg5zZW'
        '5kZXJfYWRkcmVzcxgCIAEoCVINc2VuZGVyQWRkcmVzcxIrChFzZW5kZXJfYmxvY2tjaGFpbhgD'
        'IAEoCVIQc2VuZGVyQmxvY2tjaGFpbhIpChByZWNlaXZlcl9hZGRyZXNzGAQgASgJUg9yZWNlaX'
        'ZlckFkZHJlc3MSPQoYc29sYW5hX3JlZmVyZW5jZV9hZGRyZXNzGAUgASgJSABSFnNvbGFuYVJl'
        'ZmVyZW5jZUFkZHJlc3OIAQFCGwoZX3NvbGFuYV9yZWZlcmVuY2VfYWRkcmVzcw==');

@$core.Deprecated('Use getIncomingQuoteResponseDescriptor instead')
const GetIncomingQuoteResponse$json = {
  '1': 'GetIncomingQuoteResponse',
  '2': [
    {'1': 'tx', '3': 1, '4': 1, '5': 11, '6': '.espressocash.api.dln.v1.QuoteTx', '10': 'tx'},
    {
      '1': 'usdc_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.dln.v1.QuoteUsdcInfo',
      '10': 'usdcInfo'
    },
    {'1': 'input_amount', '3': 3, '4': 1, '5': 3, '10': 'inputAmount'},
    {'1': 'receiver_amount', '3': 4, '4': 1, '5': 3, '10': 'receiverAmount'},
    {'1': 'fee_in_usdc', '3': 5, '4': 1, '5': 3, '10': 'feeInUsdc'},
  ],
};

/// Descriptor for `GetIncomingQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomingQuoteResponseDescriptor = $convert
    .base64Decode('ChhHZXRJbmNvbWluZ1F1b3RlUmVzcG9uc2USMAoCdHgYASABKAsyIC5lc3ByZXNzb2Nhc2guYX'
        'BpLmRsbi52MS5RdW90ZVR4UgJ0eBJDCgl1c2RjX2luZm8YAiABKAsyJi5lc3ByZXNzb2Nhc2gu'
        'YXBpLmRsbi52MS5RdW90ZVVzZGNJbmZvUgh1c2RjSW5mbxIhCgxpbnB1dF9hbW91bnQYAyABKA'
        'NSC2lucHV0QW1vdW50EicKD3JlY2VpdmVyX2Ftb3VudBgEIAEoA1IOcmVjZWl2ZXJBbW91bnQS'
        'HgoLZmVlX2luX3VzZGMYBSABKANSCWZlZUluVXNkYw==');

@$core.Deprecated('Use quoteTxDescriptor instead')
const QuoteTx$json = {
  '1': 'QuoteTx',
  '2': [
    {'1': 'to', '3': 1, '4': 1, '5': 9, '10': 'to'},
    {'1': 'data', '3': 2, '4': 1, '5': 9, '10': 'data'},
    {'1': 'value', '3': 3, '4': 1, '5': 3, '10': 'value'},
  ],
};

/// Descriptor for `QuoteTx`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteTxDescriptor = $convert
    .base64Decode('CgdRdW90ZVR4Eg4KAnRvGAEgASgJUgJ0bxISCgRkYXRhGAIgASgJUgRkYXRhEhQKBXZhbHVlGA'
        'MgASgDUgV2YWx1ZQ==');

@$core.Deprecated('Use quoteUsdcInfoDescriptor instead')
const QuoteUsdcInfo$json = {
  '1': 'QuoteUsdcInfo',
  '2': [
    {'1': 'usdc_address', '3': 1, '4': 1, '5': 9, '10': 'usdcAddress'},
    {'1': 'approval_amount', '3': 2, '4': 1, '5': 3, '10': 'approvalAmount'},
  ],
};

/// Descriptor for `QuoteUsdcInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteUsdcInfoDescriptor = $convert
    .base64Decode('Cg1RdW90ZVVzZGNJbmZvEiEKDHVzZGNfYWRkcmVzcxgBIAEoCVILdXNkY0FkZHJlc3MSJwoPYX'
        'Bwcm92YWxfYW1vdW50GAIgASgDUg5hcHByb3ZhbEFtb3VudA==');

@$core.Deprecated('Use getGasFeesRequestDescriptor instead')
const GetGasFeesRequest$json = {
  '1': 'GetGasFeesRequest',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetGasFeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGasFeesRequestDescriptor =
    $convert.base64Decode('ChFHZXRHYXNGZWVzUmVxdWVzdBIYCgduZXR3b3JrGAEgASgJUgduZXR3b3Jr');

@$core.Deprecated('Use getGasFeesResponseDescriptor instead')
const GetGasFeesResponse$json = {
  '1': 'GetGasFeesResponse',
  '2': [
    {
      '1': 'low',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.dln.v1.GasFeeEstimate',
      '10': 'low'
    },
    {
      '1': 'medium',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.dln.v1.GasFeeEstimate',
      '10': 'medium'
    },
    {
      '1': 'high',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.espressocash.api.dln.v1.GasFeeEstimate',
      '10': 'high'
    },
    {'1': 'estimated_base_fee', '3': 4, '4': 1, '5': 9, '10': 'estimatedBaseFee'},
    {'1': 'network_congestion', '3': 5, '4': 1, '5': 1, '10': 'networkCongestion'},
  ],
};

/// Descriptor for `GetGasFeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGasFeesResponseDescriptor = $convert
    .base64Decode('ChJHZXRHYXNGZWVzUmVzcG9uc2USOQoDbG93GAEgASgLMicuZXNwcmVzc29jYXNoLmFwaS5kbG'
        '4udjEuR2FzRmVlRXN0aW1hdGVSA2xvdxI/CgZtZWRpdW0YAiABKAsyJy5lc3ByZXNzb2Nhc2gu'
        'YXBpLmRsbi52MS5HYXNGZWVFc3RpbWF0ZVIGbWVkaXVtEjsKBGhpZ2gYAyABKAsyJy5lc3ByZX'
        'Nzb2Nhc2guYXBpLmRsbi52MS5HYXNGZWVFc3RpbWF0ZVIEaGlnaBIsChJlc3RpbWF0ZWRfYmFz'
        'ZV9mZWUYBCABKAlSEGVzdGltYXRlZEJhc2VGZWUSLQoSbmV0d29ya19jb25nZXN0aW9uGAUgAS'
        'gBUhFuZXR3b3JrQ29uZ2VzdGlvbg==');

@$core.Deprecated('Use gasFeeEstimateDescriptor instead')
const GasFeeEstimate$json = {
  '1': 'GasFeeEstimate',
  '2': [
    {
      '1': 'suggested_max_priority_fee_per_gas',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'suggestedMaxPriorityFeePerGas'
    },
    {'1': 'suggested_max_fee_per_gas', '3': 2, '4': 1, '5': 9, '10': 'suggestedMaxFeePerGas'},
    {'1': 'min_wait_time_estimate', '3': 3, '4': 1, '5': 5, '10': 'minWaitTimeEstimate'},
    {'1': 'max_wait_time_estimate', '3': 4, '4': 1, '5': 5, '10': 'maxWaitTimeEstimate'},
  ],
};

/// Descriptor for `GasFeeEstimate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gasFeeEstimateDescriptor = $convert
    .base64Decode('Cg5HYXNGZWVFc3RpbWF0ZRJJCiJzdWdnZXN0ZWRfbWF4X3ByaW9yaXR5X2ZlZV9wZXJfZ2FzGA'
        'EgASgJUh1zdWdnZXN0ZWRNYXhQcmlvcml0eUZlZVBlckdhcxI4ChlzdWdnZXN0ZWRfbWF4X2Zl'
        'ZV9wZXJfZ2FzGAIgASgJUhVzdWdnZXN0ZWRNYXhGZWVQZXJHYXMSMwoWbWluX3dhaXRfdGltZV'
        '9lc3RpbWF0ZRgDIAEoBVITbWluV2FpdFRpbWVFc3RpbWF0ZRIzChZtYXhfd2FpdF90aW1lX2Vz'
        'dGltYXRlGAQgASgFUhNtYXhXYWl0VGltZUVzdGltYXRl');
