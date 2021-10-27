// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationParamsSignature _$NotificationParamsSignatureFromJson(
    Map<String, dynamic> json) {
  return _NotificationParamsSignature.fromJson(json);
}

/// @nodoc
class _$NotificationParamsSignatureTearOff {
  const _$NotificationParamsSignatureTearOff();

  _NotificationParamsSignature call(
      {required NotificationResult<OptionalError> result,
      required int subscription}) {
    return _NotificationParamsSignature(
      result: result,
      subscription: subscription,
    );
  }

  NotificationParamsSignature fromJson(Map<String, Object> json) {
    return NotificationParamsSignature.fromJson(json);
  }
}

/// @nodoc
const $NotificationParamsSignature = _$NotificationParamsSignatureTearOff();

/// @nodoc
mixin _$NotificationParamsSignature {
  NotificationResult<OptionalError> get result =>
      throw _privateConstructorUsedError;
  int get subscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationParamsSignatureCopyWith<NotificationParamsSignature>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationParamsSignatureCopyWith<$Res> {
  factory $NotificationParamsSignatureCopyWith(
          NotificationParamsSignature value,
          $Res Function(NotificationParamsSignature) then) =
      _$NotificationParamsSignatureCopyWithImpl<$Res>;
  $Res call({NotificationResult<OptionalError> result, int subscription});
}

/// @nodoc
class _$NotificationParamsSignatureCopyWithImpl<$Res>
    implements $NotificationParamsSignatureCopyWith<$Res> {
  _$NotificationParamsSignatureCopyWithImpl(this._value, this._then);

  final NotificationParamsSignature _value;
  // ignore: unused_field
  final $Res Function(NotificationParamsSignature) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<OptionalError>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotificationParamsSignatureCopyWith<$Res>
    implements $NotificationParamsSignatureCopyWith<$Res> {
  factory _$NotificationParamsSignatureCopyWith(
          _NotificationParamsSignature value,
          $Res Function(_NotificationParamsSignature) then) =
      __$NotificationParamsSignatureCopyWithImpl<$Res>;
  @override
  $Res call({NotificationResult<OptionalError> result, int subscription});
}

/// @nodoc
class __$NotificationParamsSignatureCopyWithImpl<$Res>
    extends _$NotificationParamsSignatureCopyWithImpl<$Res>
    implements _$NotificationParamsSignatureCopyWith<$Res> {
  __$NotificationParamsSignatureCopyWithImpl(
      _NotificationParamsSignature _value,
      $Res Function(_NotificationParamsSignature) _then)
      : super(_value, (v) => _then(v as _NotificationParamsSignature));

  @override
  _NotificationParamsSignature get _value =>
      super._value as _NotificationParamsSignature;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_NotificationParamsSignature(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<OptionalError>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationParamsSignature implements _NotificationParamsSignature {
  const _$_NotificationParamsSignature(
      {required this.result, required this.subscription});

  factory _$_NotificationParamsSignature.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationParamsSignatureFromJson(json);

  @override
  final NotificationResult<OptionalError> result;
  @override
  final int subscription;

  @override
  String toString() {
    return 'NotificationParamsSignature(result: $result, subscription: $subscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationParamsSignature &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(subscription);

  @JsonKey(ignore: true)
  @override
  _$NotificationParamsSignatureCopyWith<_NotificationParamsSignature>
      get copyWith => __$NotificationParamsSignatureCopyWithImpl<
          _NotificationParamsSignature>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationParamsSignatureToJson(this);
  }
}

abstract class _NotificationParamsSignature
    implements NotificationParamsSignature {
  const factory _NotificationParamsSignature(
      {required NotificationResult<OptionalError> result,
      required int subscription}) = _$_NotificationParamsSignature;

  factory _NotificationParamsSignature.fromJson(Map<String, dynamic> json) =
      _$_NotificationParamsSignature.fromJson;

  @override
  NotificationResult<OptionalError> get result =>
      throw _privateConstructorUsedError;
  @override
  int get subscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationParamsSignatureCopyWith<_NotificationParamsSignature>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationParamsLogs _$NotificationParamsLogsFromJson(
    Map<String, dynamic> json) {
  return _NotificationParamsLogs.fromJson(json);
}

/// @nodoc
class _$NotificationParamsLogsTearOff {
  const _$NotificationParamsLogsTearOff();

  _NotificationParamsLogs call(
      {required NotificationResult<Logs> result, required int subscription}) {
    return _NotificationParamsLogs(
      result: result,
      subscription: subscription,
    );
  }

  NotificationParamsLogs fromJson(Map<String, Object> json) {
    return NotificationParamsLogs.fromJson(json);
  }
}

/// @nodoc
const $NotificationParamsLogs = _$NotificationParamsLogsTearOff();

/// @nodoc
mixin _$NotificationParamsLogs {
  NotificationResult<Logs> get result => throw _privateConstructorUsedError;
  int get subscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationParamsLogsCopyWith<NotificationParamsLogs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationParamsLogsCopyWith<$Res> {
  factory $NotificationParamsLogsCopyWith(NotificationParamsLogs value,
          $Res Function(NotificationParamsLogs) then) =
      _$NotificationParamsLogsCopyWithImpl<$Res>;
  $Res call({NotificationResult<Logs> result, int subscription});
}

/// @nodoc
class _$NotificationParamsLogsCopyWithImpl<$Res>
    implements $NotificationParamsLogsCopyWith<$Res> {
  _$NotificationParamsLogsCopyWithImpl(this._value, this._then);

  final NotificationParamsLogs _value;
  // ignore: unused_field
  final $Res Function(NotificationParamsLogs) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Logs>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotificationParamsLogsCopyWith<$Res>
    implements $NotificationParamsLogsCopyWith<$Res> {
  factory _$NotificationParamsLogsCopyWith(_NotificationParamsLogs value,
          $Res Function(_NotificationParamsLogs) then) =
      __$NotificationParamsLogsCopyWithImpl<$Res>;
  @override
  $Res call({NotificationResult<Logs> result, int subscription});
}

/// @nodoc
class __$NotificationParamsLogsCopyWithImpl<$Res>
    extends _$NotificationParamsLogsCopyWithImpl<$Res>
    implements _$NotificationParamsLogsCopyWith<$Res> {
  __$NotificationParamsLogsCopyWithImpl(_NotificationParamsLogs _value,
      $Res Function(_NotificationParamsLogs) _then)
      : super(_value, (v) => _then(v as _NotificationParamsLogs));

  @override
  _NotificationParamsLogs get _value => super._value as _NotificationParamsLogs;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_NotificationParamsLogs(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Logs>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationParamsLogs implements _NotificationParamsLogs {
  const _$_NotificationParamsLogs(
      {required this.result, required this.subscription});

  factory _$_NotificationParamsLogs.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationParamsLogsFromJson(json);

  @override
  final NotificationResult<Logs> result;
  @override
  final int subscription;

  @override
  String toString() {
    return 'NotificationParamsLogs(result: $result, subscription: $subscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationParamsLogs &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(subscription);

  @JsonKey(ignore: true)
  @override
  _$NotificationParamsLogsCopyWith<_NotificationParamsLogs> get copyWith =>
      __$NotificationParamsLogsCopyWithImpl<_NotificationParamsLogs>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationParamsLogsToJson(this);
  }
}

abstract class _NotificationParamsLogs implements NotificationParamsLogs {
  const factory _NotificationParamsLogs(
      {required NotificationResult<Logs> result,
      required int subscription}) = _$_NotificationParamsLogs;

  factory _NotificationParamsLogs.fromJson(Map<String, dynamic> json) =
      _$_NotificationParamsLogs.fromJson;

  @override
  NotificationResult<Logs> get result => throw _privateConstructorUsedError;
  @override
  int get subscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationParamsLogsCopyWith<_NotificationParamsLogs> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationParamsSlot _$NotificationParamsSlotFromJson(
    Map<String, dynamic> json) {
  return _NotificationParamsSlot.fromJson(json);
}

/// @nodoc
class _$NotificationParamsSlotTearOff {
  const _$NotificationParamsSlotTearOff();

  _NotificationParamsSlot call(
      {required NotificationResult<Slot> result, required int subscription}) {
    return _NotificationParamsSlot(
      result: result,
      subscription: subscription,
    );
  }

  NotificationParamsSlot fromJson(Map<String, Object> json) {
    return NotificationParamsSlot.fromJson(json);
  }
}

/// @nodoc
const $NotificationParamsSlot = _$NotificationParamsSlotTearOff();

/// @nodoc
mixin _$NotificationParamsSlot {
  NotificationResult<Slot> get result => throw _privateConstructorUsedError;
  int get subscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationParamsSlotCopyWith<NotificationParamsSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationParamsSlotCopyWith<$Res> {
  factory $NotificationParamsSlotCopyWith(NotificationParamsSlot value,
          $Res Function(NotificationParamsSlot) then) =
      _$NotificationParamsSlotCopyWithImpl<$Res>;
  $Res call({NotificationResult<Slot> result, int subscription});
}

/// @nodoc
class _$NotificationParamsSlotCopyWithImpl<$Res>
    implements $NotificationParamsSlotCopyWith<$Res> {
  _$NotificationParamsSlotCopyWithImpl(this._value, this._then);

  final NotificationParamsSlot _value;
  // ignore: unused_field
  final $Res Function(NotificationParamsSlot) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Slot>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotificationParamsSlotCopyWith<$Res>
    implements $NotificationParamsSlotCopyWith<$Res> {
  factory _$NotificationParamsSlotCopyWith(_NotificationParamsSlot value,
          $Res Function(_NotificationParamsSlot) then) =
      __$NotificationParamsSlotCopyWithImpl<$Res>;
  @override
  $Res call({NotificationResult<Slot> result, int subscription});
}

/// @nodoc
class __$NotificationParamsSlotCopyWithImpl<$Res>
    extends _$NotificationParamsSlotCopyWithImpl<$Res>
    implements _$NotificationParamsSlotCopyWith<$Res> {
  __$NotificationParamsSlotCopyWithImpl(_NotificationParamsSlot _value,
      $Res Function(_NotificationParamsSlot) _then)
      : super(_value, (v) => _then(v as _NotificationParamsSlot));

  @override
  _NotificationParamsSlot get _value => super._value as _NotificationParamsSlot;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_NotificationParamsSlot(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Slot>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationParamsSlot implements _NotificationParamsSlot {
  const _$_NotificationParamsSlot(
      {required this.result, required this.subscription});

  factory _$_NotificationParamsSlot.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationParamsSlotFromJson(json);

  @override
  final NotificationResult<Slot> result;
  @override
  final int subscription;

  @override
  String toString() {
    return 'NotificationParamsSlot(result: $result, subscription: $subscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationParamsSlot &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(subscription);

  @JsonKey(ignore: true)
  @override
  _$NotificationParamsSlotCopyWith<_NotificationParamsSlot> get copyWith =>
      __$NotificationParamsSlotCopyWithImpl<_NotificationParamsSlot>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationParamsSlotToJson(this);
  }
}

abstract class _NotificationParamsSlot implements NotificationParamsSlot {
  const factory _NotificationParamsSlot(
      {required NotificationResult<Slot> result,
      required int subscription}) = _$_NotificationParamsSlot;

  factory _NotificationParamsSlot.fromJson(Map<String, dynamic> json) =
      _$_NotificationParamsSlot.fromJson;

  @override
  NotificationResult<Slot> get result => throw _privateConstructorUsedError;
  @override
  int get subscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationParamsSlotCopyWith<_NotificationParamsSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationParamsAccount _$NotificationParamsAccountFromJson(
    Map<String, dynamic> json) {
  return _NotificationParamsAccount.fromJson(json);
}

/// @nodoc
class _$NotificationParamsAccountTearOff {
  const _$NotificationParamsAccountTearOff();

  _NotificationParamsAccount call(
      {required NotificationResult<Account> result,
      required int subscription}) {
    return _NotificationParamsAccount(
      result: result,
      subscription: subscription,
    );
  }

  NotificationParamsAccount fromJson(Map<String, Object> json) {
    return NotificationParamsAccount.fromJson(json);
  }
}

/// @nodoc
const $NotificationParamsAccount = _$NotificationParamsAccountTearOff();

/// @nodoc
mixin _$NotificationParamsAccount {
  NotificationResult<Account> get result => throw _privateConstructorUsedError;
  int get subscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationParamsAccountCopyWith<NotificationParamsAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationParamsAccountCopyWith<$Res> {
  factory $NotificationParamsAccountCopyWith(NotificationParamsAccount value,
          $Res Function(NotificationParamsAccount) then) =
      _$NotificationParamsAccountCopyWithImpl<$Res>;
  $Res call({NotificationResult<Account> result, int subscription});
}

/// @nodoc
class _$NotificationParamsAccountCopyWithImpl<$Res>
    implements $NotificationParamsAccountCopyWith<$Res> {
  _$NotificationParamsAccountCopyWithImpl(this._value, this._then);

  final NotificationParamsAccount _value;
  // ignore: unused_field
  final $Res Function(NotificationParamsAccount) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Account>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotificationParamsAccountCopyWith<$Res>
    implements $NotificationParamsAccountCopyWith<$Res> {
  factory _$NotificationParamsAccountCopyWith(_NotificationParamsAccount value,
          $Res Function(_NotificationParamsAccount) then) =
      __$NotificationParamsAccountCopyWithImpl<$Res>;
  @override
  $Res call({NotificationResult<Account> result, int subscription});
}

/// @nodoc
class __$NotificationParamsAccountCopyWithImpl<$Res>
    extends _$NotificationParamsAccountCopyWithImpl<$Res>
    implements _$NotificationParamsAccountCopyWith<$Res> {
  __$NotificationParamsAccountCopyWithImpl(_NotificationParamsAccount _value,
      $Res Function(_NotificationParamsAccount) _then)
      : super(_value, (v) => _then(v as _NotificationParamsAccount));

  @override
  _NotificationParamsAccount get _value =>
      super._value as _NotificationParamsAccount;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_NotificationParamsAccount(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Account>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationParamsAccount implements _NotificationParamsAccount {
  const _$_NotificationParamsAccount(
      {required this.result, required this.subscription});

  factory _$_NotificationParamsAccount.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationParamsAccountFromJson(json);

  @override
  final NotificationResult<Account> result;
  @override
  final int subscription;

  @override
  String toString() {
    return 'NotificationParamsAccount(result: $result, subscription: $subscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationParamsAccount &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(subscription);

  @JsonKey(ignore: true)
  @override
  _$NotificationParamsAccountCopyWith<_NotificationParamsAccount>
      get copyWith =>
          __$NotificationParamsAccountCopyWithImpl<_NotificationParamsAccount>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationParamsAccountToJson(this);
  }
}

abstract class _NotificationParamsAccount implements NotificationParamsAccount {
  const factory _NotificationParamsAccount(
      {required NotificationResult<Account> result,
      required int subscription}) = _$_NotificationParamsAccount;

  factory _NotificationParamsAccount.fromJson(Map<String, dynamic> json) =
      _$_NotificationParamsAccount.fromJson;

  @override
  NotificationResult<Account> get result => throw _privateConstructorUsedError;
  @override
  int get subscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationParamsAccountCopyWith<_NotificationParamsAccount>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationParamsGeneric _$NotificationParamsGenericFromJson(
    Map<String, dynamic> json) {
  return _NotificationParamsGeneric.fromJson(json);
}

/// @nodoc
class _$NotificationParamsGenericTearOff {
  const _$NotificationParamsGenericTearOff();

  _NotificationParamsGeneric call(
      {required NotificationResult<Map<String, dynamic>> result,
      required int subscription}) {
    return _NotificationParamsGeneric(
      result: result,
      subscription: subscription,
    );
  }

  NotificationParamsGeneric fromJson(Map<String, Object> json) {
    return NotificationParamsGeneric.fromJson(json);
  }
}

/// @nodoc
const $NotificationParamsGeneric = _$NotificationParamsGenericTearOff();

/// @nodoc
mixin _$NotificationParamsGeneric {
  NotificationResult<Map<String, dynamic>> get result =>
      throw _privateConstructorUsedError;
  int get subscription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationParamsGenericCopyWith<NotificationParamsGeneric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationParamsGenericCopyWith<$Res> {
  factory $NotificationParamsGenericCopyWith(NotificationParamsGeneric value,
          $Res Function(NotificationParamsGeneric) then) =
      _$NotificationParamsGenericCopyWithImpl<$Res>;
  $Res call(
      {NotificationResult<Map<String, dynamic>> result, int subscription});
}

/// @nodoc
class _$NotificationParamsGenericCopyWithImpl<$Res>
    implements $NotificationParamsGenericCopyWith<$Res> {
  _$NotificationParamsGenericCopyWithImpl(this._value, this._then);

  final NotificationParamsGeneric _value;
  // ignore: unused_field
  final $Res Function(NotificationParamsGeneric) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Map<String, dynamic>>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotificationParamsGenericCopyWith<$Res>
    implements $NotificationParamsGenericCopyWith<$Res> {
  factory _$NotificationParamsGenericCopyWith(_NotificationParamsGeneric value,
          $Res Function(_NotificationParamsGeneric) then) =
      __$NotificationParamsGenericCopyWithImpl<$Res>;
  @override
  $Res call(
      {NotificationResult<Map<String, dynamic>> result, int subscription});
}

/// @nodoc
class __$NotificationParamsGenericCopyWithImpl<$Res>
    extends _$NotificationParamsGenericCopyWithImpl<$Res>
    implements _$NotificationParamsGenericCopyWith<$Res> {
  __$NotificationParamsGenericCopyWithImpl(_NotificationParamsGeneric _value,
      $Res Function(_NotificationParamsGeneric) _then)
      : super(_value, (v) => _then(v as _NotificationParamsGeneric));

  @override
  _NotificationParamsGeneric get _value =>
      super._value as _NotificationParamsGeneric;

  @override
  $Res call({
    Object? result = freezed,
    Object? subscription = freezed,
  }) {
    return _then(_NotificationParamsGeneric(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as NotificationResult<Map<String, dynamic>>,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationParamsGeneric implements _NotificationParamsGeneric {
  const _$_NotificationParamsGeneric(
      {required this.result, required this.subscription});

  factory _$_NotificationParamsGeneric.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationParamsGenericFromJson(json);

  @override
  final NotificationResult<Map<String, dynamic>> result;
  @override
  final int subscription;

  @override
  String toString() {
    return 'NotificationParamsGeneric(result: $result, subscription: $subscription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationParamsGeneric &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(result) ^
      const DeepCollectionEquality().hash(subscription);

  @JsonKey(ignore: true)
  @override
  _$NotificationParamsGenericCopyWith<_NotificationParamsGeneric>
      get copyWith =>
          __$NotificationParamsGenericCopyWithImpl<_NotificationParamsGeneric>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationParamsGenericToJson(this);
  }
}

abstract class _NotificationParamsGeneric implements NotificationParamsGeneric {
  const factory _NotificationParamsGeneric(
      {required NotificationResult<Map<String, dynamic>> result,
      required int subscription}) = _$_NotificationParamsGeneric;

  factory _NotificationParamsGeneric.fromJson(Map<String, dynamic> json) =
      _$_NotificationParamsGeneric.fromJson;

  @override
  NotificationResult<Map<String, dynamic>> get result =>
      throw _privateConstructorUsedError;
  @override
  int get subscription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationParamsGenericCopyWith<_NotificationParamsGeneric>
      get copyWith => throw _privateConstructorUsedError;
}
