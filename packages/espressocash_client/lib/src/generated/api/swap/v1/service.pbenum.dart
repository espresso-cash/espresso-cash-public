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

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SwapMatch extends $pb.ProtobufEnum {
  static const SwapMatch SWAP_MATCH_UNSPECIFIED =
      SwapMatch._(0, _omitEnumNames ? '' : 'SWAP_MATCH_UNSPECIFIED');
  static const SwapMatch SWAP_MATCH_IN_AMOUNT =
      SwapMatch._(1, _omitEnumNames ? '' : 'SWAP_MATCH_IN_AMOUNT');
  static const SwapMatch SWAP_MATCH_OUT_AMOUNT =
      SwapMatch._(2, _omitEnumNames ? '' : 'SWAP_MATCH_OUT_AMOUNT');

  static const $core.List<SwapMatch> values = <SwapMatch>[
    SWAP_MATCH_UNSPECIFIED,
    SWAP_MATCH_IN_AMOUNT,
    SWAP_MATCH_OUT_AMOUNT,
  ];

  static final $core.List<SwapMatch?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SwapMatch? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SwapMatch._(super.value, super.name);
}

class SwapSlippage extends $pb.ProtobufEnum {
  static const SwapSlippage SWAP_SLIPPAGE_UNSPECIFIED =
      SwapSlippage._(0, _omitEnumNames ? '' : 'SWAP_SLIPPAGE_UNSPECIFIED');
  static const SwapSlippage SWAP_SLIPPAGE_ZP_ONE =
      SwapSlippage._(1, _omitEnumNames ? '' : 'SWAP_SLIPPAGE_ZP_ONE');
  static const SwapSlippage SWAP_SLIPPAGE_ZP_FIVE =
      SwapSlippage._(2, _omitEnumNames ? '' : 'SWAP_SLIPPAGE_ZP_FIVE');
  static const SwapSlippage SWAP_SLIPPAGE_ONE_PERCENT =
      SwapSlippage._(3, _omitEnumNames ? '' : 'SWAP_SLIPPAGE_ONE_PERCENT');

  static const $core.List<SwapSlippage> values = <SwapSlippage>[
    SWAP_SLIPPAGE_UNSPECIFIED,
    SWAP_SLIPPAGE_ZP_ONE,
    SWAP_SLIPPAGE_ZP_FIVE,
    SWAP_SLIPPAGE_ONE_PERCENT,
  ];

  static final $core.List<SwapSlippage?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SwapSlippage? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SwapSlippage._(super.value, super.name);
}

const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
