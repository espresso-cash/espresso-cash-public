// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) {
  switch (json['method']) {
    case 'accountNotification':
      return AccountNotification.fromJson(json);
    case 'logsNotification':
      return LogsNotification.fromJson(json);
    case 'programNotification':
      return ProgramNotification.fromJson(json);
    case 'signatureNotification':
      return SignatureNotification.fromJson(json);
    case 'slotNotification':
      return SlotNotification.fromJson(json);

    default:
      return _UnsupportedNotification.fromJson(json);
  }
}

/// @nodoc
mixin _$NotificationMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMessageCopyWith<$Res> {
  factory $NotificationMessageCopyWith(
          NotificationMessage value, $Res Function(NotificationMessage) then) =
      _$NotificationMessageCopyWithImpl<$Res, NotificationMessage>;
}

/// @nodoc
class _$NotificationMessageCopyWithImpl<$Res, $Val extends NotificationMessage>
    implements $NotificationMessageCopyWith<$Res> {
  _$NotificationMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_UnsupportedNotificationCopyWith<$Res> {
  factory _$$_UnsupportedNotificationCopyWith(_$_UnsupportedNotification value,
          $Res Function(_$_UnsupportedNotification) then) =
      __$$_UnsupportedNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnsupportedNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$_UnsupportedNotification>
    implements _$$_UnsupportedNotificationCopyWith<$Res> {
  __$$_UnsupportedNotificationCopyWithImpl(_$_UnsupportedNotification _value,
      $Res Function(_$_UnsupportedNotification) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_UnsupportedNotification extends _UnsupportedNotification {
  const _$_UnsupportedNotification({final String? $type})
      : $type = $type ?? 'unsupported',
        super._();

  factory _$_UnsupportedNotification.fromJson(Map<String, dynamic> json) =>
      _$$_UnsupportedNotificationFromJson(json);

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.unsupported()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnsupportedNotification);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return unsupported();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return unsupported?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
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
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnsupportedNotificationToJson(
      this,
    );
  }
}

abstract class _UnsupportedNotification extends NotificationMessage {
  const factory _UnsupportedNotification() = _$_UnsupportedNotification;
  const _UnsupportedNotification._() : super._();

  factory _UnsupportedNotification.fromJson(Map<String, dynamic> json) =
      _$_UnsupportedNotification.fromJson;
}

/// @nodoc
abstract class _$$AccountNotificationCopyWith<$Res> {
  factory _$$AccountNotificationCopyWith(_$AccountNotification value,
          $Res Function(_$AccountNotification) then) =
      __$$AccountNotificationCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationParams<Account> params});
}

/// @nodoc
class __$$AccountNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$AccountNotification>
    implements _$$AccountNotificationCopyWith<$Res> {
  __$$AccountNotificationCopyWithImpl(
      _$AccountNotification _value, $Res Function(_$AccountNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$AccountNotification(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<Account>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountNotification extends AccountNotification {
  const _$AccountNotification({required this.params, final String? $type})
      : $type = $type ?? 'accountNotification',
        super._();

  factory _$AccountNotification.fromJson(Map<String, dynamic> json) =>
      _$$AccountNotificationFromJson(json);

  @override
  final NotificationParams<Account> params;

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.accountNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountNotification &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountNotificationCopyWith<_$AccountNotification> get copyWith =>
      __$$AccountNotificationCopyWithImpl<_$AccountNotification>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return accountNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return accountNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
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
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return accountNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return accountNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (accountNotification != null) {
      return accountNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountNotificationToJson(
      this,
    );
  }
}

abstract class AccountNotification extends NotificationMessage {
  const factory AccountNotification(
          {required final NotificationParams<Account> params}) =
      _$AccountNotification;
  const AccountNotification._() : super._();

  factory AccountNotification.fromJson(Map<String, dynamic> json) =
      _$AccountNotification.fromJson;

  NotificationParams<Account> get params;
  @JsonKey(ignore: true)
  _$$AccountNotificationCopyWith<_$AccountNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogsNotificationCopyWith<$Res> {
  factory _$$LogsNotificationCopyWith(
          _$LogsNotification value, $Res Function(_$LogsNotification) then) =
      __$$LogsNotificationCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationParams<Logs> params});
}

/// @nodoc
class __$$LogsNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$LogsNotification>
    implements _$$LogsNotificationCopyWith<$Res> {
  __$$LogsNotificationCopyWithImpl(
      _$LogsNotification _value, $Res Function(_$LogsNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$LogsNotification(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<Logs>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogsNotification extends LogsNotification {
  const _$LogsNotification({required this.params, final String? $type})
      : $type = $type ?? 'logsNotification',
        super._();

  factory _$LogsNotification.fromJson(Map<String, dynamic> json) =>
      _$$LogsNotificationFromJson(json);

  @override
  final NotificationParams<Logs> params;

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.logsNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogsNotification &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogsNotificationCopyWith<_$LogsNotification> get copyWith =>
      __$$LogsNotificationCopyWithImpl<_$LogsNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return logsNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return logsNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
    required TResult orElse(),
  }) {
    if (logsNotification != null) {
      return logsNotification(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return logsNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return logsNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (logsNotification != null) {
      return logsNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LogsNotificationToJson(
      this,
    );
  }
}

abstract class LogsNotification extends NotificationMessage {
  const factory LogsNotification(
      {required final NotificationParams<Logs> params}) = _$LogsNotification;
  const LogsNotification._() : super._();

  factory LogsNotification.fromJson(Map<String, dynamic> json) =
      _$LogsNotification.fromJson;

  NotificationParams<Logs> get params;
  @JsonKey(ignore: true)
  _$$LogsNotificationCopyWith<_$LogsNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProgramNotificationCopyWith<$Res> {
  factory _$$ProgramNotificationCopyWith(_$ProgramNotification value,
          $Res Function(_$ProgramNotification) then) =
      __$$ProgramNotificationCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationParams<dynamic> params});
}

/// @nodoc
class __$$ProgramNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$ProgramNotification>
    implements _$$ProgramNotificationCopyWith<$Res> {
  __$$ProgramNotificationCopyWithImpl(
      _$ProgramNotification _value, $Res Function(_$ProgramNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$ProgramNotification(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramNotification extends ProgramNotification {
  const _$ProgramNotification({required this.params, final String? $type})
      : $type = $type ?? 'programNotification',
        super._();

  factory _$ProgramNotification.fromJson(Map<String, dynamic> json) =>
      _$$ProgramNotificationFromJson(json);

  @override
  final NotificationParams<dynamic> params;

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.programNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramNotification &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramNotificationCopyWith<_$ProgramNotification> get copyWith =>
      __$$ProgramNotificationCopyWithImpl<_$ProgramNotification>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return programNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return programNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
    required TResult orElse(),
  }) {
    if (programNotification != null) {
      return programNotification(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return programNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return programNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (programNotification != null) {
      return programNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramNotificationToJson(
      this,
    );
  }
}

abstract class ProgramNotification extends NotificationMessage {
  const factory ProgramNotification(
          {required final NotificationParams<dynamic> params}) =
      _$ProgramNotification;
  const ProgramNotification._() : super._();

  factory ProgramNotification.fromJson(Map<String, dynamic> json) =
      _$ProgramNotification.fromJson;

  NotificationParams<dynamic> get params;
  @JsonKey(ignore: true)
  _$$ProgramNotificationCopyWith<_$ProgramNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignatureNotificationCopyWith<$Res> {
  factory _$$SignatureNotificationCopyWith(_$SignatureNotification value,
          $Res Function(_$SignatureNotification) then) =
      __$$SignatureNotificationCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationParams<OptionalError> params});
}

/// @nodoc
class __$$SignatureNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$SignatureNotification>
    implements _$$SignatureNotificationCopyWith<$Res> {
  __$$SignatureNotificationCopyWithImpl(_$SignatureNotification _value,
      $Res Function(_$SignatureNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$SignatureNotification(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<OptionalError>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignatureNotification extends SignatureNotification {
  const _$SignatureNotification({required this.params, final String? $type})
      : $type = $type ?? 'signatureNotification',
        super._();

  factory _$SignatureNotification.fromJson(Map<String, dynamic> json) =>
      _$$SignatureNotificationFromJson(json);

  @override
  final NotificationParams<OptionalError> params;

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.signatureNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignatureNotification &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignatureNotificationCopyWith<_$SignatureNotification> get copyWith =>
      __$$SignatureNotificationCopyWithImpl<_$SignatureNotification>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return signatureNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return signatureNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
    required TResult orElse(),
  }) {
    if (signatureNotification != null) {
      return signatureNotification(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return signatureNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return signatureNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (signatureNotification != null) {
      return signatureNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SignatureNotificationToJson(
      this,
    );
  }
}

abstract class SignatureNotification extends NotificationMessage {
  const factory SignatureNotification(
          {required final NotificationParams<OptionalError> params}) =
      _$SignatureNotification;
  const SignatureNotification._() : super._();

  factory SignatureNotification.fromJson(Map<String, dynamic> json) =
      _$SignatureNotification.fromJson;

  NotificationParams<OptionalError> get params;
  @JsonKey(ignore: true)
  _$$SignatureNotificationCopyWith<_$SignatureNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlotNotificationCopyWith<$Res> {
  factory _$$SlotNotificationCopyWith(
          _$SlotNotification value, $Res Function(_$SlotNotification) then) =
      __$$SlotNotificationCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationParams<Slot> params});
}

/// @nodoc
class __$$SlotNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$SlotNotification>
    implements _$$SlotNotificationCopyWith<$Res> {
  __$$SlotNotificationCopyWithImpl(
      _$SlotNotification _value, $Res Function(_$SlotNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$SlotNotification(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParams<Slot>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotNotification extends SlotNotification {
  const _$SlotNotification({required this.params, final String? $type})
      : $type = $type ?? 'slotNotification',
        super._();

  factory _$SlotNotification.fromJson(Map<String, dynamic> json) =>
      _$$SlotNotificationFromJson(json);

  @override
  final NotificationParams<Slot> params;

  @JsonKey(name: 'method')
  final String $type;

  @override
  String toString() {
    return 'NotificationMessage.slotNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotNotification &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotNotificationCopyWith<_$SlotNotification> get copyWith =>
      __$$SlotNotificationCopyWithImpl<_$SlotNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParams<Account> params)
        accountNotification,
    required TResult Function(NotificationParams<Logs> params) logsNotification,
    required TResult Function(NotificationParams<dynamic> params)
        programNotification,
    required TResult Function(NotificationParams<OptionalError> params)
        signatureNotification,
    required TResult Function(NotificationParams<Slot> params) slotNotification,
  }) {
    return slotNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unsupported,
    TResult? Function(NotificationParams<Account> params)? accountNotification,
    TResult? Function(NotificationParams<Logs> params)? logsNotification,
    TResult? Function(NotificationParams<dynamic> params)? programNotification,
    TResult? Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult? Function(NotificationParams<Slot> params)? slotNotification,
  }) {
    return slotNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParams<Account> params)? accountNotification,
    TResult Function(NotificationParams<Logs> params)? logsNotification,
    TResult Function(NotificationParams<dynamic> params)? programNotification,
    TResult Function(NotificationParams<OptionalError> params)?
        signatureNotification,
    TResult Function(NotificationParams<Slot> params)? slotNotification,
    required TResult orElse(),
  }) {
    if (slotNotification != null) {
      return slotNotification(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnsupportedNotification value) unsupported,
    required TResult Function(AccountNotification value) accountNotification,
    required TResult Function(LogsNotification value) logsNotification,
    required TResult Function(ProgramNotification value) programNotification,
    required TResult Function(SignatureNotification value)
        signatureNotification,
    required TResult Function(SlotNotification value) slotNotification,
  }) {
    return slotNotification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnsupportedNotification value)? unsupported,
    TResult? Function(AccountNotification value)? accountNotification,
    TResult? Function(LogsNotification value)? logsNotification,
    TResult? Function(ProgramNotification value)? programNotification,
    TResult? Function(SignatureNotification value)? signatureNotification,
    TResult? Function(SlotNotification value)? slotNotification,
  }) {
    return slotNotification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
    required TResult orElse(),
  }) {
    if (slotNotification != null) {
      return slotNotification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotNotificationToJson(
      this,
    );
  }
}

abstract class SlotNotification extends NotificationMessage {
  const factory SlotNotification(
      {required final NotificationParams<Slot> params}) = _$SlotNotification;
  const SlotNotification._() : super._();

  factory SlotNotification.fromJson(Map<String, dynamic> json) =
      _$SlotNotification.fromJson;

  NotificationParams<Slot> get params;
  @JsonKey(ignore: true)
  _$$SlotNotificationCopyWith<_$SlotNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
