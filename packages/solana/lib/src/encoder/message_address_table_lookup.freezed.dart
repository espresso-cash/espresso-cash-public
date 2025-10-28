// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_address_table_lookup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageAddressTableLookup {

 Ed25519HDPublicKey get accountKey; List<int> get writableIndexes; List<int> get readonlyIndexes;
/// Create a copy of MessageAddressTableLookup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageAddressTableLookupCopyWith<MessageAddressTableLookup> get copyWith => _$MessageAddressTableLookupCopyWithImpl<MessageAddressTableLookup>(this as MessageAddressTableLookup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageAddressTableLookup&&(identical(other.accountKey, accountKey) || other.accountKey == accountKey)&&const DeepCollectionEquality().equals(other.writableIndexes, writableIndexes)&&const DeepCollectionEquality().equals(other.readonlyIndexes, readonlyIndexes));
}


@override
int get hashCode => Object.hash(runtimeType,accountKey,const DeepCollectionEquality().hash(writableIndexes),const DeepCollectionEquality().hash(readonlyIndexes));

@override
String toString() {
  return 'MessageAddressTableLookup(accountKey: $accountKey, writableIndexes: $writableIndexes, readonlyIndexes: $readonlyIndexes)';
}


}

/// @nodoc
abstract mixin class $MessageAddressTableLookupCopyWith<$Res>  {
  factory $MessageAddressTableLookupCopyWith(MessageAddressTableLookup value, $Res Function(MessageAddressTableLookup) _then) = _$MessageAddressTableLookupCopyWithImpl;
@useResult
$Res call({
 Ed25519HDPublicKey accountKey, List<int> writableIndexes, List<int> readonlyIndexes
});




}
/// @nodoc
class _$MessageAddressTableLookupCopyWithImpl<$Res>
    implements $MessageAddressTableLookupCopyWith<$Res> {
  _$MessageAddressTableLookupCopyWithImpl(this._self, this._then);

  final MessageAddressTableLookup _self;
  final $Res Function(MessageAddressTableLookup) _then;

/// Create a copy of MessageAddressTableLookup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountKey = null,Object? writableIndexes = null,Object? readonlyIndexes = null,}) {
  return _then(_self.copyWith(
accountKey: null == accountKey ? _self.accountKey : accountKey // ignore: cast_nullable_to_non_nullable
as Ed25519HDPublicKey,writableIndexes: null == writableIndexes ? _self.writableIndexes : writableIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,readonlyIndexes: null == readonlyIndexes ? _self.readonlyIndexes : readonlyIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageAddressTableLookup].
extension MessageAddressTableLookupPatterns on MessageAddressTableLookup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageAddressTableLookup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageAddressTableLookup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageAddressTableLookup value)  $default,){
final _that = this;
switch (_that) {
case _MessageAddressTableLookup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageAddressTableLookup value)?  $default,){
final _that = this;
switch (_that) {
case _MessageAddressTableLookup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Ed25519HDPublicKey accountKey,  List<int> writableIndexes,  List<int> readonlyIndexes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageAddressTableLookup() when $default != null:
return $default(_that.accountKey,_that.writableIndexes,_that.readonlyIndexes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Ed25519HDPublicKey accountKey,  List<int> writableIndexes,  List<int> readonlyIndexes)  $default,) {final _that = this;
switch (_that) {
case _MessageAddressTableLookup():
return $default(_that.accountKey,_that.writableIndexes,_that.readonlyIndexes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Ed25519HDPublicKey accountKey,  List<int> writableIndexes,  List<int> readonlyIndexes)?  $default,) {final _that = this;
switch (_that) {
case _MessageAddressTableLookup() when $default != null:
return $default(_that.accountKey,_that.writableIndexes,_that.readonlyIndexes);case _:
  return null;

}
}

}

/// @nodoc


class _MessageAddressTableLookup implements MessageAddressTableLookup {
  const _MessageAddressTableLookup({required this.accountKey, required final  List<int> writableIndexes, required final  List<int> readonlyIndexes}): _writableIndexes = writableIndexes,_readonlyIndexes = readonlyIndexes;
  

@override final  Ed25519HDPublicKey accountKey;
 final  List<int> _writableIndexes;
@override List<int> get writableIndexes {
  if (_writableIndexes is EqualUnmodifiableListView) return _writableIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_writableIndexes);
}

 final  List<int> _readonlyIndexes;
@override List<int> get readonlyIndexes {
  if (_readonlyIndexes is EqualUnmodifiableListView) return _readonlyIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readonlyIndexes);
}


/// Create a copy of MessageAddressTableLookup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageAddressTableLookupCopyWith<_MessageAddressTableLookup> get copyWith => __$MessageAddressTableLookupCopyWithImpl<_MessageAddressTableLookup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageAddressTableLookup&&(identical(other.accountKey, accountKey) || other.accountKey == accountKey)&&const DeepCollectionEquality().equals(other._writableIndexes, _writableIndexes)&&const DeepCollectionEquality().equals(other._readonlyIndexes, _readonlyIndexes));
}


@override
int get hashCode => Object.hash(runtimeType,accountKey,const DeepCollectionEquality().hash(_writableIndexes),const DeepCollectionEquality().hash(_readonlyIndexes));

@override
String toString() {
  return 'MessageAddressTableLookup(accountKey: $accountKey, writableIndexes: $writableIndexes, readonlyIndexes: $readonlyIndexes)';
}


}

/// @nodoc
abstract mixin class _$MessageAddressTableLookupCopyWith<$Res> implements $MessageAddressTableLookupCopyWith<$Res> {
  factory _$MessageAddressTableLookupCopyWith(_MessageAddressTableLookup value, $Res Function(_MessageAddressTableLookup) _then) = __$MessageAddressTableLookupCopyWithImpl;
@override @useResult
$Res call({
 Ed25519HDPublicKey accountKey, List<int> writableIndexes, List<int> readonlyIndexes
});




}
/// @nodoc
class __$MessageAddressTableLookupCopyWithImpl<$Res>
    implements _$MessageAddressTableLookupCopyWith<$Res> {
  __$MessageAddressTableLookupCopyWithImpl(this._self, this._then);

  final _MessageAddressTableLookup _self;
  final $Res Function(_MessageAddressTableLookup) _then;

/// Create a copy of MessageAddressTableLookup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountKey = null,Object? writableIndexes = null,Object? readonlyIndexes = null,}) {
  return _then(_MessageAddressTableLookup(
accountKey: null == accountKey ? _self.accountKey : accountKey // ignore: cast_nullable_to_non_nullable
as Ed25519HDPublicKey,writableIndexes: null == writableIndexes ? _self._writableIndexes : writableIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,readonlyIndexes: null == readonlyIndexes ? _self._readonlyIndexes : readonlyIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
