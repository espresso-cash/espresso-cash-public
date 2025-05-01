//
//  Generated code. Do not modify.
//  source: api/moneygram/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RampType extends $pb.ProtobufEnum {
  static const RampType RAMP_TYPE_UNSPECIFIED =
      RampType._(0, _omitEnumNames ? '' : 'RAMP_TYPE_UNSPECIFIED');
  static const RampType RAMP_TYPE_ON = RampType._(1, _omitEnumNames ? '' : 'RAMP_TYPE_ON');
  static const RampType RAMP_TYPE_OFF = RampType._(2, _omitEnumNames ? '' : 'RAMP_TYPE_OFF');

  static const $core.List<RampType> values = <RampType>[
    RAMP_TYPE_UNSPECIFIED,
    RAMP_TYPE_ON,
    RAMP_TYPE_OFF,
  ];

  static final $core.Map<$core.int, RampType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RampType? valueOf($core.int value) => _byValue[value];

  const RampType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
