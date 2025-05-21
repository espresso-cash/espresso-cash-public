//
//  Generated code. Do not modify.
//  source: api/dln/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DlnOrderStatus extends $pb.ProtobufEnum {
  static const DlnOrderStatus DLN_ORDER_STATUS_NONE = DlnOrderStatus._(0, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_NONE');
  static const DlnOrderStatus DLN_ORDER_STATUS_CREATED = DlnOrderStatus._(1, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_CREATED');
  static const DlnOrderStatus DLN_ORDER_STATUS_FULFILLED = DlnOrderStatus._(2, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_FULFILLED');
  static const DlnOrderStatus DLN_ORDER_STATUS_SENT_UNLOCK = DlnOrderStatus._(3, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_SENT_UNLOCK');
  static const DlnOrderStatus DLN_ORDER_STATUS_ORDER_CANCELLED = DlnOrderStatus._(4, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_ORDER_CANCELLED');
  static const DlnOrderStatus DLN_ORDER_STATUS_SENT_ORDER_CANCEL = DlnOrderStatus._(5, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_SENT_ORDER_CANCEL');
  static const DlnOrderStatus DLN_ORDER_STATUS_CLAIMED_UNLOCK = DlnOrderStatus._(6, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_CLAIMED_UNLOCK');
  static const DlnOrderStatus DLN_ORDER_STATUS_CLAIMED_ORDER_CANCEL = DlnOrderStatus._(7, _omitEnumNames ? '' : 'DLN_ORDER_STATUS_CLAIMED_ORDER_CANCEL');

  static const $core.List<DlnOrderStatus> values = <DlnOrderStatus> [
    DLN_ORDER_STATUS_NONE,
    DLN_ORDER_STATUS_CREATED,
    DLN_ORDER_STATUS_FULFILLED,
    DLN_ORDER_STATUS_SENT_UNLOCK,
    DLN_ORDER_STATUS_ORDER_CANCELLED,
    DLN_ORDER_STATUS_SENT_ORDER_CANCEL,
    DLN_ORDER_STATUS_CLAIMED_UNLOCK,
    DLN_ORDER_STATUS_CLAIMED_ORDER_CANCEL,
  ];

  static final $core.List<DlnOrderStatus?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 7);
  static DlnOrderStatus? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DlnOrderStatus._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
