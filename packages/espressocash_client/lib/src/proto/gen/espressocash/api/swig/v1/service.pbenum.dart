// This is a generated file - do not edit.
//
// Generated from espressocash/api/swig/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Signing method enumeration
class SigningMethod extends $pb.ProtobufEnum {
  static const SigningMethod SIGNING_METHOD_UNSPECIFIED =
      SigningMethod._(0, _omitEnumNames ? '' : 'SIGNING_METHOD_UNSPECIFIED');

  /// Transaction-level signing (Ed25519-style): client signs entire transaction
  static const SigningMethod SIGNING_METHOD_TRANSACTION =
      SigningMethod._(1, _omitEnumNames ? '' : 'SIGNING_METHOD_TRANSACTION');

  /// Payload-level signing (Secp256k1/r1-style): client signs data payload only
  static const SigningMethod SIGNING_METHOD_PAYLOAD =
      SigningMethod._(2, _omitEnumNames ? '' : 'SIGNING_METHOD_PAYLOAD');

  static const $core.List<SigningMethod> values = <SigningMethod>[
    SIGNING_METHOD_UNSPECIFIED,
    SIGNING_METHOD_TRANSACTION,
    SIGNING_METHOD_PAYLOAD,
  ];

  static final $core.List<SigningMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SigningMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SigningMethod._(super.value, super.name);
}

/// Authority type enumeration
class AuthorityType extends $pb.ProtobufEnum {
  static const AuthorityType AUTHORITY_TYPE_UNSPECIFIED =
      AuthorityType._(0, _omitEnumNames ? '' : 'AUTHORITY_TYPE_UNSPECIFIED');

  /// Ed25519 curve (32-byte keys)
  static const AuthorityType AUTHORITY_TYPE_ED25519 =
      AuthorityType._(1, _omitEnumNames ? '' : 'AUTHORITY_TYPE_ED25519');

  /// Secp256k1 curve (33-byte compressed keys)
  static const AuthorityType AUTHORITY_TYPE_SECP256K1 =
      AuthorityType._(3, _omitEnumNames ? '' : 'AUTHORITY_TYPE_SECP256K1');

  /// Secp256r1 curve (64-byte keys for passkeys/WebAuthn)
  static const AuthorityType AUTHORITY_TYPE_SECP256R1 =
      AuthorityType._(5, _omitEnumNames ? '' : 'AUTHORITY_TYPE_SECP256R1');

  static const $core.List<AuthorityType> values = <AuthorityType>[
    AUTHORITY_TYPE_UNSPECIFIED,
    AUTHORITY_TYPE_ED25519,
    AUTHORITY_TYPE_SECP256K1,
    AUTHORITY_TYPE_SECP256R1,
  ];

  static final $core.Map<$core.int, AuthorityType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AuthorityType? valueOf($core.int value) => _byValue[value];

  const AuthorityType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
