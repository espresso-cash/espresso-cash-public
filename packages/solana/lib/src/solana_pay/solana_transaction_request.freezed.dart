// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solana_transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SolanaTransactionRequest {

 Uri get link; String? get label; String? get message;
/// Create a copy of SolanaTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolanaTransactionRequestCopyWith<SolanaTransactionRequest> get copyWith => _$SolanaTransactionRequestCopyWithImpl<SolanaTransactionRequest>(this as SolanaTransactionRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolanaTransactionRequest&&(identical(other.link, link) || other.link == link)&&(identical(other.label, label) || other.label == label)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,link,label,message);

@override
String toString() {
  return 'SolanaTransactionRequest(link: $link, label: $label, message: $message)';
}


}

/// @nodoc
abstract mixin class $SolanaTransactionRequestCopyWith<$Res>  {
  factory $SolanaTransactionRequestCopyWith(SolanaTransactionRequest value, $Res Function(SolanaTransactionRequest) _then) = _$SolanaTransactionRequestCopyWithImpl;
@useResult
$Res call({
 Uri link, String? label, String? message
});




}
/// @nodoc
class _$SolanaTransactionRequestCopyWithImpl<$Res>
    implements $SolanaTransactionRequestCopyWith<$Res> {
  _$SolanaTransactionRequestCopyWithImpl(this._self, this._then);

  final SolanaTransactionRequest _self;
  final $Res Function(SolanaTransactionRequest) _then;

/// Create a copy of SolanaTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? label = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as Uri,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SolanaTransactionRequest].
extension SolanaTransactionRequestPatterns on SolanaTransactionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SolanaTransactionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SolanaTransactionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SolanaTransactionRequest value)  $default,){
final _that = this;
switch (_that) {
case _SolanaTransactionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SolanaTransactionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SolanaTransactionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri link,  String? label,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SolanaTransactionRequest() when $default != null:
return $default(_that.link,_that.label,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri link,  String? label,  String? message)  $default,) {final _that = this;
switch (_that) {
case _SolanaTransactionRequest():
return $default(_that.link,_that.label,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri link,  String? label,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _SolanaTransactionRequest() when $default != null:
return $default(_that.link,_that.label,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _SolanaTransactionRequest extends SolanaTransactionRequest {
  const _SolanaTransactionRequest({required this.link, this.label, this.message}): super._();
  

@override final  Uri link;
@override final  String? label;
@override final  String? message;

/// Create a copy of SolanaTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolanaTransactionRequestCopyWith<_SolanaTransactionRequest> get copyWith => __$SolanaTransactionRequestCopyWithImpl<_SolanaTransactionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SolanaTransactionRequest&&(identical(other.link, link) || other.link == link)&&(identical(other.label, label) || other.label == label)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,link,label,message);

@override
String toString() {
  return 'SolanaTransactionRequest(link: $link, label: $label, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SolanaTransactionRequestCopyWith<$Res> implements $SolanaTransactionRequestCopyWith<$Res> {
  factory _$SolanaTransactionRequestCopyWith(_SolanaTransactionRequest value, $Res Function(_SolanaTransactionRequest) _then) = __$SolanaTransactionRequestCopyWithImpl;
@override @useResult
$Res call({
 Uri link, String? label, String? message
});




}
/// @nodoc
class __$SolanaTransactionRequestCopyWithImpl<$Res>
    implements _$SolanaTransactionRequestCopyWith<$Res> {
  __$SolanaTransactionRequestCopyWithImpl(this._self, this._then);

  final _SolanaTransactionRequest _self;
  final $Res Function(_SolanaTransactionRequest) _then;

/// Create a copy of SolanaTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? label = freezed,Object? message = freezed,}) {
  return _then(_SolanaTransactionRequest(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as Uri,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
