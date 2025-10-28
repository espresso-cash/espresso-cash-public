// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compiled_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompiledMessage {

 MessageHeader get header; List<Ed25519HDPublicKey> get accountKeys; String get recentBlockhash; List<CompiledInstruction> get instructions;
/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompiledMessageCopyWith<CompiledMessage> get copyWith => _$CompiledMessageCopyWithImpl<CompiledMessage>(this as CompiledMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompiledMessage&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other.accountKeys, accountKeys)&&(identical(other.recentBlockhash, recentBlockhash) || other.recentBlockhash == recentBlockhash)&&const DeepCollectionEquality().equals(other.instructions, instructions));
}


@override
int get hashCode => Object.hash(runtimeType,header,const DeepCollectionEquality().hash(accountKeys),recentBlockhash,const DeepCollectionEquality().hash(instructions));

@override
String toString() {
  return 'CompiledMessage(header: $header, accountKeys: $accountKeys, recentBlockhash: $recentBlockhash, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $CompiledMessageCopyWith<$Res>  {
  factory $CompiledMessageCopyWith(CompiledMessage value, $Res Function(CompiledMessage) _then) = _$CompiledMessageCopyWithImpl;
@useResult
$Res call({
 MessageHeader header, List<Ed25519HDPublicKey> accountKeys, String recentBlockhash, List<CompiledInstruction> instructions
});


$MessageHeaderCopyWith<$Res> get header;

}
/// @nodoc
class _$CompiledMessageCopyWithImpl<$Res>
    implements $CompiledMessageCopyWith<$Res> {
  _$CompiledMessageCopyWithImpl(this._self, this._then);

  final CompiledMessage _self;
  final $Res Function(CompiledMessage) _then;

/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? header = null,Object? accountKeys = null,Object? recentBlockhash = null,Object? instructions = null,}) {
  return _then(_self.copyWith(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as MessageHeader,accountKeys: null == accountKeys ? _self.accountKeys : accountKeys // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,recentBlockhash: null == recentBlockhash ? _self.recentBlockhash : recentBlockhash // ignore: cast_nullable_to_non_nullable
as String,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<CompiledInstruction>,
  ));
}
/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageHeaderCopyWith<$Res> get header {
  
  return $MessageHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompiledMessage].
extension CompiledMessagePatterns on CompiledMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CompiledMessageLegacy value)?  legacy,TResult Function( CompiledMessageV0 value)?  v0,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CompiledMessageLegacy() when legacy != null:
return legacy(_that);case CompiledMessageV0() when v0 != null:
return v0(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CompiledMessageLegacy value)  legacy,required TResult Function( CompiledMessageV0 value)  v0,}){
final _that = this;
switch (_that) {
case CompiledMessageLegacy():
return legacy(_that);case CompiledMessageV0():
return v0(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CompiledMessageLegacy value)?  legacy,TResult? Function( CompiledMessageV0 value)?  v0,}){
final _that = this;
switch (_that) {
case CompiledMessageLegacy() when legacy != null:
return legacy(_that);case CompiledMessageV0() when v0 != null:
return v0(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions)?  legacy,TResult Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions,  List<MessageAddressTableLookup> addressTableLookups)?  v0,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CompiledMessageLegacy() when legacy != null:
return legacy(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions);case CompiledMessageV0() when v0 != null:
return v0(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions,_that.addressTableLookups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions)  legacy,required TResult Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions,  List<MessageAddressTableLookup> addressTableLookups)  v0,}) {final _that = this;
switch (_that) {
case CompiledMessageLegacy():
return legacy(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions);case CompiledMessageV0():
return v0(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions,_that.addressTableLookups);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions)?  legacy,TResult? Function( MessageHeader header,  List<Ed25519HDPublicKey> accountKeys,  String recentBlockhash,  List<CompiledInstruction> instructions,  List<MessageAddressTableLookup> addressTableLookups)?  v0,}) {final _that = this;
switch (_that) {
case CompiledMessageLegacy() when legacy != null:
return legacy(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions);case CompiledMessageV0() when v0 != null:
return v0(_that.header,_that.accountKeys,_that.recentBlockhash,_that.instructions,_that.addressTableLookups);case _:
  return null;

}
}

}

/// @nodoc


class CompiledMessageLegacy extends CompiledMessage {
  const CompiledMessageLegacy({required this.header, required final  List<Ed25519HDPublicKey> accountKeys, required this.recentBlockhash, required final  List<CompiledInstruction> instructions}): _accountKeys = accountKeys,_instructions = instructions,super._();
  

@override final  MessageHeader header;
 final  List<Ed25519HDPublicKey> _accountKeys;
@override List<Ed25519HDPublicKey> get accountKeys {
  if (_accountKeys is EqualUnmodifiableListView) return _accountKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accountKeys);
}

@override final  String recentBlockhash;
 final  List<CompiledInstruction> _instructions;
@override List<CompiledInstruction> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}


/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompiledMessageLegacyCopyWith<CompiledMessageLegacy> get copyWith => _$CompiledMessageLegacyCopyWithImpl<CompiledMessageLegacy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompiledMessageLegacy&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other._accountKeys, _accountKeys)&&(identical(other.recentBlockhash, recentBlockhash) || other.recentBlockhash == recentBlockhash)&&const DeepCollectionEquality().equals(other._instructions, _instructions));
}


@override
int get hashCode => Object.hash(runtimeType,header,const DeepCollectionEquality().hash(_accountKeys),recentBlockhash,const DeepCollectionEquality().hash(_instructions));

@override
String toString() {
  return 'CompiledMessage.legacy(header: $header, accountKeys: $accountKeys, recentBlockhash: $recentBlockhash, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $CompiledMessageLegacyCopyWith<$Res> implements $CompiledMessageCopyWith<$Res> {
  factory $CompiledMessageLegacyCopyWith(CompiledMessageLegacy value, $Res Function(CompiledMessageLegacy) _then) = _$CompiledMessageLegacyCopyWithImpl;
@override @useResult
$Res call({
 MessageHeader header, List<Ed25519HDPublicKey> accountKeys, String recentBlockhash, List<CompiledInstruction> instructions
});


@override $MessageHeaderCopyWith<$Res> get header;

}
/// @nodoc
class _$CompiledMessageLegacyCopyWithImpl<$Res>
    implements $CompiledMessageLegacyCopyWith<$Res> {
  _$CompiledMessageLegacyCopyWithImpl(this._self, this._then);

  final CompiledMessageLegacy _self;
  final $Res Function(CompiledMessageLegacy) _then;

/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? header = null,Object? accountKeys = null,Object? recentBlockhash = null,Object? instructions = null,}) {
  return _then(CompiledMessageLegacy(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as MessageHeader,accountKeys: null == accountKeys ? _self._accountKeys : accountKeys // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,recentBlockhash: null == recentBlockhash ? _self.recentBlockhash : recentBlockhash // ignore: cast_nullable_to_non_nullable
as String,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<CompiledInstruction>,
  ));
}

/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageHeaderCopyWith<$Res> get header {
  
  return $MessageHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}

/// @nodoc


class CompiledMessageV0 extends CompiledMessage {
  const CompiledMessageV0({required this.header, required final  List<Ed25519HDPublicKey> accountKeys, required this.recentBlockhash, required final  List<CompiledInstruction> instructions, required final  List<MessageAddressTableLookup> addressTableLookups}): _accountKeys = accountKeys,_instructions = instructions,_addressTableLookups = addressTableLookups,super._();
  

@override final  MessageHeader header;
 final  List<Ed25519HDPublicKey> _accountKeys;
@override List<Ed25519HDPublicKey> get accountKeys {
  if (_accountKeys is EqualUnmodifiableListView) return _accountKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accountKeys);
}

@override final  String recentBlockhash;
 final  List<CompiledInstruction> _instructions;
@override List<CompiledInstruction> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}

 final  List<MessageAddressTableLookup> _addressTableLookups;
 List<MessageAddressTableLookup> get addressTableLookups {
  if (_addressTableLookups is EqualUnmodifiableListView) return _addressTableLookups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addressTableLookups);
}


/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompiledMessageV0CopyWith<CompiledMessageV0> get copyWith => _$CompiledMessageV0CopyWithImpl<CompiledMessageV0>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompiledMessageV0&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other._accountKeys, _accountKeys)&&(identical(other.recentBlockhash, recentBlockhash) || other.recentBlockhash == recentBlockhash)&&const DeepCollectionEquality().equals(other._instructions, _instructions)&&const DeepCollectionEquality().equals(other._addressTableLookups, _addressTableLookups));
}


@override
int get hashCode => Object.hash(runtimeType,header,const DeepCollectionEquality().hash(_accountKeys),recentBlockhash,const DeepCollectionEquality().hash(_instructions),const DeepCollectionEquality().hash(_addressTableLookups));

@override
String toString() {
  return 'CompiledMessage.v0(header: $header, accountKeys: $accountKeys, recentBlockhash: $recentBlockhash, instructions: $instructions, addressTableLookups: $addressTableLookups)';
}


}

/// @nodoc
abstract mixin class $CompiledMessageV0CopyWith<$Res> implements $CompiledMessageCopyWith<$Res> {
  factory $CompiledMessageV0CopyWith(CompiledMessageV0 value, $Res Function(CompiledMessageV0) _then) = _$CompiledMessageV0CopyWithImpl;
@override @useResult
$Res call({
 MessageHeader header, List<Ed25519HDPublicKey> accountKeys, String recentBlockhash, List<CompiledInstruction> instructions, List<MessageAddressTableLookup> addressTableLookups
});


@override $MessageHeaderCopyWith<$Res> get header;

}
/// @nodoc
class _$CompiledMessageV0CopyWithImpl<$Res>
    implements $CompiledMessageV0CopyWith<$Res> {
  _$CompiledMessageV0CopyWithImpl(this._self, this._then);

  final CompiledMessageV0 _self;
  final $Res Function(CompiledMessageV0) _then;

/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? header = null,Object? accountKeys = null,Object? recentBlockhash = null,Object? instructions = null,Object? addressTableLookups = null,}) {
  return _then(CompiledMessageV0(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as MessageHeader,accountKeys: null == accountKeys ? _self._accountKeys : accountKeys // ignore: cast_nullable_to_non_nullable
as List<Ed25519HDPublicKey>,recentBlockhash: null == recentBlockhash ? _self.recentBlockhash : recentBlockhash // ignore: cast_nullable_to_non_nullable
as String,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<CompiledInstruction>,addressTableLookups: null == addressTableLookups ? _self._addressTableLookups : addressTableLookups // ignore: cast_nullable_to_non_nullable
as List<MessageAddressTableLookup>,
  ));
}

/// Create a copy of CompiledMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageHeaderCopyWith<$Res> get header {
  
  return $MessageHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}

// dart format on
