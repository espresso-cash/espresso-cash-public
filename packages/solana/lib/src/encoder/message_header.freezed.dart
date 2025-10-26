// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageHeader {

 int get numRequiredSignatures; int get numReadonlySignedAccounts; int get numReadonlyUnsignedAccounts;
/// Create a copy of MessageHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageHeaderCopyWith<MessageHeader> get copyWith => _$MessageHeaderCopyWithImpl<MessageHeader>(this as MessageHeader, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageHeader&&(identical(other.numRequiredSignatures, numRequiredSignatures) || other.numRequiredSignatures == numRequiredSignatures)&&(identical(other.numReadonlySignedAccounts, numReadonlySignedAccounts) || other.numReadonlySignedAccounts == numReadonlySignedAccounts)&&(identical(other.numReadonlyUnsignedAccounts, numReadonlyUnsignedAccounts) || other.numReadonlyUnsignedAccounts == numReadonlyUnsignedAccounts));
}


@override
int get hashCode => Object.hash(runtimeType,numRequiredSignatures,numReadonlySignedAccounts,numReadonlyUnsignedAccounts);

@override
String toString() {
  return 'MessageHeader(numRequiredSignatures: $numRequiredSignatures, numReadonlySignedAccounts: $numReadonlySignedAccounts, numReadonlyUnsignedAccounts: $numReadonlyUnsignedAccounts)';
}


}

/// @nodoc
abstract mixin class $MessageHeaderCopyWith<$Res>  {
  factory $MessageHeaderCopyWith(MessageHeader value, $Res Function(MessageHeader) _then) = _$MessageHeaderCopyWithImpl;
@useResult
$Res call({
 int numRequiredSignatures, int numReadonlySignedAccounts, int numReadonlyUnsignedAccounts
});




}
/// @nodoc
class _$MessageHeaderCopyWithImpl<$Res>
    implements $MessageHeaderCopyWith<$Res> {
  _$MessageHeaderCopyWithImpl(this._self, this._then);

  final MessageHeader _self;
  final $Res Function(MessageHeader) _then;

/// Create a copy of MessageHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? numRequiredSignatures = null,Object? numReadonlySignedAccounts = null,Object? numReadonlyUnsignedAccounts = null,}) {
  return _then(_self.copyWith(
numRequiredSignatures: null == numRequiredSignatures ? _self.numRequiredSignatures : numRequiredSignatures // ignore: cast_nullable_to_non_nullable
as int,numReadonlySignedAccounts: null == numReadonlySignedAccounts ? _self.numReadonlySignedAccounts : numReadonlySignedAccounts // ignore: cast_nullable_to_non_nullable
as int,numReadonlyUnsignedAccounts: null == numReadonlyUnsignedAccounts ? _self.numReadonlyUnsignedAccounts : numReadonlyUnsignedAccounts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageHeader].
extension MessageHeaderPatterns on MessageHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageHeader value)  $default,){
final _that = this;
switch (_that) {
case _MessageHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageHeader value)?  $default,){
final _that = this;
switch (_that) {
case _MessageHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int numRequiredSignatures,  int numReadonlySignedAccounts,  int numReadonlyUnsignedAccounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageHeader() when $default != null:
return $default(_that.numRequiredSignatures,_that.numReadonlySignedAccounts,_that.numReadonlyUnsignedAccounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int numRequiredSignatures,  int numReadonlySignedAccounts,  int numReadonlyUnsignedAccounts)  $default,) {final _that = this;
switch (_that) {
case _MessageHeader():
return $default(_that.numRequiredSignatures,_that.numReadonlySignedAccounts,_that.numReadonlyUnsignedAccounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int numRequiredSignatures,  int numReadonlySignedAccounts,  int numReadonlyUnsignedAccounts)?  $default,) {final _that = this;
switch (_that) {
case _MessageHeader() when $default != null:
return $default(_that.numRequiredSignatures,_that.numReadonlySignedAccounts,_that.numReadonlyUnsignedAccounts);case _:
  return null;

}
}

}

/// @nodoc


class _MessageHeader extends MessageHeader {
  const _MessageHeader({required this.numRequiredSignatures, required this.numReadonlySignedAccounts, required this.numReadonlyUnsignedAccounts}): super._();
  

@override final  int numRequiredSignatures;
@override final  int numReadonlySignedAccounts;
@override final  int numReadonlyUnsignedAccounts;

/// Create a copy of MessageHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageHeaderCopyWith<_MessageHeader> get copyWith => __$MessageHeaderCopyWithImpl<_MessageHeader>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageHeader&&(identical(other.numRequiredSignatures, numRequiredSignatures) || other.numRequiredSignatures == numRequiredSignatures)&&(identical(other.numReadonlySignedAccounts, numReadonlySignedAccounts) || other.numReadonlySignedAccounts == numReadonlySignedAccounts)&&(identical(other.numReadonlyUnsignedAccounts, numReadonlyUnsignedAccounts) || other.numReadonlyUnsignedAccounts == numReadonlyUnsignedAccounts));
}


@override
int get hashCode => Object.hash(runtimeType,numRequiredSignatures,numReadonlySignedAccounts,numReadonlyUnsignedAccounts);

@override
String toString() {
  return 'MessageHeader(numRequiredSignatures: $numRequiredSignatures, numReadonlySignedAccounts: $numReadonlySignedAccounts, numReadonlyUnsignedAccounts: $numReadonlyUnsignedAccounts)';
}


}

/// @nodoc
abstract mixin class _$MessageHeaderCopyWith<$Res> implements $MessageHeaderCopyWith<$Res> {
  factory _$MessageHeaderCopyWith(_MessageHeader value, $Res Function(_MessageHeader) _then) = __$MessageHeaderCopyWithImpl;
@override @useResult
$Res call({
 int numRequiredSignatures, int numReadonlySignedAccounts, int numReadonlyUnsignedAccounts
});




}
/// @nodoc
class __$MessageHeaderCopyWithImpl<$Res>
    implements _$MessageHeaderCopyWith<$Res> {
  __$MessageHeaderCopyWithImpl(this._self, this._then);

  final _MessageHeader _self;
  final $Res Function(_MessageHeader) _then;

/// Create a copy of MessageHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numRequiredSignatures = null,Object? numReadonlySignedAccounts = null,Object? numReadonlyUnsignedAccounts = null,}) {
  return _then(_MessageHeader(
numRequiredSignatures: null == numRequiredSignatures ? _self.numRequiredSignatures : numRequiredSignatures // ignore: cast_nullable_to_non_nullable
as int,numReadonlySignedAccounts: null == numReadonlySignedAccounts ? _self.numReadonlySignedAccounts : numReadonlySignedAccounts // ignore: cast_nullable_to_non_nullable
as int,numReadonlyUnsignedAccounts: null == numReadonlyUnsignedAccounts ? _self.numReadonlyUnsignedAccounts : numReadonlyUnsignedAccounts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
