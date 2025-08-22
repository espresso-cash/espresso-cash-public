// This is a generated file - do not edit.
//
// Generated from espressocash/api/transactionlink/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Transaction status enum
class TransactionStatus extends $pb.ProtobufEnum {
  static const TransactionStatus TRANSACTION_STATUS_UNSPECIFIED =
      TransactionStatus._(
          0, _omitEnumNames ? '' : 'TRANSACTION_STATUS_UNSPECIFIED');
  static const TransactionStatus TRANSACTION_STATUS_PENDING =
      TransactionStatus._(
          1, _omitEnumNames ? '' : 'TRANSACTION_STATUS_PENDING');
  static const TransactionStatus TRANSACTION_STATUS_SIGNED =
      TransactionStatus._(2, _omitEnumNames ? '' : 'TRANSACTION_STATUS_SIGNED');
  static const TransactionStatus TRANSACTION_STATUS_SUBMITTED =
      TransactionStatus._(
          3, _omitEnumNames ? '' : 'TRANSACTION_STATUS_SUBMITTED');
  static const TransactionStatus TRANSACTION_STATUS_CONFIRMED =
      TransactionStatus._(
          4, _omitEnumNames ? '' : 'TRANSACTION_STATUS_CONFIRMED');
  static const TransactionStatus TRANSACTION_STATUS_FAILED =
      TransactionStatus._(5, _omitEnumNames ? '' : 'TRANSACTION_STATUS_FAILED');
  static const TransactionStatus TRANSACTION_STATUS_EXPIRED =
      TransactionStatus._(
          6, _omitEnumNames ? '' : 'TRANSACTION_STATUS_EXPIRED');

  static const $core.List<TransactionStatus> values = <TransactionStatus>[
    TRANSACTION_STATUS_UNSPECIFIED,
    TRANSACTION_STATUS_PENDING,
    TRANSACTION_STATUS_SIGNED,
    TRANSACTION_STATUS_SUBMITTED,
    TRANSACTION_STATUS_CONFIRMED,
    TRANSACTION_STATUS_FAILED,
    TRANSACTION_STATUS_EXPIRED,
  ];

  static final $core.List<TransactionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static TransactionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransactionStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
