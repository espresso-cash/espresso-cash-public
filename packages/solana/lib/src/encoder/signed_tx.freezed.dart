// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignedTx {

 List<Signature> get signatures; CompiledMessage get compiledMessage;
/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignedTxCopyWith<SignedTx> get copyWith => _$SignedTxCopyWithImpl<SignedTx>(this as SignedTx, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedTx&&const DeepCollectionEquality().equals(other.signatures, signatures)&&(identical(other.compiledMessage, compiledMessage) || other.compiledMessage == compiledMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(signatures),compiledMessage);

@override
String toString() {
  return 'SignedTx(signatures: $signatures, compiledMessage: $compiledMessage)';
}


}

/// @nodoc
abstract mixin class $SignedTxCopyWith<$Res>  {
  factory $SignedTxCopyWith(SignedTx value, $Res Function(SignedTx) _then) = _$SignedTxCopyWithImpl;
@useResult
$Res call({
 List<Signature> signatures, CompiledMessage compiledMessage
});


$CompiledMessageCopyWith<$Res> get compiledMessage;

}
/// @nodoc
class _$SignedTxCopyWithImpl<$Res>
    implements $SignedTxCopyWith<$Res> {
  _$SignedTxCopyWithImpl(this._self, this._then);

  final SignedTx _self;
  final $Res Function(SignedTx) _then;

/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signatures = null,Object? compiledMessage = null,}) {
  return _then(_self.copyWith(
signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,compiledMessage: null == compiledMessage ? _self.compiledMessage : compiledMessage // ignore: cast_nullable_to_non_nullable
as CompiledMessage,
  ));
}
/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompiledMessageCopyWith<$Res> get compiledMessage {
  
  return $CompiledMessageCopyWith<$Res>(_self.compiledMessage, (value) {
    return _then(_self.copyWith(compiledMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignedTx].
extension SignedTxPatterns on SignedTx {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignedTx value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignedTx() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignedTx value)  $default,){
final _that = this;
switch (_that) {
case _SignedTx():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignedTx value)?  $default,){
final _that = this;
switch (_that) {
case _SignedTx() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Signature> signatures,  CompiledMessage compiledMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignedTx() when $default != null:
return $default(_that.signatures,_that.compiledMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Signature> signatures,  CompiledMessage compiledMessage)  $default,) {final _that = this;
switch (_that) {
case _SignedTx():
return $default(_that.signatures,_that.compiledMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Signature> signatures,  CompiledMessage compiledMessage)?  $default,) {final _that = this;
switch (_that) {
case _SignedTx() when $default != null:
return $default(_that.signatures,_that.compiledMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SignedTx extends SignedTx {
  const _SignedTx({final  List<Signature> signatures = const <Signature>[], required this.compiledMessage}): _signatures = signatures,super._();
  

 final  List<Signature> _signatures;
@override@JsonKey() List<Signature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

@override final  CompiledMessage compiledMessage;

/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignedTxCopyWith<_SignedTx> get copyWith => __$SignedTxCopyWithImpl<_SignedTx>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignedTx&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&(identical(other.compiledMessage, compiledMessage) || other.compiledMessage == compiledMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_signatures),compiledMessage);

@override
String toString() {
  return 'SignedTx(signatures: $signatures, compiledMessage: $compiledMessage)';
}


}

/// @nodoc
abstract mixin class _$SignedTxCopyWith<$Res> implements $SignedTxCopyWith<$Res> {
  factory _$SignedTxCopyWith(_SignedTx value, $Res Function(_SignedTx) _then) = __$SignedTxCopyWithImpl;
@override @useResult
$Res call({
 List<Signature> signatures, CompiledMessage compiledMessage
});


@override $CompiledMessageCopyWith<$Res> get compiledMessage;

}
/// @nodoc
class __$SignedTxCopyWithImpl<$Res>
    implements _$SignedTxCopyWith<$Res> {
  __$SignedTxCopyWithImpl(this._self, this._then);

  final _SignedTx _self;
  final $Res Function(_SignedTx) _then;

/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signatures = null,Object? compiledMessage = null,}) {
  return _then(_SignedTx(
signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,compiledMessage: null == compiledMessage ? _self.compiledMessage : compiledMessage // ignore: cast_nullable_to_non_nullable
as CompiledMessage,
  ));
}

/// Create a copy of SignedTx
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompiledMessageCopyWith<$Res> get compiledMessage {
  
  return $CompiledMessageCopyWith<$Res>(_self.compiledMessage, (value) {
    return _then(_self.copyWith(compiledMessage: value));
  });
}
}

// dart format on
