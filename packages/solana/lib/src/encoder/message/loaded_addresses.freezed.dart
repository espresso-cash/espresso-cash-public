// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loaded_addresses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoadedAddresses {

 List<Ed25519HDPublicKey> get writable; List<Ed25519HDPublicKey> get readonly;
/// Create a copy of LoadedAddresses
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedAddressesCopyWith<LoadedAddresses> get copyWith => _$LoadedAddressesCopyWithImpl<LoadedAddresses>(this as LoadedAddresses, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedAddresses&&const DeepCollectionEquality().equals(other.writable, writable)&&const DeepCollectionEquality().equals(other.readonly, readonly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(writable),const DeepCollectionEquality().hash(readonly));

@override
String toString() {
  return 'LoadedAddresses(writable: $writable, readonly: $readonly)';
}


}

/// @nodoc
abstract mixin class $LoadedAddressesCopyWith<$Res>  {
  factory $LoadedAddressesCopyWith(LoadedAddresses value, $Res Function(LoadedAddresses) _then) = _$LoadedAddressesCopyWithImpl;
@useResult
$Res call({
 List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly
});




}
/// @nodoc
class _$LoadedAddressesCopyWithImpl<$Res>
    implements $LoadedAddressesCopyWith<$Res> {
  _$LoadedAddressesCopyWithImpl(this._self, this._then);

  final LoadedAddresses _self;
  final $Res Function(LoadedAddresses) _then;

/// Create a copy of LoadedAddresses
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? writable = null,Object? readonly = null,}) {
  return _then(_self.copyWith(
writable: null == writable ? _self.writable : writable // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,readonly: null == readonly ? _self.readonly : readonly // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,
  ));
}

}


/// Adds pattern-matching-related methods to [LoadedAddresses].
extension LoadedAddressesPatterns on LoadedAddresses {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoadedAddresses value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadedAddresses() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoadedAddresses value)  $default,){
final _that = this;
switch (_that) {
case _LoadedAddresses():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoadedAddresses value)?  $default,){
final _that = this;
switch (_that) {
case _LoadedAddresses() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Ed25519HDPublicKey> writable,  List<Ed25519HDPublicKey> readonly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadedAddresses() when $default != null:
return $default(_that.writable,_that.readonly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Ed25519HDPublicKey> writable,  List<Ed25519HDPublicKey> readonly)  $default,) {final _that = this;
switch (_that) {
case _LoadedAddresses():
return $default(_that.writable,_that.readonly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Ed25519HDPublicKey> writable,  List<Ed25519HDPublicKey> readonly)?  $default,) {final _that = this;
switch (_that) {
case _LoadedAddresses() when $default != null:
return $default(_that.writable,_that.readonly);case _:
  return null;

}
}

}

/// @nodoc


class _LoadedAddresses implements LoadedAddresses {
  const _LoadedAddresses({required final  List<Ed25519HDPublicKey> writable, required final  List<Ed25519HDPublicKey> readonly}): _writable = writable,_readonly = readonly;
  

 final  List<Ed25519HDPublicKey> _writable;
@override List<Ed25519HDPublicKey> get writable {
  if (_writable is EqualUnmodifiableListView) return _writable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_writable);
}

 final  List<Ed25519HDPublicKey> _readonly;
@override List<Ed25519HDPublicKey> get readonly {
  if (_readonly is EqualUnmodifiableListView) return _readonly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readonly);
}


/// Create a copy of LoadedAddresses
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedAddressesCopyWith<_LoadedAddresses> get copyWith => __$LoadedAddressesCopyWithImpl<_LoadedAddresses>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedAddresses&&const DeepCollectionEquality().equals(other._writable, _writable)&&const DeepCollectionEquality().equals(other._readonly, _readonly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_writable),const DeepCollectionEquality().hash(_readonly));

@override
String toString() {
  return 'LoadedAddresses(writable: $writable, readonly: $readonly)';
}


}

/// @nodoc
abstract mixin class _$LoadedAddressesCopyWith<$Res> implements $LoadedAddressesCopyWith<$Res> {
  factory _$LoadedAddressesCopyWith(_LoadedAddresses value, $Res Function(_LoadedAddresses) _then) = __$LoadedAddressesCopyWithImpl;
@override @useResult
$Res call({
 List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly
});




}
/// @nodoc
class __$LoadedAddressesCopyWithImpl<$Res>
    implements _$LoadedAddressesCopyWith<$Res> {
  __$LoadedAddressesCopyWithImpl(this._self, this._then);

  final _LoadedAddresses _self;
  final $Res Function(_LoadedAddresses) _then;

/// Create a copy of LoadedAddresses
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? writable = null,Object? readonly = null,}) {
  return _then(_LoadedAddresses(
writable: null == writable ? _self._writable : writable // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,readonly: null == readonly ? _self._readonly : readonly // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,
  ));
}


}

// dart format on
