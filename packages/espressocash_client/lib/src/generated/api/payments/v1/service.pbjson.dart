//
//  Generated code. Do not modify.
//  source: api/payments/v1/service.proto
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

@$core.Deprecated('Use createDirectPaymentRequestDescriptor instead')
const CreateDirectPaymentRequest$json = {
  '1': 'CreateDirectPaymentRequest',
  '2': [
    {'1': 'sender_account', '3': 1, '4': 1, '5': 9, '10': 'senderAccount'},
    {'1': 'receiver_account', '3': 2, '4': 1, '5': 9, '10': 'receiverAccount'},
    {'1': 'reference_account', '3': 3, '4': 1, '5': 9, '10': 'referenceAccount'},
    {'1': 'amount', '3': 4, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'mint', '3': 5, '4': 1, '5': 9, '10': 'mint'},
  ],
};

/// Descriptor for `CreateDirectPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDirectPaymentRequestDescriptor = $convert
    .base64Decode('ChpDcmVhdGVEaXJlY3RQYXltZW50UmVxdWVzdBIlCg5zZW5kZXJfYWNjb3VudBgBIAEoCVINc2'
        'VuZGVyQWNjb3VudBIpChByZWNlaXZlcl9hY2NvdW50GAIgASgJUg9yZWNlaXZlckFjY291bnQS'
        'KwoRcmVmZXJlbmNlX2FjY291bnQYAyABKAlSEHJlZmVyZW5jZUFjY291bnQSFgoGYW1vdW50GA'
        'QgASgEUgZhbW91bnQSEgoEbWludBgFIAEoCVIEbWludA==');

@$core.Deprecated('Use createDirectPaymentResponseDescriptor instead')
const CreateDirectPaymentResponse$json = {
  '1': 'CreateDirectPaymentResponse',
  '2': [
    {'1': 'fee', '3': 1, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'transaction', '3': 2, '4': 1, '5': 9, '10': 'transaction'},
    {'1': 'slot', '3': 3, '4': 1, '5': 4, '10': 'slot'},
  ],
};

/// Descriptor for `CreateDirectPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDirectPaymentResponseDescriptor = $convert
    .base64Decode('ChtDcmVhdGVEaXJlY3RQYXltZW50UmVzcG9uc2USEAoDZmVlGAEgASgEUgNmZWUSIAoLdHJhbn'
        'NhY3Rpb24YAiABKAlSC3RyYW5zYWN0aW9uEhIKBHNsb3QYAyABKARSBHNsb3Q=');

@$core.Deprecated('Use getDirectPaymentQuoteRequestDescriptor instead')
const GetDirectPaymentQuoteRequest$json = {
  '1': 'GetDirectPaymentQuoteRequest',
  '2': [
    {'1': 'receiver_account', '3': 1, '4': 1, '5': 9, '10': 'receiverAccount'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'mint', '3': 3, '4': 1, '5': 9, '10': 'mint'},
  ],
};

/// Descriptor for `GetDirectPaymentQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectPaymentQuoteRequestDescriptor = $convert
    .base64Decode('ChxHZXREaXJlY3RQYXltZW50UXVvdGVSZXF1ZXN0EikKEHJlY2VpdmVyX2FjY291bnQYASABKA'
        'lSD3JlY2VpdmVyQWNjb3VudBIWCgZhbW91bnQYAiABKARSBmFtb3VudBISCgRtaW50GAMgASgJ'
        'UgRtaW50');

@$core.Deprecated('Use getDirectPaymentQuoteResponseDescriptor instead')
const GetDirectPaymentQuoteResponse$json = {
  '1': 'GetDirectPaymentQuoteResponse',
  '2': [
    {'1': 'fee', '3': 1, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'total_amount', '3': 2, '4': 1, '5': 4, '10': 'totalAmount'},
  ],
};

/// Descriptor for `GetDirectPaymentQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectPaymentQuoteResponseDescriptor = $convert
    .base64Decode('Ch1HZXREaXJlY3RQYXltZW50UXVvdGVSZXNwb25zZRIQCgNmZWUYASABKARSA2ZlZRIhCgx0b3'
        'RhbF9hbW91bnQYAiABKARSC3RvdGFsQW1vdW50');

@$core.Deprecated('Use createEscrowPaymentRequestDescriptor instead')
const CreateEscrowPaymentRequest$json = {
  '1': 'CreateEscrowPaymentRequest',
  '2': [
    {'1': 'sender_account', '3': 1, '4': 1, '5': 9, '10': 'senderAccount'},
    {'1': 'escrow_account', '3': 2, '4': 1, '5': 9, '10': 'escrowAccount'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
  ],
};

/// Descriptor for `CreateEscrowPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEscrowPaymentRequestDescriptor = $convert
    .base64Decode('ChpDcmVhdGVFc2Nyb3dQYXltZW50UmVxdWVzdBIlCg5zZW5kZXJfYWNjb3VudBgBIAEoCVINc2'
        'VuZGVyQWNjb3VudBIlCg5lc2Nyb3dfYWNjb3VudBgCIAEoCVINZXNjcm93QWNjb3VudBIWCgZh'
        'bW91bnQYAyABKARSBmFtb3VudA==');

@$core.Deprecated('Use createEscrowPaymentResponseDescriptor instead')
const CreateEscrowPaymentResponse$json = {
  '1': 'CreateEscrowPaymentResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 9, '10': 'transaction'},
    {'1': 'slot', '3': 2, '4': 1, '5': 4, '10': 'slot'},
  ],
};

/// Descriptor for `CreateEscrowPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEscrowPaymentResponseDescriptor = $convert
    .base64Decode('ChtDcmVhdGVFc2Nyb3dQYXltZW50UmVzcG9uc2USIAoLdHJhbnNhY3Rpb24YASABKAlSC3RyYW'
        '5zYWN0aW9uEhIKBHNsb3QYAiABKARSBHNsb3Q=');

@$core.Deprecated('Use receiveEscrowPaymentRequestDescriptor instead')
const ReceiveEscrowPaymentRequest$json = {
  '1': 'ReceiveEscrowPaymentRequest',
  '2': [
    {'1': 'receiver_account', '3': 1, '4': 1, '5': 9, '10': 'receiverAccount'},
    {'1': 'escrow_account', '3': 2, '4': 1, '5': 9, '10': 'escrowAccount'},
  ],
};

/// Descriptor for `ReceiveEscrowPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiveEscrowPaymentRequestDescriptor = $convert
    .base64Decode('ChtSZWNlaXZlRXNjcm93UGF5bWVudFJlcXVlc3QSKQoQcmVjZWl2ZXJfYWNjb3VudBgBIAEoCV'
        'IPcmVjZWl2ZXJBY2NvdW50EiUKDmVzY3Jvd19hY2NvdW50GAIgASgJUg1lc2Nyb3dBY2NvdW50');

@$core.Deprecated('Use receiveEscrowPaymentResponseDescriptor instead')
const ReceiveEscrowPaymentResponse$json = {
  '1': 'ReceiveEscrowPaymentResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 9, '10': 'transaction'},
    {'1': 'slot', '3': 2, '4': 1, '5': 4, '10': 'slot'},
  ],
};

/// Descriptor for `ReceiveEscrowPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiveEscrowPaymentResponseDescriptor = $convert
    .base64Decode('ChxSZWNlaXZlRXNjcm93UGF5bWVudFJlc3BvbnNlEiAKC3RyYW5zYWN0aW9uGAEgASgJUgt0cm'
        'Fuc2FjdGlvbhISCgRzbG90GAIgASgEUgRzbG90');

@$core.Deprecated('Use cancelEscrowPaymentRequestDescriptor instead')
const CancelEscrowPaymentRequest$json = {
  '1': 'CancelEscrowPaymentRequest',
  '2': [
    {'1': 'sender_account', '3': 1, '4': 1, '5': 9, '10': 'senderAccount'},
    {'1': 'escrow_account', '3': 2, '4': 1, '5': 9, '10': 'escrowAccount'},
  ],
};

/// Descriptor for `CancelEscrowPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelEscrowPaymentRequestDescriptor = $convert
    .base64Decode('ChpDYW5jZWxFc2Nyb3dQYXltZW50UmVxdWVzdBIlCg5zZW5kZXJfYWNjb3VudBgBIAEoCVINc2'
        'VuZGVyQWNjb3VudBIlCg5lc2Nyb3dfYWNjb3VudBgCIAEoCVINZXNjcm93QWNjb3VudA==');

@$core.Deprecated('Use cancelEscrowPaymentResponseDescriptor instead')
const CancelEscrowPaymentResponse$json = {
  '1': 'CancelEscrowPaymentResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 9, '10': 'transaction'},
    {'1': 'slot', '3': 2, '4': 1, '5': 4, '10': 'slot'},
  ],
};

/// Descriptor for `CancelEscrowPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelEscrowPaymentResponseDescriptor = $convert
    .base64Decode('ChtDYW5jZWxFc2Nyb3dQYXltZW50UmVzcG9uc2USIAoLdHJhbnNhY3Rpb24YASABKAlSC3RyYW'
        '5zYWN0aW9uEhIKBHNsb3QYAiABKARSBHNsb3Q=');

@$core.Deprecated('Use getIncomingEscrowPaymentQuoteRequestDescriptor instead')
const GetIncomingEscrowPaymentQuoteRequest$json = {
  '1': 'GetIncomingEscrowPaymentQuoteRequest',
};

/// Descriptor for `GetIncomingEscrowPaymentQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomingEscrowPaymentQuoteRequestDescriptor =
    $convert.base64Decode('CiRHZXRJbmNvbWluZ0VzY3Jvd1BheW1lbnRRdW90ZVJlcXVlc3Q=');

@$core.Deprecated('Use getIncomingEscrowPaymentQuoteResponseDescriptor instead')
const GetIncomingEscrowPaymentQuoteResponse$json = {
  '1': 'GetIncomingEscrowPaymentQuoteResponse',
  '2': [
    {'1': 'fee', '3': 1, '4': 1, '5': 4, '10': 'fee'},
  ],
};

/// Descriptor for `GetIncomingEscrowPaymentQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomingEscrowPaymentQuoteResponseDescriptor = $convert
    .base64Decode('CiVHZXRJbmNvbWluZ0VzY3Jvd1BheW1lbnRRdW90ZVJlc3BvbnNlEhAKA2ZlZRgBIAEoBFIDZm'
        'Vl');

@$core.Deprecated('Use getOutgoingEscrowPaymentQuoteRequestDescriptor instead')
const GetOutgoingEscrowPaymentQuoteRequest$json = {
  '1': 'GetOutgoingEscrowPaymentQuoteRequest',
};

/// Descriptor for `GetOutgoingEscrowPaymentQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOutgoingEscrowPaymentQuoteRequestDescriptor =
    $convert.base64Decode('CiRHZXRPdXRnb2luZ0VzY3Jvd1BheW1lbnRRdW90ZVJlcXVlc3Q=');

@$core.Deprecated('Use getOutgoingEscrowPaymentQuoteResponseDescriptor instead')
const GetOutgoingEscrowPaymentQuoteResponse$json = {
  '1': 'GetOutgoingEscrowPaymentQuoteResponse',
  '2': [
    {'1': 'fee', '3': 1, '4': 1, '5': 4, '10': 'fee'},
  ],
};

/// Descriptor for `GetOutgoingEscrowPaymentQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOutgoingEscrowPaymentQuoteResponseDescriptor = $convert
    .base64Decode('CiVHZXRPdXRnb2luZ0VzY3Jvd1BheW1lbnRRdW90ZVJlc3BvbnNlEhAKA2ZlZRgBIAEoBFIDZm'
        'Vl');
