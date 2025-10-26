// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
NotificationMessage _$NotificationMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['method']) {
                  case 'accountNotification':
          return AccountNotification.fromJson(
            json
          );
                case 'logsNotification':
          return LogsNotification.fromJson(
            json
          );
                case 'programNotification':
          return ProgramNotification.fromJson(
            json
          );
                case 'signatureNotification':
          return SignatureNotification.fromJson(
            json
          );
                case 'slotNotification':
          return SlotNotification.fromJson(
            json
          );
        
          default:
            return _UnsupportedNotification.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$NotificationMessage {



  /// Serializes this NotificationMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationMessage()';
}


}

/// @nodoc
class $NotificationMessageCopyWith<$Res>  {
$NotificationMessageCopyWith(NotificationMessage _, $Res Function(NotificationMessage) __);
}


/// Adds pattern-matching-related methods to [NotificationMessage].
extension NotificationMessagePatterns on NotificationMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UnsupportedNotification value)?  unsupported,TResult Function( AccountNotification value)?  accountNotification,TResult Function( LogsNotification value)?  logsNotification,TResult Function( ProgramNotification value)?  programNotification,TResult Function( SignatureNotification value)?  signatureNotification,TResult Function( SlotNotification value)?  slotNotification,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsupportedNotification() when unsupported != null:
return unsupported(_that);case AccountNotification() when accountNotification != null:
return accountNotification(_that);case LogsNotification() when logsNotification != null:
return logsNotification(_that);case ProgramNotification() when programNotification != null:
return programNotification(_that);case SignatureNotification() when signatureNotification != null:
return signatureNotification(_that);case SlotNotification() when slotNotification != null:
return slotNotification(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UnsupportedNotification value)  unsupported,required TResult Function( AccountNotification value)  accountNotification,required TResult Function( LogsNotification value)  logsNotification,required TResult Function( ProgramNotification value)  programNotification,required TResult Function( SignatureNotification value)  signatureNotification,required TResult Function( SlotNotification value)  slotNotification,}){
final _that = this;
switch (_that) {
case _UnsupportedNotification():
return unsupported(_that);case AccountNotification():
return accountNotification(_that);case LogsNotification():
return logsNotification(_that);case ProgramNotification():
return programNotification(_that);case SignatureNotification():
return signatureNotification(_that);case SlotNotification():
return slotNotification(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UnsupportedNotification value)?  unsupported,TResult? Function( AccountNotification value)?  accountNotification,TResult? Function( LogsNotification value)?  logsNotification,TResult? Function( ProgramNotification value)?  programNotification,TResult? Function( SignatureNotification value)?  signatureNotification,TResult? Function( SlotNotification value)?  slotNotification,}){
final _that = this;
switch (_that) {
case _UnsupportedNotification() when unsupported != null:
return unsupported(_that);case AccountNotification() when accountNotification != null:
return accountNotification(_that);case LogsNotification() when logsNotification != null:
return logsNotification(_that);case ProgramNotification() when programNotification != null:
return programNotification(_that);case SignatureNotification() when signatureNotification != null:
return signatureNotification(_that);case SlotNotification() when slotNotification != null:
return slotNotification(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unsupported,TResult Function( NotificationParams<Account> params)?  accountNotification,TResult Function( NotificationParams<Logs> params)?  logsNotification,TResult Function( NotificationParams<dynamic> params)?  programNotification,TResult Function( NotificationParams<OptionalError> params)?  signatureNotification,TResult Function( NotificationParams<Slot> params)?  slotNotification,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsupportedNotification() when unsupported != null:
return unsupported();case AccountNotification() when accountNotification != null:
return accountNotification(_that.params);case LogsNotification() when logsNotification != null:
return logsNotification(_that.params);case ProgramNotification() when programNotification != null:
return programNotification(_that.params);case SignatureNotification() when signatureNotification != null:
return signatureNotification(_that.params);case SlotNotification() when slotNotification != null:
return slotNotification(_that.params);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unsupported,required TResult Function( NotificationParams<Account> params)  accountNotification,required TResult Function( NotificationParams<Logs> params)  logsNotification,required TResult Function( NotificationParams<dynamic> params)  programNotification,required TResult Function( NotificationParams<OptionalError> params)  signatureNotification,required TResult Function( NotificationParams<Slot> params)  slotNotification,}) {final _that = this;
switch (_that) {
case _UnsupportedNotification():
return unsupported();case AccountNotification():
return accountNotification(_that.params);case LogsNotification():
return logsNotification(_that.params);case ProgramNotification():
return programNotification(_that.params);case SignatureNotification():
return signatureNotification(_that.params);case SlotNotification():
return slotNotification(_that.params);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unsupported,TResult? Function( NotificationParams<Account> params)?  accountNotification,TResult? Function( NotificationParams<Logs> params)?  logsNotification,TResult? Function( NotificationParams<dynamic> params)?  programNotification,TResult? Function( NotificationParams<OptionalError> params)?  signatureNotification,TResult? Function( NotificationParams<Slot> params)?  slotNotification,}) {final _that = this;
switch (_that) {
case _UnsupportedNotification() when unsupported != null:
return unsupported();case AccountNotification() when accountNotification != null:
return accountNotification(_that.params);case LogsNotification() when logsNotification != null:
return logsNotification(_that.params);case ProgramNotification() when programNotification != null:
return programNotification(_that.params);case SignatureNotification() when signatureNotification != null:
return signatureNotification(_that.params);case SlotNotification() when slotNotification != null:
return slotNotification(_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsupportedNotification extends NotificationMessage {
  const _UnsupportedNotification({final  String? $type}): $type = $type ?? 'unsupported',super._();
  factory _UnsupportedNotification.fromJson(Map<String, dynamic> json) => _$UnsupportedNotificationFromJson(json);



@JsonKey(name: 'method')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnsupportedNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsupportedNotification);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationMessage.unsupported()';
}


}




/// @nodoc
@JsonSerializable()

class AccountNotification extends NotificationMessage {
  const AccountNotification({required this.params, final  String? $type}): $type = $type ?? 'accountNotification',super._();
  factory AccountNotification.fromJson(Map<String, dynamic> json) => _$AccountNotificationFromJson(json);

 final  NotificationParams<Account> params;

@JsonKey(name: 'method')
final String $type;


/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountNotificationCopyWith<AccountNotification> get copyWith => _$AccountNotificationCopyWithImpl<AccountNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountNotification&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'NotificationMessage.accountNotification(params: $params)';
}


}

/// @nodoc
abstract mixin class $AccountNotificationCopyWith<$Res> implements $NotificationMessageCopyWith<$Res> {
  factory $AccountNotificationCopyWith(AccountNotification value, $Res Function(AccountNotification) _then) = _$AccountNotificationCopyWithImpl;
@useResult
$Res call({
 NotificationParams<Account> params
});




}
/// @nodoc
class _$AccountNotificationCopyWithImpl<$Res>
    implements $AccountNotificationCopyWith<$Res> {
  _$AccountNotificationCopyWithImpl(this._self, this._then);

  final AccountNotification _self;
  final $Res Function(AccountNotification) _then;

/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(AccountNotification(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as NotificationParams<Account>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LogsNotification extends NotificationMessage {
  const LogsNotification({required this.params, final  String? $type}): $type = $type ?? 'logsNotification',super._();
  factory LogsNotification.fromJson(Map<String, dynamic> json) => _$LogsNotificationFromJson(json);

 final  NotificationParams<Logs> params;

@JsonKey(name: 'method')
final String $type;


/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogsNotificationCopyWith<LogsNotification> get copyWith => _$LogsNotificationCopyWithImpl<LogsNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogsNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsNotification&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'NotificationMessage.logsNotification(params: $params)';
}


}

/// @nodoc
abstract mixin class $LogsNotificationCopyWith<$Res> implements $NotificationMessageCopyWith<$Res> {
  factory $LogsNotificationCopyWith(LogsNotification value, $Res Function(LogsNotification) _then) = _$LogsNotificationCopyWithImpl;
@useResult
$Res call({
 NotificationParams<Logs> params
});




}
/// @nodoc
class _$LogsNotificationCopyWithImpl<$Res>
    implements $LogsNotificationCopyWith<$Res> {
  _$LogsNotificationCopyWithImpl(this._self, this._then);

  final LogsNotification _self;
  final $Res Function(LogsNotification) _then;

/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(LogsNotification(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as NotificationParams<Logs>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProgramNotification extends NotificationMessage {
  const ProgramNotification({required this.params, final  String? $type}): $type = $type ?? 'programNotification',super._();
  factory ProgramNotification.fromJson(Map<String, dynamic> json) => _$ProgramNotificationFromJson(json);

 final  NotificationParams<dynamic> params;

@JsonKey(name: 'method')
final String $type;


/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramNotificationCopyWith<ProgramNotification> get copyWith => _$ProgramNotificationCopyWithImpl<ProgramNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgramNotification&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'NotificationMessage.programNotification(params: $params)';
}


}

/// @nodoc
abstract mixin class $ProgramNotificationCopyWith<$Res> implements $NotificationMessageCopyWith<$Res> {
  factory $ProgramNotificationCopyWith(ProgramNotification value, $Res Function(ProgramNotification) _then) = _$ProgramNotificationCopyWithImpl;
@useResult
$Res call({
 NotificationParams<dynamic> params
});




}
/// @nodoc
class _$ProgramNotificationCopyWithImpl<$Res>
    implements $ProgramNotificationCopyWith<$Res> {
  _$ProgramNotificationCopyWithImpl(this._self, this._then);

  final ProgramNotification _self;
  final $Res Function(ProgramNotification) _then;

/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ProgramNotification(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as NotificationParams<dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SignatureNotification extends NotificationMessage {
  const SignatureNotification({required this.params, final  String? $type}): $type = $type ?? 'signatureNotification',super._();
  factory SignatureNotification.fromJson(Map<String, dynamic> json) => _$SignatureNotificationFromJson(json);

 final  NotificationParams<OptionalError> params;

@JsonKey(name: 'method')
final String $type;


/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureNotificationCopyWith<SignatureNotification> get copyWith => _$SignatureNotificationCopyWithImpl<SignatureNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureNotification&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'NotificationMessage.signatureNotification(params: $params)';
}


}

/// @nodoc
abstract mixin class $SignatureNotificationCopyWith<$Res> implements $NotificationMessageCopyWith<$Res> {
  factory $SignatureNotificationCopyWith(SignatureNotification value, $Res Function(SignatureNotification) _then) = _$SignatureNotificationCopyWithImpl;
@useResult
$Res call({
 NotificationParams<OptionalError> params
});




}
/// @nodoc
class _$SignatureNotificationCopyWithImpl<$Res>
    implements $SignatureNotificationCopyWith<$Res> {
  _$SignatureNotificationCopyWithImpl(this._self, this._then);

  final SignatureNotification _self;
  final $Res Function(SignatureNotification) _then;

/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(SignatureNotification(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as NotificationParams<OptionalError>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SlotNotification extends NotificationMessage {
  const SlotNotification({required this.params, final  String? $type}): $type = $type ?? 'slotNotification',super._();
  factory SlotNotification.fromJson(Map<String, dynamic> json) => _$SlotNotificationFromJson(json);

 final  NotificationParams<Slot> params;

@JsonKey(name: 'method')
final String $type;


/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotNotificationCopyWith<SlotNotification> get copyWith => _$SlotNotificationCopyWithImpl<SlotNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotNotification&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'NotificationMessage.slotNotification(params: $params)';
}


}

/// @nodoc
abstract mixin class $SlotNotificationCopyWith<$Res> implements $NotificationMessageCopyWith<$Res> {
  factory $SlotNotificationCopyWith(SlotNotification value, $Res Function(SlotNotification) _then) = _$SlotNotificationCopyWithImpl;
@useResult
$Res call({
 NotificationParams<Slot> params
});




}
/// @nodoc
class _$SlotNotificationCopyWithImpl<$Res>
    implements $SlotNotificationCopyWith<$Res> {
  _$SlotNotificationCopyWithImpl(this._self, this._then);

  final SlotNotification _self;
  final $Res Function(SlotNotification) _then;

/// Create a copy of NotificationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(SlotNotification(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as NotificationParams<Slot>,
  ));
}


}

// dart format on
