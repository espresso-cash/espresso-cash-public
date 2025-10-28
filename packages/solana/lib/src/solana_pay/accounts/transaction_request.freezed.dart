// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionRequestInfo {

 String get label; String get icon;
/// Create a copy of TransactionRequestInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRequestInfoCopyWith<TransactionRequestInfo> get copyWith => _$TransactionRequestInfoCopyWithImpl<TransactionRequestInfo>(this as TransactionRequestInfo, _$identity);

  /// Serializes this TransactionRequestInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRequestInfo&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,icon);

@override
String toString() {
  return 'TransactionRequestInfo(label: $label, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $TransactionRequestInfoCopyWith<$Res>  {
  factory $TransactionRequestInfoCopyWith(TransactionRequestInfo value, $Res Function(TransactionRequestInfo) _then) = _$TransactionRequestInfoCopyWithImpl;
@useResult
$Res call({
 String label, String icon
});




}
/// @nodoc
class _$TransactionRequestInfoCopyWithImpl<$Res>
    implements $TransactionRequestInfoCopyWith<$Res> {
  _$TransactionRequestInfoCopyWithImpl(this._self, this._then);

  final TransactionRequestInfo _self;
  final $Res Function(TransactionRequestInfo) _then;

/// Create a copy of TransactionRequestInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? icon = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRequestInfo].
extension TransactionRequestInfoPatterns on TransactionRequestInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionRequestInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionRequestInfo() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionRequestInfo value)  $default,){
final _that = this;
switch (_that) {
case _TransactionRequestInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionRequestInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionRequestInfo() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionRequestInfo() when $default != null:
return $default(_that.label,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String icon)  $default,) {final _that = this;
switch (_that) {
case _TransactionRequestInfo():
return $default(_that.label,_that.icon);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _TransactionRequestInfo() when $default != null:
return $default(_that.label,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionRequestInfo implements TransactionRequestInfo {
  const _TransactionRequestInfo({required this.label, required this.icon});
  factory _TransactionRequestInfo.fromJson(Map<String, dynamic> json) => _$TransactionRequestInfoFromJson(json);

@override final  String label;
@override final  String icon;

/// Create a copy of TransactionRequestInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionRequestInfoCopyWith<_TransactionRequestInfo> get copyWith => __$TransactionRequestInfoCopyWithImpl<_TransactionRequestInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionRequestInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionRequestInfo&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,icon);

@override
String toString() {
  return 'TransactionRequestInfo(label: $label, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$TransactionRequestInfoCopyWith<$Res> implements $TransactionRequestInfoCopyWith<$Res> {
  factory _$TransactionRequestInfoCopyWith(_TransactionRequestInfo value, $Res Function(_TransactionRequestInfo) _then) = __$TransactionRequestInfoCopyWithImpl;
@override @useResult
$Res call({
 String label, String icon
});




}
/// @nodoc
class __$TransactionRequestInfoCopyWithImpl<$Res>
    implements _$TransactionRequestInfoCopyWith<$Res> {
  __$TransactionRequestInfoCopyWithImpl(this._self, this._then);

  final _TransactionRequestInfo _self;
  final $Res Function(_TransactionRequestInfo) _then;

/// Create a copy of TransactionRequestInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? icon = null,}) {
  return _then(_TransactionRequestInfo(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TransactionRequestResponse {

 String get transaction; String? get message; String? get redirect;
/// Create a copy of TransactionRequestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRequestResponseCopyWith<TransactionRequestResponse> get copyWith => _$TransactionRequestResponseCopyWithImpl<TransactionRequestResponse>(this as TransactionRequestResponse, _$identity);

  /// Serializes this TransactionRequestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRequestResponse&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.message, message) || other.message == message)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,message,redirect);

@override
String toString() {
  return 'TransactionRequestResponse(transaction: $transaction, message: $message, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class $TransactionRequestResponseCopyWith<$Res>  {
  factory $TransactionRequestResponseCopyWith(TransactionRequestResponse value, $Res Function(TransactionRequestResponse) _then) = _$TransactionRequestResponseCopyWithImpl;
@useResult
$Res call({
 String transaction, String? message, String? redirect
});




}
/// @nodoc
class _$TransactionRequestResponseCopyWithImpl<$Res>
    implements $TransactionRequestResponseCopyWith<$Res> {
  _$TransactionRequestResponseCopyWithImpl(this._self, this._then);

  final TransactionRequestResponse _self;
  final $Res Function(TransactionRequestResponse) _then;

/// Create a copy of TransactionRequestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? message = freezed,Object? redirect = freezed,}) {
  return _then(_self.copyWith(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRequestResponse].
extension TransactionRequestResponsePatterns on TransactionRequestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionRequestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionRequestResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionRequestResponse value)  $default,){
final _that = this;
switch (_that) {
case _TransactionRequestResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionRequestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionRequestResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transaction,  String? message,  String? redirect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionRequestResponse() when $default != null:
return $default(_that.transaction,_that.message,_that.redirect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transaction,  String? message,  String? redirect)  $default,) {final _that = this;
switch (_that) {
case _TransactionRequestResponse():
return $default(_that.transaction,_that.message,_that.redirect);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transaction,  String? message,  String? redirect)?  $default,) {final _that = this;
switch (_that) {
case _TransactionRequestResponse() when $default != null:
return $default(_that.transaction,_that.message,_that.redirect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionRequestResponse implements TransactionRequestResponse {
  const _TransactionRequestResponse({required this.transaction, this.message, this.redirect});
  factory _TransactionRequestResponse.fromJson(Map<String, dynamic> json) => _$TransactionRequestResponseFromJson(json);

@override final  String transaction;
@override final  String? message;
@override final  String? redirect;

/// Create a copy of TransactionRequestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionRequestResponseCopyWith<_TransactionRequestResponse> get copyWith => __$TransactionRequestResponseCopyWithImpl<_TransactionRequestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionRequestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionRequestResponse&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.message, message) || other.message == message)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,message,redirect);

@override
String toString() {
  return 'TransactionRequestResponse(transaction: $transaction, message: $message, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class _$TransactionRequestResponseCopyWith<$Res> implements $TransactionRequestResponseCopyWith<$Res> {
  factory _$TransactionRequestResponseCopyWith(_TransactionRequestResponse value, $Res Function(_TransactionRequestResponse) _then) = __$TransactionRequestResponseCopyWithImpl;
@override @useResult
$Res call({
 String transaction, String? message, String? redirect
});




}
/// @nodoc
class __$TransactionRequestResponseCopyWithImpl<$Res>
    implements _$TransactionRequestResponseCopyWith<$Res> {
  __$TransactionRequestResponseCopyWithImpl(this._self, this._then);

  final _TransactionRequestResponse _self;
  final $Res Function(_TransactionRequestResponse) _then;

/// Create a copy of TransactionRequestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? message = freezed,Object? redirect = freezed,}) {
  return _then(_TransactionRequestResponse(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
