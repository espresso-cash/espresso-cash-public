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
class _$NotificationMessageTearOff {
  const _$NotificationMessageTearOff();

  _UnsupportedNotification unsupported() {
    return const _UnsupportedNotification();
  }

  AccountNotification accountNotification(
      {required NotificationParamsAccount params}) {
    return AccountNotification(
      params: params,
    );
  }

  LogsNotification logsNotification({required NotificationParamsLogs params}) {
    return LogsNotification(
      params: params,
    );
  }

  ProgramNotification programNotification(
      {required NotificationParamsGeneric params}) {
    return ProgramNotification(
      params: params,
    );
  }

  SignatureNotification signatureNotification(
      {required NotificationParamsSignature params}) {
    return SignatureNotification(
      params: params,
    );
  }

  SlotNotification slotNotification({required NotificationParamsSlot params}) {
    return SlotNotification(
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
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return unsupported();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return unsupported?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
  $Res call({NotificationParamsAccount params});

  $NotificationParamsAccountCopyWith<$Res> get params;
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
              as NotificationParamsAccount,
    ));
  }

  @override
  $NotificationParamsAccountCopyWith<$Res> get params {
    return $NotificationParamsAccountCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountNotification extends AccountNotification {
  const _$AccountNotification({required this.params}) : super._();

  factory _$AccountNotification.fromJson(Map<String, dynamic> json) =>
      _$$AccountNotificationFromJson(json);

  @override
  final NotificationParamsAccount params;

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
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return accountNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return accountNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    return _$$AccountNotificationToJson(this)
      ..['method'] = 'accountNotification';
  }
}

abstract class AccountNotification extends NotificationMessage {
  const factory AccountNotification(
      {required NotificationParamsAccount params}) = _$AccountNotification;
  const AccountNotification._() : super._();

  factory AccountNotification.fromJson(Map<String, dynamic> json) =
      _$AccountNotification.fromJson;

  NotificationParamsAccount get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountNotificationCopyWith<AccountNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogsNotificationCopyWith<$Res> {
  factory $LogsNotificationCopyWith(
          LogsNotification value, $Res Function(LogsNotification) then) =
      _$LogsNotificationCopyWithImpl<$Res>;
  $Res call({NotificationParamsLogs params});

  $NotificationParamsLogsCopyWith<$Res> get params;
}

/// @nodoc
class _$LogsNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements $LogsNotificationCopyWith<$Res> {
  _$LogsNotificationCopyWithImpl(
      LogsNotification _value, $Res Function(LogsNotification) _then)
      : super(_value, (v) => _then(v as LogsNotification));

  @override
  LogsNotification get _value => super._value as LogsNotification;

  @override
  $Res call({
    Object? params = freezed,
  }) {
    return _then(LogsNotification(
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParamsLogs,
    ));
  }

  @override
  $NotificationParamsLogsCopyWith<$Res> get params {
    return $NotificationParamsLogsCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LogsNotification extends LogsNotification {
  const _$LogsNotification({required this.params}) : super._();

  factory _$LogsNotification.fromJson(Map<String, dynamic> json) =>
      _$$LogsNotificationFromJson(json);

  @override
  final NotificationParamsLogs params;

  @override
  String toString() {
    return 'NotificationMessage.logsNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LogsNotification &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(params);

  @JsonKey(ignore: true)
  @override
  $LogsNotificationCopyWith<LogsNotification> get copyWith =>
      _$LogsNotificationCopyWithImpl<LogsNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return logsNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return logsNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    return _$$LogsNotificationToJson(this)..['method'] = 'logsNotification';
  }
}

abstract class LogsNotification extends NotificationMessage {
  const factory LogsNotification({required NotificationParamsLogs params}) =
      _$LogsNotification;
  const LogsNotification._() : super._();

  factory LogsNotification.fromJson(Map<String, dynamic> json) =
      _$LogsNotification.fromJson;

  NotificationParamsLogs get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogsNotificationCopyWith<LogsNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramNotificationCopyWith<$Res> {
  factory $ProgramNotificationCopyWith(
          ProgramNotification value, $Res Function(ProgramNotification) then) =
      _$ProgramNotificationCopyWithImpl<$Res>;
  $Res call({NotificationParamsGeneric params});

  $NotificationParamsGenericCopyWith<$Res> get params;
}

/// @nodoc
class _$ProgramNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements $ProgramNotificationCopyWith<$Res> {
  _$ProgramNotificationCopyWithImpl(
      ProgramNotification _value, $Res Function(ProgramNotification) _then)
      : super(_value, (v) => _then(v as ProgramNotification));

  @override
  ProgramNotification get _value => super._value as ProgramNotification;

  @override
  $Res call({
    Object? params = freezed,
  }) {
    return _then(ProgramNotification(
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParamsGeneric,
    ));
  }

  @override
  $NotificationParamsGenericCopyWith<$Res> get params {
    return $NotificationParamsGenericCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramNotification extends ProgramNotification {
  const _$ProgramNotification({required this.params}) : super._();

  factory _$ProgramNotification.fromJson(Map<String, dynamic> json) =>
      _$$ProgramNotificationFromJson(json);

  @override
  final NotificationParamsGeneric params;

  @override
  String toString() {
    return 'NotificationMessage.programNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProgramNotification &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(params);

  @JsonKey(ignore: true)
  @override
  $ProgramNotificationCopyWith<ProgramNotification> get copyWith =>
      _$ProgramNotificationCopyWithImpl<ProgramNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return programNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return programNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    return _$$ProgramNotificationToJson(this)
      ..['method'] = 'programNotification';
  }
}

abstract class ProgramNotification extends NotificationMessage {
  const factory ProgramNotification(
      {required NotificationParamsGeneric params}) = _$ProgramNotification;
  const ProgramNotification._() : super._();

  factory ProgramNotification.fromJson(Map<String, dynamic> json) =
      _$ProgramNotification.fromJson;

  NotificationParamsGeneric get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramNotificationCopyWith<ProgramNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignatureNotificationCopyWith<$Res> {
  factory $SignatureNotificationCopyWith(SignatureNotification value,
          $Res Function(SignatureNotification) then) =
      _$SignatureNotificationCopyWithImpl<$Res>;
  $Res call({NotificationParamsSignature params});

  $NotificationParamsSignatureCopyWith<$Res> get params;
}

/// @nodoc
class _$SignatureNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements $SignatureNotificationCopyWith<$Res> {
  _$SignatureNotificationCopyWithImpl(
      SignatureNotification _value, $Res Function(SignatureNotification) _then)
      : super(_value, (v) => _then(v as SignatureNotification));

  @override
  SignatureNotification get _value => super._value as SignatureNotification;

  @override
  $Res call({
    Object? params = freezed,
  }) {
    return _then(SignatureNotification(
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParamsSignature,
    ));
  }

  @override
  $NotificationParamsSignatureCopyWith<$Res> get params {
    return $NotificationParamsSignatureCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SignatureNotification extends SignatureNotification {
  const _$SignatureNotification({required this.params}) : super._();

  factory _$SignatureNotification.fromJson(Map<String, dynamic> json) =>
      _$$SignatureNotificationFromJson(json);

  @override
  final NotificationParamsSignature params;

  @override
  String toString() {
    return 'NotificationMessage.signatureNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SignatureNotification &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(params);

  @JsonKey(ignore: true)
  @override
  $SignatureNotificationCopyWith<SignatureNotification> get copyWith =>
      _$SignatureNotificationCopyWithImpl<SignatureNotification>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return signatureNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return signatureNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    return _$$SignatureNotificationToJson(this)
      ..['method'] = 'signatureNotification';
  }
}

abstract class SignatureNotification extends NotificationMessage {
  const factory SignatureNotification(
      {required NotificationParamsSignature params}) = _$SignatureNotification;
  const SignatureNotification._() : super._();

  factory SignatureNotification.fromJson(Map<String, dynamic> json) =
      _$SignatureNotification.fromJson;

  NotificationParamsSignature get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignatureNotificationCopyWith<SignatureNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotNotificationCopyWith<$Res> {
  factory $SlotNotificationCopyWith(
          SlotNotification value, $Res Function(SlotNotification) then) =
      _$SlotNotificationCopyWithImpl<$Res>;
  $Res call({NotificationParamsSlot params});

  $NotificationParamsSlotCopyWith<$Res> get params;
}

/// @nodoc
class _$SlotNotificationCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res>
    implements $SlotNotificationCopyWith<$Res> {
  _$SlotNotificationCopyWithImpl(
      SlotNotification _value, $Res Function(SlotNotification) _then)
      : super(_value, (v) => _then(v as SlotNotification));

  @override
  SlotNotification get _value => super._value as SlotNotification;

  @override
  $Res call({
    Object? params = freezed,
  }) {
    return _then(SlotNotification(
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as NotificationParamsSlot,
    ));
  }

  @override
  $NotificationParamsSlotCopyWith<$Res> get params {
    return $NotificationParamsSlotCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotNotification extends SlotNotification {
  const _$SlotNotification({required this.params}) : super._();

  factory _$SlotNotification.fromJson(Map<String, dynamic> json) =>
      _$$SlotNotificationFromJson(json);

  @override
  final NotificationParamsSlot params;

  @override
  String toString() {
    return 'NotificationMessage.slotNotification(params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SlotNotification &&
            (identical(other.params, params) ||
                const DeepCollectionEquality().equals(other.params, params)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(params);

  @JsonKey(ignore: true)
  @override
  $SlotNotificationCopyWith<SlotNotification> get copyWith =>
      _$SlotNotificationCopyWithImpl<SlotNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unsupported,
    required TResult Function(NotificationParamsAccount params)
        accountNotification,
    required TResult Function(NotificationParamsLogs params) logsNotification,
    required TResult Function(NotificationParamsGeneric params)
        programNotification,
    required TResult Function(NotificationParamsSignature params)
        signatureNotification,
    required TResult Function(NotificationParamsSlot params) slotNotification,
  }) {
    return slotNotification(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
  }) {
    return slotNotification?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unsupported,
    TResult Function(NotificationParamsAccount params)? accountNotification,
    TResult Function(NotificationParamsLogs params)? logsNotification,
    TResult Function(NotificationParamsGeneric params)? programNotification,
    TResult Function(NotificationParamsSignature params)? signatureNotification,
    TResult Function(NotificationParamsSlot params)? slotNotification,
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
    TResult Function(_UnsupportedNotification value)? unsupported,
    TResult Function(AccountNotification value)? accountNotification,
    TResult Function(LogsNotification value)? logsNotification,
    TResult Function(ProgramNotification value)? programNotification,
    TResult Function(SignatureNotification value)? signatureNotification,
    TResult Function(SlotNotification value)? slotNotification,
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
    return _$$SlotNotificationToJson(this)..['method'] = 'slotNotification';
  }
}

abstract class SlotNotification extends NotificationMessage {
  const factory SlotNotification({required NotificationParamsSlot params}) =
      _$SlotNotification;
  const SlotNotification._() : super._();

  factory SlotNotification.fromJson(Map<String, dynamic> json) =
      _$SlotNotification.fromJson;

  NotificationParamsSlot get params => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlotNotificationCopyWith<SlotNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
