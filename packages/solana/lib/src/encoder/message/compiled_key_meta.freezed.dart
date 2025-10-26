// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compiled_key_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompiledKeyMeta {

 bool get isSigner; bool get isWritable; bool get isInvoked;
/// Create a copy of CompiledKeyMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompiledKeyMetaCopyWith<CompiledKeyMeta> get copyWith => _$CompiledKeyMetaCopyWithImpl<CompiledKeyMeta>(this as CompiledKeyMeta, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompiledKeyMeta&&(identical(other.isSigner, isSigner) || other.isSigner == isSigner)&&(identical(other.isWritable, isWritable) || other.isWritable == isWritable)&&(identical(other.isInvoked, isInvoked) || other.isInvoked == isInvoked));
}


@override
int get hashCode => Object.hash(runtimeType,isSigner,isWritable,isInvoked);

@override
String toString() {
  return 'CompiledKeyMeta(isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked)';
}


}

/// @nodoc
abstract mixin class $CompiledKeyMetaCopyWith<$Res>  {
  factory $CompiledKeyMetaCopyWith(CompiledKeyMeta value, $Res Function(CompiledKeyMeta) _then) = _$CompiledKeyMetaCopyWithImpl;
@useResult
$Res call({
 bool isSigner, bool isWritable, bool isInvoked
});




}
/// @nodoc
class _$CompiledKeyMetaCopyWithImpl<$Res>
    implements $CompiledKeyMetaCopyWith<$Res> {
  _$CompiledKeyMetaCopyWithImpl(this._self, this._then);

  final CompiledKeyMeta _self;
  final $Res Function(CompiledKeyMeta) _then;

/// Create a copy of CompiledKeyMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSigner = null,Object? isWritable = null,Object? isInvoked = null,}) {
  return _then(_self.copyWith(
isSigner: null == isSigner ? _self.isSigner : isSigner // ignore: cast_nullable_to_non_nullable
as bool,isWritable: null == isWritable ? _self.isWritable : isWritable // ignore: cast_nullable_to_non_nullable
as bool,isInvoked: null == isInvoked ? _self.isInvoked : isInvoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompiledKeyMeta].
extension CompiledKeyMetaPatterns on CompiledKeyMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompiledKeyMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompiledKeyMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompiledKeyMeta value)  $default,){
final _that = this;
switch (_that) {
case _CompiledKeyMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompiledKeyMeta value)?  $default,){
final _that = this;
switch (_that) {
case _CompiledKeyMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSigner,  bool isWritable,  bool isInvoked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompiledKeyMeta() when $default != null:
return $default(_that.isSigner,_that.isWritable,_that.isInvoked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSigner,  bool isWritable,  bool isInvoked)  $default,) {final _that = this;
switch (_that) {
case _CompiledKeyMeta():
return $default(_that.isSigner,_that.isWritable,_that.isInvoked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSigner,  bool isWritable,  bool isInvoked)?  $default,) {final _that = this;
switch (_that) {
case _CompiledKeyMeta() when $default != null:
return $default(_that.isSigner,_that.isWritable,_that.isInvoked);case _:
  return null;

}
}

}

/// @nodoc


class _CompiledKeyMeta implements CompiledKeyMeta {
  const _CompiledKeyMeta({required this.isSigner, required this.isWritable, required this.isInvoked});
  

@override final  bool isSigner;
@override final  bool isWritable;
@override final  bool isInvoked;

/// Create a copy of CompiledKeyMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompiledKeyMetaCopyWith<_CompiledKeyMeta> get copyWith => __$CompiledKeyMetaCopyWithImpl<_CompiledKeyMeta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompiledKeyMeta&&(identical(other.isSigner, isSigner) || other.isSigner == isSigner)&&(identical(other.isWritable, isWritable) || other.isWritable == isWritable)&&(identical(other.isInvoked, isInvoked) || other.isInvoked == isInvoked));
}


@override
int get hashCode => Object.hash(runtimeType,isSigner,isWritable,isInvoked);

@override
String toString() {
  return 'CompiledKeyMeta(isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked)';
}


}

/// @nodoc
abstract mixin class _$CompiledKeyMetaCopyWith<$Res> implements $CompiledKeyMetaCopyWith<$Res> {
  factory _$CompiledKeyMetaCopyWith(_CompiledKeyMeta value, $Res Function(_CompiledKeyMeta) _then) = __$CompiledKeyMetaCopyWithImpl;
@override @useResult
$Res call({
 bool isSigner, bool isWritable, bool isInvoked
});




}
/// @nodoc
class __$CompiledKeyMetaCopyWithImpl<$Res>
    implements _$CompiledKeyMetaCopyWith<$Res> {
  __$CompiledKeyMetaCopyWithImpl(this._self, this._then);

  final _CompiledKeyMeta _self;
  final $Res Function(_CompiledKeyMeta) _then;

/// Create a copy of CompiledKeyMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSigner = null,Object? isWritable = null,Object? isInvoked = null,}) {
  return _then(_CompiledKeyMeta(
isSigner: null == isSigner ? _self.isSigner : isSigner // ignore: cast_nullable_to_non_nullable
as bool,isWritable: null == isWritable ? _self.isWritable : isWritable // ignore: cast_nullable_to_non_nullable
as bool,isInvoked: null == isInvoked ? _self.isInvoked : isInvoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
