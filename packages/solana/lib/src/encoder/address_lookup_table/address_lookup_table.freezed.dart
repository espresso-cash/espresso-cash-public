// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_lookup_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddressLookupTableState {

 BigInt get deactivationSlot; int get lastExtendedSlot; int get lastExtendedSlotStartIndex; Ed25519HDPublicKey? get authority; List<Ed25519HDPublicKey> get addresses;
/// Create a copy of AddressLookupTableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressLookupTableStateCopyWith<AddressLookupTableState> get copyWith => _$AddressLookupTableStateCopyWithImpl<AddressLookupTableState>(this as AddressLookupTableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressLookupTableState&&(identical(other.deactivationSlot, deactivationSlot) || other.deactivationSlot == deactivationSlot)&&(identical(other.lastExtendedSlot, lastExtendedSlot) || other.lastExtendedSlot == lastExtendedSlot)&&(identical(other.lastExtendedSlotStartIndex, lastExtendedSlotStartIndex) || other.lastExtendedSlotStartIndex == lastExtendedSlotStartIndex)&&(identical(other.authority, authority) || other.authority == authority)&&const DeepCollectionEquality().equals(other.addresses, addresses));
}


@override
int get hashCode => Object.hash(runtimeType,deactivationSlot,lastExtendedSlot,lastExtendedSlotStartIndex,authority,const DeepCollectionEquality().hash(addresses));

@override
String toString() {
  return 'AddressLookupTableState(deactivationSlot: $deactivationSlot, lastExtendedSlot: $lastExtendedSlot, lastExtendedSlotStartIndex: $lastExtendedSlotStartIndex, authority: $authority, addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class $AddressLookupTableStateCopyWith<$Res>  {
  factory $AddressLookupTableStateCopyWith(AddressLookupTableState value, $Res Function(AddressLookupTableState) _then) = _$AddressLookupTableStateCopyWithImpl;
@useResult
$Res call({
 BigInt deactivationSlot, int lastExtendedSlot, int lastExtendedSlotStartIndex, Ed25519HDPublicKey? authority, List<Ed25519HDPublicKey> addresses
});




}
/// @nodoc
class _$AddressLookupTableStateCopyWithImpl<$Res>
    implements $AddressLookupTableStateCopyWith<$Res> {
  _$AddressLookupTableStateCopyWithImpl(this._self, this._then);

  final AddressLookupTableState _self;
  final $Res Function(AddressLookupTableState) _then;

/// Create a copy of AddressLookupTableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deactivationSlot = null,Object? lastExtendedSlot = null,Object? lastExtendedSlotStartIndex = null,Object? authority = freezed,Object? addresses = null,}) {
  return _then(_self.copyWith(
deactivationSlot: null == deactivationSlot ? _self.deactivationSlot : deactivationSlot // ignore: cast_nullable_to_non_nullable
as BigInt,lastExtendedSlot: null == lastExtendedSlot ? _self.lastExtendedSlot : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
as int,lastExtendedSlotStartIndex: null == lastExtendedSlotStartIndex ? _self.lastExtendedSlotStartIndex : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
as int,authority: freezed == authority ? _self.authority : authority // ignore: cast_nullable_to_non_nullable
as Ed25519HDPublicKey?,addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressLookupTableState].
extension AddressLookupTableStatePatterns on AddressLookupTableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressLookupTableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressLookupTableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressLookupTableState value)  $default,){
final _that = this;
switch (_that) {
case _AddressLookupTableState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressLookupTableState value)?  $default,){
final _that = this;
switch (_that) {
case _AddressLookupTableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt deactivationSlot,  int lastExtendedSlot,  int lastExtendedSlotStartIndex,  Ed25519HDPublicKey? authority,  List<Ed25519HDPublicKey> addresses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressLookupTableState() when $default != null:
return $default(_that.deactivationSlot,_that.lastExtendedSlot,_that.lastExtendedSlotStartIndex,_that.authority,_that.addresses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt deactivationSlot,  int lastExtendedSlot,  int lastExtendedSlotStartIndex,  Ed25519HDPublicKey? authority,  List<Ed25519HDPublicKey> addresses)  $default,) {final _that = this;
switch (_that) {
case _AddressLookupTableState():
return $default(_that.deactivationSlot,_that.lastExtendedSlot,_that.lastExtendedSlotStartIndex,_that.authority,_that.addresses);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt deactivationSlot,  int lastExtendedSlot,  int lastExtendedSlotStartIndex,  Ed25519HDPublicKey? authority,  List<Ed25519HDPublicKey> addresses)?  $default,) {final _that = this;
switch (_that) {
case _AddressLookupTableState() when $default != null:
return $default(_that.deactivationSlot,_that.lastExtendedSlot,_that.lastExtendedSlotStartIndex,_that.authority,_that.addresses);case _:
  return null;

}
}

}

/// @nodoc


class _AddressLookupTableState implements AddressLookupTableState {
  const _AddressLookupTableState({required this.deactivationSlot, required this.lastExtendedSlot, required this.lastExtendedSlotStartIndex, required this.authority, required final  List<Ed25519HDPublicKey> addresses}): _addresses = addresses;
  

@override final  BigInt deactivationSlot;
@override final  int lastExtendedSlot;
@override final  int lastExtendedSlotStartIndex;
@override final  Ed25519HDPublicKey? authority;
 final  List<Ed25519HDPublicKey> _addresses;
@override List<Ed25519HDPublicKey> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}


/// Create a copy of AddressLookupTableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressLookupTableStateCopyWith<_AddressLookupTableState> get copyWith => __$AddressLookupTableStateCopyWithImpl<_AddressLookupTableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressLookupTableState&&(identical(other.deactivationSlot, deactivationSlot) || other.deactivationSlot == deactivationSlot)&&(identical(other.lastExtendedSlot, lastExtendedSlot) || other.lastExtendedSlot == lastExtendedSlot)&&(identical(other.lastExtendedSlotStartIndex, lastExtendedSlotStartIndex) || other.lastExtendedSlotStartIndex == lastExtendedSlotStartIndex)&&(identical(other.authority, authority) || other.authority == authority)&&const DeepCollectionEquality().equals(other._addresses, _addresses));
}


@override
int get hashCode => Object.hash(runtimeType,deactivationSlot,lastExtendedSlot,lastExtendedSlotStartIndex,authority,const DeepCollectionEquality().hash(_addresses));

@override
String toString() {
  return 'AddressLookupTableState(deactivationSlot: $deactivationSlot, lastExtendedSlot: $lastExtendedSlot, lastExtendedSlotStartIndex: $lastExtendedSlotStartIndex, authority: $authority, addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class _$AddressLookupTableStateCopyWith<$Res> implements $AddressLookupTableStateCopyWith<$Res> {
  factory _$AddressLookupTableStateCopyWith(_AddressLookupTableState value, $Res Function(_AddressLookupTableState) _then) = __$AddressLookupTableStateCopyWithImpl;
@override @useResult
$Res call({
 BigInt deactivationSlot, int lastExtendedSlot, int lastExtendedSlotStartIndex, Ed25519HDPublicKey? authority, List<Ed25519HDPublicKey> addresses
});




}
/// @nodoc
class __$AddressLookupTableStateCopyWithImpl<$Res>
    implements _$AddressLookupTableStateCopyWith<$Res> {
  __$AddressLookupTableStateCopyWithImpl(this._self, this._then);

  final _AddressLookupTableState _self;
  final $Res Function(_AddressLookupTableState) _then;

/// Create a copy of AddressLookupTableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deactivationSlot = null,Object? lastExtendedSlot = null,Object? lastExtendedSlotStartIndex = null,Object? authority = freezed,Object? addresses = null,}) {
  return _then(_AddressLookupTableState(
deactivationSlot: null == deactivationSlot ? _self.deactivationSlot : deactivationSlot // ignore: cast_nullable_to_non_nullable
as BigInt,lastExtendedSlot: null == lastExtendedSlot ? _self.lastExtendedSlot : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
as int,lastExtendedSlotStartIndex: null == lastExtendedSlotStartIndex ? _self.lastExtendedSlotStartIndex : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
as int,authority: freezed == authority ? _self.authority : authority // ignore: cast_nullable_to_non_nullable
as Ed25519HDPublicKey?,addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,
  ));
}


}

// dart format on
