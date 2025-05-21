//
//  Generated code. Do not modify.
//  source: api/moneygram/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RampType extends $pb.ProtobufEnum {
  static const RampType RAMP_TYPE_UNSPECIFIED = RampType._(0, _omitEnumNames ? '' : 'RAMP_TYPE_UNSPECIFIED');
  static const RampType RAMP_TYPE_ON = RampType._(1, _omitEnumNames ? '' : 'RAMP_TYPE_ON');
  static const RampType RAMP_TYPE_OFF = RampType._(2, _omitEnumNames ? '' : 'RAMP_TYPE_OFF');

  static const $core.List<RampType> values = <RampType> [
    RAMP_TYPE_UNSPECIFIED,
    RAMP_TYPE_ON,
    RAMP_TYPE_OFF,
  ];

  static final $core.List<RampType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RampType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RampType._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
