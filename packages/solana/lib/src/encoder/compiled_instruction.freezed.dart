// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compiled_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompiledInstruction {

 int get programIdIndex; List<int> get accountKeyIndexes; ByteArray get data;
/// Create a copy of CompiledInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompiledInstructionCopyWith<CompiledInstruction> get copyWith => _$CompiledInstructionCopyWithImpl<CompiledInstruction>(this as CompiledInstruction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompiledInstruction&&(identical(other.programIdIndex, programIdIndex) || other.programIdIndex == programIdIndex)&&const DeepCollectionEquality().equals(other.accountKeyIndexes, accountKeyIndexes)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,programIdIndex,const DeepCollectionEquality().hash(accountKeyIndexes),const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CompiledInstruction(programIdIndex: $programIdIndex, accountKeyIndexes: $accountKeyIndexes, data: $data)';
}


}

/// @nodoc
abstract mixin class $CompiledInstructionCopyWith<$Res>  {
  factory $CompiledInstructionCopyWith(CompiledInstruction value, $Res Function(CompiledInstruction) _then) = _$CompiledInstructionCopyWithImpl;
@useResult
$Res call({
 int programIdIndex, List<int> accountKeyIndexes, ByteArray data
});




}
/// @nodoc
class _$CompiledInstructionCopyWithImpl<$Res>
    implements $CompiledInstructionCopyWith<$Res> {
  _$CompiledInstructionCopyWithImpl(this._self, this._then);

  final CompiledInstruction _self;
  final $Res Function(CompiledInstruction) _then;

/// Create a copy of CompiledInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? programIdIndex = null,Object? accountKeyIndexes = null,Object? data = null,}) {
  return _then(_self.copyWith(
programIdIndex: null == programIdIndex ? _self.programIdIndex : programIdIndex // ignore: cast_nullable_to_non_nullable
as int,accountKeyIndexes: null == accountKeyIndexes ? _self.accountKeyIndexes : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ByteArray,
  ));
}

}


/// Adds pattern-matching-related methods to [CompiledInstruction].
extension CompiledInstructionPatterns on CompiledInstruction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompiledInstruction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompiledInstruction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompiledInstruction value)  $default,){
final _that = this;
switch (_that) {
case _CompiledInstruction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompiledInstruction value)?  $default,){
final _that = this;
switch (_that) {
case _CompiledInstruction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int programIdIndex,  List<int> accountKeyIndexes,  ByteArray data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompiledInstruction() when $default != null:
return $default(_that.programIdIndex,_that.accountKeyIndexes,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int programIdIndex,  List<int> accountKeyIndexes,  ByteArray data)  $default,) {final _that = this;
switch (_that) {
case _CompiledInstruction():
return $default(_that.programIdIndex,_that.accountKeyIndexes,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int programIdIndex,  List<int> accountKeyIndexes,  ByteArray data)?  $default,) {final _that = this;
switch (_that) {
case _CompiledInstruction() when $default != null:
return $default(_that.programIdIndex,_that.accountKeyIndexes,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _CompiledInstruction extends CompiledInstruction {
  const _CompiledInstruction({required this.programIdIndex, required final  List<int> accountKeyIndexes, required this.data}): _accountKeyIndexes = accountKeyIndexes,super._();
  

@override final  int programIdIndex;
 final  List<int> _accountKeyIndexes;
@override List<int> get accountKeyIndexes {
  if (_accountKeyIndexes is EqualUnmodifiableListView) return _accountKeyIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accountKeyIndexes);
}

@override final  ByteArray data;

/// Create a copy of CompiledInstruction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompiledInstructionCopyWith<_CompiledInstruction> get copyWith => __$CompiledInstructionCopyWithImpl<_CompiledInstruction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompiledInstruction&&(identical(other.programIdIndex, programIdIndex) || other.programIdIndex == programIdIndex)&&const DeepCollectionEquality().equals(other._accountKeyIndexes, _accountKeyIndexes)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,programIdIndex,const DeepCollectionEquality().hash(_accountKeyIndexes),const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CompiledInstruction(programIdIndex: $programIdIndex, accountKeyIndexes: $accountKeyIndexes, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CompiledInstructionCopyWith<$Res> implements $CompiledInstructionCopyWith<$Res> {
  factory _$CompiledInstructionCopyWith(_CompiledInstruction value, $Res Function(_CompiledInstruction) _then) = __$CompiledInstructionCopyWithImpl;
@override @useResult
$Res call({
 int programIdIndex, List<int> accountKeyIndexes, ByteArray data
});




}
/// @nodoc
class __$CompiledInstructionCopyWithImpl<$Res>
    implements _$CompiledInstructionCopyWith<$Res> {
  __$CompiledInstructionCopyWithImpl(this._self, this._then);

  final _CompiledInstruction _self;
  final $Res Function(_CompiledInstruction) _then;

/// Create a copy of CompiledInstruction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? programIdIndex = null,Object? accountKeyIndexes = null,Object? data = null,}) {
  return _then(_CompiledInstruction(
programIdIndex: null == programIdIndex ? _self.programIdIndex : programIdIndex // ignore: cast_nullable_to_non_nullable
as int,accountKeyIndexes: null == accountKeyIndexes ? _self._accountKeyIndexes : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ByteArray,
  ));
}


}

// dart format on
