// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ParsedInstruction _$ParsedInstructionFromJson(
  Map<String, dynamic> json
) {
        switch (json['program']) {
                  case 'system':
          return ParsedInstructionSystem.fromJson(
            json
          );
                case 'spl-token':
          return ParsedInstructionSplToken.fromJson(
            json
          );
                case 'spl-memo':
          return ParsedInstructionMemo.fromJson(
            json
          );
        
          default:
            return ParsedInstructionUnsupported.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$ParsedInstruction {



  /// Serializes this ParsedInstruction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedInstruction);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParsedInstruction()';
}


}

/// @nodoc
class $ParsedInstructionCopyWith<$Res>  {
$ParsedInstructionCopyWith(ParsedInstruction _, $Res Function(ParsedInstruction) __);
}


/// Adds pattern-matching-related methods to [ParsedInstruction].
extension ParsedInstructionPatterns on ParsedInstruction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParsedInstructionSystem value)?  system,TResult Function( ParsedInstructionSplToken value)?  splToken,TResult Function( ParsedInstructionMemo value)?  memo,TResult Function( ParsedInstructionUnsupported value)?  unsupported,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParsedInstructionSystem() when system != null:
return system(_that);case ParsedInstructionSplToken() when splToken != null:
return splToken(_that);case ParsedInstructionMemo() when memo != null:
return memo(_that);case ParsedInstructionUnsupported() when unsupported != null:
return unsupported(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParsedInstructionSystem value)  system,required TResult Function( ParsedInstructionSplToken value)  splToken,required TResult Function( ParsedInstructionMemo value)  memo,required TResult Function( ParsedInstructionUnsupported value)  unsupported,}){
final _that = this;
switch (_that) {
case ParsedInstructionSystem():
return system(_that);case ParsedInstructionSplToken():
return splToken(_that);case ParsedInstructionMemo():
return memo(_that);case ParsedInstructionUnsupported():
return unsupported(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParsedInstructionSystem value)?  system,TResult? Function( ParsedInstructionSplToken value)?  splToken,TResult? Function( ParsedInstructionMemo value)?  memo,TResult? Function( ParsedInstructionUnsupported value)?  unsupported,}){
final _that = this;
switch (_that) {
case ParsedInstructionSystem() when system != null:
return system(_that);case ParsedInstructionSplToken() when splToken != null:
return splToken(_that);case ParsedInstructionMemo() when memo != null:
return memo(_that);case ParsedInstructionUnsupported() when unsupported != null:
return unsupported(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String programId,  ParsedSystemInstruction parsed)?  system,TResult Function( ParsedSplTokenInstruction parsed)?  splToken,TResult Function(@JsonKey(name: 'parsed')  String? memo)?  memo,TResult Function( String? program)?  unsupported,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParsedInstructionSystem() when system != null:
return system(_that.programId,_that.parsed);case ParsedInstructionSplToken() when splToken != null:
return splToken(_that.parsed);case ParsedInstructionMemo() when memo != null:
return memo(_that.memo);case ParsedInstructionUnsupported() when unsupported != null:
return unsupported(_that.program);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String programId,  ParsedSystemInstruction parsed)  system,required TResult Function( ParsedSplTokenInstruction parsed)  splToken,required TResult Function(@JsonKey(name: 'parsed')  String? memo)  memo,required TResult Function( String? program)  unsupported,}) {final _that = this;
switch (_that) {
case ParsedInstructionSystem():
return system(_that.programId,_that.parsed);case ParsedInstructionSplToken():
return splToken(_that.parsed);case ParsedInstructionMemo():
return memo(_that.memo);case ParsedInstructionUnsupported():
return unsupported(_that.program);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String programId,  ParsedSystemInstruction parsed)?  system,TResult? Function( ParsedSplTokenInstruction parsed)?  splToken,TResult? Function(@JsonKey(name: 'parsed')  String? memo)?  memo,TResult? Function( String? program)?  unsupported,}) {final _that = this;
switch (_that) {
case ParsedInstructionSystem() when system != null:
return system(_that.programId,_that.parsed);case ParsedInstructionSplToken() when splToken != null:
return splToken(_that.parsed);case ParsedInstructionMemo() when memo != null:
return memo(_that.memo);case ParsedInstructionUnsupported() when unsupported != null:
return unsupported(_that.program);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ParsedInstructionSystem implements ParsedInstruction {
  const ParsedInstructionSystem({required this.programId, required this.parsed, final  String? $type}): $type = $type ?? 'system';
  factory ParsedInstructionSystem.fromJson(Map<String, dynamic> json) => _$ParsedInstructionSystemFromJson(json);

 final  String programId;
 final  ParsedSystemInstruction parsed;

@JsonKey(name: 'program')
final String $type;


/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedInstructionSystemCopyWith<ParsedInstructionSystem> get copyWith => _$ParsedInstructionSystemCopyWithImpl<ParsedInstructionSystem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedInstructionSystemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedInstructionSystem&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.parsed, parsed) || other.parsed == parsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,programId,parsed);

@override
String toString() {
  return 'ParsedInstruction.system(programId: $programId, parsed: $parsed)';
}


}

/// @nodoc
abstract mixin class $ParsedInstructionSystemCopyWith<$Res> implements $ParsedInstructionCopyWith<$Res> {
  factory $ParsedInstructionSystemCopyWith(ParsedInstructionSystem value, $Res Function(ParsedInstructionSystem) _then) = _$ParsedInstructionSystemCopyWithImpl;
@useResult
$Res call({
 String programId, ParsedSystemInstruction parsed
});


$ParsedSystemInstructionCopyWith<$Res> get parsed;

}
/// @nodoc
class _$ParsedInstructionSystemCopyWithImpl<$Res>
    implements $ParsedInstructionSystemCopyWith<$Res> {
  _$ParsedInstructionSystemCopyWithImpl(this._self, this._then);

  final ParsedInstructionSystem _self;
  final $Res Function(ParsedInstructionSystem) _then;

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? programId = null,Object? parsed = null,}) {
  return _then(ParsedInstructionSystem(
programId: null == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as String,parsed: null == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as ParsedSystemInstruction,
  ));
}

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParsedSystemInstructionCopyWith<$Res> get parsed {
  
  return $ParsedSystemInstructionCopyWith<$Res>(_self.parsed, (value) {
    return _then(_self.copyWith(parsed: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ParsedInstructionSplToken implements ParsedInstruction {
  const ParsedInstructionSplToken({required this.parsed, final  String? $type}): $type = $type ?? 'spl-token';
  factory ParsedInstructionSplToken.fromJson(Map<String, dynamic> json) => _$ParsedInstructionSplTokenFromJson(json);

 final  ParsedSplTokenInstruction parsed;

@JsonKey(name: 'program')
final String $type;


/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedInstructionSplTokenCopyWith<ParsedInstructionSplToken> get copyWith => _$ParsedInstructionSplTokenCopyWithImpl<ParsedInstructionSplToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedInstructionSplTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedInstructionSplToken&&(identical(other.parsed, parsed) || other.parsed == parsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,parsed);

@override
String toString() {
  return 'ParsedInstruction.splToken(parsed: $parsed)';
}


}

/// @nodoc
abstract mixin class $ParsedInstructionSplTokenCopyWith<$Res> implements $ParsedInstructionCopyWith<$Res> {
  factory $ParsedInstructionSplTokenCopyWith(ParsedInstructionSplToken value, $Res Function(ParsedInstructionSplToken) _then) = _$ParsedInstructionSplTokenCopyWithImpl;
@useResult
$Res call({
 ParsedSplTokenInstruction parsed
});


$ParsedSplTokenInstructionCopyWith<$Res> get parsed;

}
/// @nodoc
class _$ParsedInstructionSplTokenCopyWithImpl<$Res>
    implements $ParsedInstructionSplTokenCopyWith<$Res> {
  _$ParsedInstructionSplTokenCopyWithImpl(this._self, this._then);

  final ParsedInstructionSplToken _self;
  final $Res Function(ParsedInstructionSplToken) _then;

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? parsed = null,}) {
  return _then(ParsedInstructionSplToken(
parsed: null == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as ParsedSplTokenInstruction,
  ));
}

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParsedSplTokenInstructionCopyWith<$Res> get parsed {
  
  return $ParsedSplTokenInstructionCopyWith<$Res>(_self.parsed, (value) {
    return _then(_self.copyWith(parsed: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ParsedInstructionMemo implements ParsedInstruction {
  const ParsedInstructionMemo({@JsonKey(name: 'parsed') required this.memo, final  String? $type}): $type = $type ?? 'spl-memo';
  factory ParsedInstructionMemo.fromJson(Map<String, dynamic> json) => _$ParsedInstructionMemoFromJson(json);

// This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
// ignore: invalid_annotation_target
@JsonKey(name: 'parsed') final  String? memo;

@JsonKey(name: 'program')
final String $type;


/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedInstructionMemoCopyWith<ParsedInstructionMemo> get copyWith => _$ParsedInstructionMemoCopyWithImpl<ParsedInstructionMemo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedInstructionMemoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedInstructionMemo&&(identical(other.memo, memo) || other.memo == memo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memo);

@override
String toString() {
  return 'ParsedInstruction.memo(memo: $memo)';
}


}

/// @nodoc
abstract mixin class $ParsedInstructionMemoCopyWith<$Res> implements $ParsedInstructionCopyWith<$Res> {
  factory $ParsedInstructionMemoCopyWith(ParsedInstructionMemo value, $Res Function(ParsedInstructionMemo) _then) = _$ParsedInstructionMemoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'parsed') String? memo
});




}
/// @nodoc
class _$ParsedInstructionMemoCopyWithImpl<$Res>
    implements $ParsedInstructionMemoCopyWith<$Res> {
  _$ParsedInstructionMemoCopyWithImpl(this._self, this._then);

  final ParsedInstructionMemo _self;
  final $Res Function(ParsedInstructionMemo) _then;

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? memo = freezed,}) {
  return _then(ParsedInstructionMemo(
memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ParsedInstructionUnsupported implements ParsedInstruction {
  const ParsedInstructionUnsupported({this.program});
  factory ParsedInstructionUnsupported.fromJson(Map<String, dynamic> json) => _$ParsedInstructionUnsupportedFromJson(json);

 final  String? program;

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedInstructionUnsupportedCopyWith<ParsedInstructionUnsupported> get copyWith => _$ParsedInstructionUnsupportedCopyWithImpl<ParsedInstructionUnsupported>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedInstructionUnsupportedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedInstructionUnsupported&&(identical(other.program, program) || other.program == program));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,program);

@override
String toString() {
  return 'ParsedInstruction.unsupported(program: $program)';
}


}

/// @nodoc
abstract mixin class $ParsedInstructionUnsupportedCopyWith<$Res> implements $ParsedInstructionCopyWith<$Res> {
  factory $ParsedInstructionUnsupportedCopyWith(ParsedInstructionUnsupported value, $Res Function(ParsedInstructionUnsupported) _then) = _$ParsedInstructionUnsupportedCopyWithImpl;
@useResult
$Res call({
 String? program
});




}
/// @nodoc
class _$ParsedInstructionUnsupportedCopyWithImpl<$Res>
    implements $ParsedInstructionUnsupportedCopyWith<$Res> {
  _$ParsedInstructionUnsupportedCopyWithImpl(this._self, this._then);

  final ParsedInstructionUnsupported _self;
  final $Res Function(ParsedInstructionUnsupported) _then;

/// Create a copy of ParsedInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? program = freezed,}) {
  return _then(ParsedInstructionUnsupported(
program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
