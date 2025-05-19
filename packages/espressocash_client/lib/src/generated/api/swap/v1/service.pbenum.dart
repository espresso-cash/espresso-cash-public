//
//  Generated code. Do not modify.
//  source: api/swap/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

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

  static final $core.Map<$core.int, SwapMatch> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SwapMatch? valueOf($core.int value) => _byValue[value];

  const SwapMatch._($core.int v, $core.String n) : super(v, n);
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

  static final $core.Map<$core.int, SwapSlippage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SwapSlippage? valueOf($core.int value) => _byValue[value];

  const SwapSlippage._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
