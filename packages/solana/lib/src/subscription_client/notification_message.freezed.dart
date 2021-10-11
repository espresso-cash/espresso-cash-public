// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) {
  switch (json['method'] as String?) {
    case 'accountNotification':
      return AccountNotification.fromJson(json);

    default:
      return _UnsupportedNotification.fromJson(json);
  }
}

/// @nodoc
class _$NotificationMessageTearOff {
  const _$NotificationMessageTearOff();

  _UnsupportedNotification unsupported() {
    return const _UnsupportedNotification();
  }

  AccountNotification accountNotification(
      {required NotificationParams<Account> params}) {
    return AccountNotification(
      params: params,
    );
  }

  NotificationMessage fromJson(Map<String, Object> json) {
    return NotificationMessage.fromJson(json);
  }
}

/// @nodoc
const $NotificationMessage = _$NotificationMessageTearOff();

/// @nodoc
mixin _$NotificationMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMessageCopyWith<$Res> {
  factory $NotificationMessageCopyWith(
          NotificationMessage value, $Res Function(NotificationMessage) then) =
      _$NotificationMessageCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotificationMessageCopyWithImpl<$Res>
    implements $NotificationMessageCopyWith<$Res> {
  _$NotificationMessageCopyWithImpl(this._value, this._then);

  final NotificationMessage _value;
  // ignore: unused_field
  final $Res Function(NotificationMessage) _then;
}

/// @nodoc
abstract class _$UnsupportedNotificationCopyWith<$Res> {
  factory _$UnsupportedNotificationCopyWith(_UnsupportedNotification value,
          $Res Function(_UnsupportedNotification) then) =
      __$UnsupportedNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class __$UnsupportedNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements _$UnsupportedNotificationCopyWith<$Res> {
  __$UnsupportedNotificationCopyWithImpl(_UnsupportedNotification _value,
      $Res Function(_UnsupportedNotification) _then)
      : super(_value, (v) => _then(v as _UnsupportedNotification));

  @override
  _UnsupportedNotification get _value =>
      super._value as _UnsupportedNotification;
}

/// @nodoc
@JsonSerializable()
class _$_UnsupportedNotification extends _UnsupportedNotification {
  const _$_UnsupportedNotification() : super._();

  factory _$_UnsupportedNotification.fromJson(Map<String, dynamic> json) =>
      _$$_UnsupportedNotificationFromJson(json);

  @override
  String toString() {
    return 'NotificationMessage.unsupported()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _UnsupportedNotification);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
  }) {
    return unsupported();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
  }) {
    return unsupported?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnsupportedNotificationToJson(this)..['method'] = 'unsupported';
  }
}

abstract class _UnsupportedNotification extends NotificationMessage {
  const factory _UnsupportedNotification() = _$_UnsupportedNotification;
  const _UnsupportedNotification._() : super._();

  factory _UnsupportedNotification.fromJson(Map<String, dynamic> json) =
      _$_UnsupportedNotification.fromJson;
}

/// @nodoc
abstract class $AccountNotificationCopyWith<$Res> {
  factory $AccountNotificationCopyWith(
          AccountNotification value, $Res Function(AccountNotification) then) =
      _$AccountNotificationCopyWithImpl<$Res>;
  $Res call({NotificationParams<Account> params});
}

/// @nodoc
class _$AccountNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements $AccountNotificationCopyWith<$Res> {
  _$AccountNotificationCopyWithImpl(
      AccountNotification _value, $Res Function(AccountNotification) _then)
      : super(_value, (v) => _then(v as AccountNotification));

  @override
  AccountNotification get _value => super._value as AccountNotification;

  @override
  $Res call({
    Object? params = freezed,
  }) {
    return _then(AccountNotification(
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<Account>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountNotification extends AccountNotification {
  const _$AccountNotification({required this.params}) : super._();

  factory _$AccountNotification.fromJson(Map<String, dynamic> json) =>
      _$$AccountNotificationFromJson(json);

  @override
  final NotificationParams<Account> params;

  @override
  String toString() {
    return 'NotificationMessage.accountNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccountNotification &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(params);

  @JsonKey(ignore: true)
  @override
  $AccountNotificationCopyWith<AccountNotification> get copyWith =>
      _$AccountNotificationCopyWithImpl<AccountNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
  }) {
    return accountNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
  }) {
    return accountNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    required TResult orElse(),
  }) {
    if (accountNotification != null) {
      return accountNotification(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
  }) {
    return accountNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
  }) {
    return accountNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    required TResult orElse(),
  }) {
    if (accountNotification != null) {
      return accountNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountNotificationToJson(this)
      ..['method'] = 'accountNotification';
  }
}

abstract class AccountNotification extends NotificationMessage {
  const factory AccountNotification(
      {required NotificationParams<Account> params}) = _$AccountNotification;
  const AccountNotification._() : super._();

  factory AccountNotification.fromJson(Map<String, dynamic> json) =
      _$AccountNotification.fromJson;

  NotificationParams<Account> get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountNotificationCopyWith<AccountNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
