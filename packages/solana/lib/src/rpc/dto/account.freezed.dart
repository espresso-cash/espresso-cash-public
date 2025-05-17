// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  /// Number of lamports assigned to this account, as a u64
  int get lamports => throw _privateConstructorUsedError;

  /// base-58 encoded Pubkey of the program this account has been
  /// assigned to
  String get owner => throw _privateConstructorUsedError;

  /// Data associated with the account, either as encoded binary
  /// data or JSON format {<program>: <state>}, depending on
  /// encoding parameter
  AccountData? get data => throw _privateConstructorUsedError;

  /// Boolean indicating if the account contains a program (and
  /// is strictly read-only)
  bool get executable => throw _privateConstructorUsedError;

  /// The epoch at which this account will next owe rent, as u64
  @JsonKey(fromJson: bigIntFromJson)
  BigInt get rentEpoch => throw _privateConstructorUsedError;

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call({
    int lamports,
    String owner,
    AccountData? data,
    bool executable,
    @JsonKey(fromJson: bigIntFromJson) BigInt rentEpoch,
  });
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account> implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lamports = null,
    Object? owner = null,
    Object? data = freezed,
    Object? executable = null,
    Object? rentEpoch = null,
  }) {
    return _then(
      _value.copyWith(
            lamports:
                null == lamports
                    ? _value.lamports
                    : lamports // ignore: cast_nullable_to_non_nullable
                        as int,
            owner:
                null == owner
                    ? _value.owner
                    : owner // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as AccountData?,
            executable:
                null == executable
                    ? _value.executable
                    : executable // ignore: cast_nullable_to_non_nullable
                        as bool,
            rentEpoch:
                null == rentEpoch
                    ? _value.rentEpoch
                    : rentEpoch // ignore: cast_nullable_to_non_nullable
                        as BigInt,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(_$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int lamports,
    String owner,
    AccountData? data,
    bool executable,
    @JsonKey(fromJson: bigIntFromJson) BigInt rentEpoch,
  });
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res> extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(_$AccountImpl _value, $Res Function(_$AccountImpl) _then)
    : super(_value, _then);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lamports = null,
    Object? owner = null,
    Object? data = freezed,
    Object? executable = null,
    Object? rentEpoch = null,
  }) {
    return _then(
      _$AccountImpl(
        lamports:
            null == lamports
                ? _value.lamports
                : lamports // ignore: cast_nullable_to_non_nullable
                    as int,
        owner:
            null == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as AccountData?,
        executable:
            null == executable
                ? _value.executable
                : executable // ignore: cast_nullable_to_non_nullable
                    as bool,
        rentEpoch:
            null == rentEpoch
                ? _value.rentEpoch
                : rentEpoch // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountImpl implements _Account {
  const _$AccountImpl({
    required this.lamports,
    required this.owner,
    required this.data,
    required this.executable,
    @JsonKey(fromJson: bigIntFromJson) required this.rentEpoch,
  });

  factory _$AccountImpl.fromJson(Map<String, dynamic> json) => _$$AccountImplFromJson(json);

  /// Number of lamports assigned to this account, as a u64
  @override
  final int lamports;

  /// base-58 encoded Pubkey of the program this account has been
  /// assigned to
  @override
  final String owner;

  /// Data associated with the account, either as encoded binary
  /// data or JSON format {program: state}, depending on
  /// encoding parameter
  @override
  final AccountData? data;

  /// Boolean indicating if the account contains a program (and
  /// is strictly read-only)
  @override
  final bool executable;

  /// The epoch at which this account will next owe rent, as u64
  @override
  @JsonKey(fromJson: bigIntFromJson)
  final BigInt rentEpoch;

  @override
  String toString() {
    return 'Account(lamports: $lamports, owner: $owner, data: $data, executable: $executable, rentEpoch: $rentEpoch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.lamports, lamports) || other.lamports == lamports) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.executable, executable) || other.executable == executable) &&
            (identical(other.rentEpoch, rentEpoch) || other.rentEpoch == rentEpoch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lamports, owner, data, executable, rentEpoch);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountImplToJson(this);
  }
}

abstract class _Account implements Account {
  const factory _Account({
    required final int lamports,
    required final String owner,
    required final AccountData? data,
    required final bool executable,
    @JsonKey(fromJson: bigIntFromJson) required final BigInt rentEpoch,
  }) = _$AccountImpl;

  factory _Account.fromJson(Map<String, dynamic> json) = _$AccountImpl.fromJson;

  /// Number of lamports assigned to this account, as a u64
  @override
  int get lamports;

  /// base-58 encoded Pubkey of the program this account has been
  /// assigned to
  @override
  String get owner;

  /// Data associated with the account, either as encoded binary
  /// data or JSON format {<program>: <state>}, depending on
  /// encoding parameter
  @override
  AccountData? get data;

  /// Boolean indicating if the account contains a program (and
  /// is strictly read-only)
  @override
  bool get executable;

  /// The epoch at which this account will next owe rent, as u64
  @override
  @JsonKey(fromJson: bigIntFromJson)
  BigInt get rentEpoch;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith => throw _privateConstructorUsedError;
}
