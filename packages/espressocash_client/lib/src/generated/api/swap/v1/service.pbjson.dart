//
//  Generated code. Do not modify.
//  source: api/swap/v1/service.proto
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

@$core.Deprecated('Use swapMatchDescriptor instead')
const SwapMatch$json = {
  '1': 'SwapMatch',
  '2': [
    {'1': 'SWAP_MATCH_UNSPECIFIED', '2': 0},
    {'1': 'SWAP_MATCH_IN_AMOUNT', '2': 1},
    {'1': 'SWAP_MATCH_OUT_AMOUNT', '2': 2},
  ],
};

/// Descriptor for `SwapMatch`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List swapMatchDescriptor = $convert
    .base64Decode('CglTd2FwTWF0Y2gSGgoWU1dBUF9NQVRDSF9VTlNQRUNJRklFRBAAEhgKFFNXQVBfTUFUQ0hfSU'
        '5fQU1PVU5UEAESGQoVU1dBUF9NQVRDSF9PVVRfQU1PVU5UEAI=');

@$core.Deprecated('Use swapSlippageDescriptor instead')
const SwapSlippage$json = {
  '1': 'SwapSlippage',
  '2': [
    {'1': 'SWAP_SLIPPAGE_UNSPECIFIED', '2': 0},
    {'1': 'SWAP_SLIPPAGE_ZP_ONE', '2': 1},
    {'1': 'SWAP_SLIPPAGE_ZP_FIVE', '2': 2},
    {'1': 'SWAP_SLIPPAGE_ONE_PERCENT', '2': 3},
  ],
};

/// Descriptor for `SwapSlippage`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List swapSlippageDescriptor = $convert
    .base64Decode('CgxTd2FwU2xpcHBhZ2USHQoZU1dBUF9TTElQUEFHRV9VTlNQRUNJRklFRBAAEhgKFFNXQVBfU0'
        'xJUFBBR0VfWlBfT05FEAESGQoVU1dBUF9TTElQUEFHRV9aUF9GSVZFEAISHQoZU1dBUF9TTElQ'
        'UEFHRV9PTkVfUEVSQ0VOVBAD');

@$core.Deprecated('Use swapRouteRequestDescriptor instead')
const SwapRouteRequest$json = {
  '1': 'SwapRouteRequest',
  '2': [
    {'1': 'input_token', '3': 1, '4': 1, '5': 9, '10': 'inputToken'},
    {'1': 'output_token', '3': 2, '4': 1, '5': 9, '10': 'outputToken'},
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '10': 'amount'},
    {
      '1': 'match',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.swap.v1.SwapMatch',
      '10': 'match'
    },
    {
      '1': 'slippage',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.espressocash.api.swap.v1.SwapSlippage',
      '10': 'slippage'
    },
  ],
};

/// Descriptor for `SwapRouteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List swapRouteRequestDescriptor = $convert
    .base64Decode('ChBTd2FwUm91dGVSZXF1ZXN0Eh8KC2lucHV0X3Rva2VuGAEgASgJUgppbnB1dFRva2VuEiEKDG'
        '91dHB1dF90b2tlbhgCIAEoCVILb3V0cHV0VG9rZW4SFgoGYW1vdW50GAMgASgJUgZhbW91bnQS'
        'OQoFbWF0Y2gYBCABKA4yIy5lc3ByZXNzb2Nhc2guYXBpLnN3YXAudjEuU3dhcE1hdGNoUgVtYX'
        'RjaBJCCghzbGlwcGFnZRgFIAEoDjImLmVzcHJlc3NvY2FzaC5hcGkuc3dhcC52MS5Td2FwU2xp'
        'cHBhZ2VSCHNsaXBwYWdl');

@$core.Deprecated('Use swapRouteResponseDescriptor instead')
const SwapRouteResponse$json = {
  '1': 'SwapRouteResponse',
  '2': [
    {'1': 'in_amount', '3': 1, '4': 1, '5': 9, '10': 'inAmount'},
    {'1': 'out_amount', '3': 2, '4': 1, '5': 9, '10': 'outAmount'},
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '10': 'amount'},
    {'1': 'encoded_tx', '3': 4, '4': 1, '5': 9, '10': 'encodedTx'},
    {'1': 'fee_in_usdc', '3': 5, '4': 1, '5': 5, '10': 'feeInUsdc'},
    {'1': 'slot', '3': 6, '4': 1, '5': 3, '10': 'slot'},
    {'1': 'slippage_bps', '3': 7, '4': 1, '5': 5, '10': 'slippageBps'},
    {'1': 'platform_fee_bps', '3': 8, '4': 1, '5': 5, '10': 'platformFeeBps'},
    {'1': 'price_impact', '3': 9, '4': 1, '5': 9, '10': 'priceImpact'},
    {'1': 'provider_label', '3': 10, '4': 1, '5': 9, '10': 'providerLabel'},
  ],
};

/// Descriptor for `SwapRouteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List swapRouteResponseDescriptor = $convert
    .base64Decode('ChFTd2FwUm91dGVSZXNwb25zZRIbCglpbl9hbW91bnQYASABKAlSCGluQW1vdW50Eh0KCm91dF'
        '9hbW91bnQYAiABKAlSCW91dEFtb3VudBIWCgZhbW91bnQYAyABKAlSBmFtb3VudBIdCgplbmNv'
        'ZGVkX3R4GAQgASgJUgllbmNvZGVkVHgSHgoLZmVlX2luX3VzZGMYBSABKAVSCWZlZUluVXNkYx'
        'ISCgRzbG90GAYgASgDUgRzbG90EiEKDHNsaXBwYWdlX2JwcxgHIAEoBVILc2xpcHBhZ2VCcHMS'
        'KAoQcGxhdGZvcm1fZmVlX2JwcxgIIAEoBVIOcGxhdGZvcm1GZWVCcHMSIQoMcHJpY2VfaW1wYW'
        'N0GAkgASgJUgtwcmljZUltcGFjdBIlCg5wcm92aWRlcl9sYWJlbBgKIAEoCVINcHJvdmlkZXJM'
        'YWJlbA==');
