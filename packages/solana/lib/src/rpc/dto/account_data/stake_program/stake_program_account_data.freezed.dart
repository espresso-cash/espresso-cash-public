// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stake_program_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
StakeProgramAccountData _$StakeProgramAccountDataFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'delegated':
          return StakeProgramDelegatedAccountData.fromJson(
            json
          );
                case 'initialize':
          return StakeProgramInitializedAccountData.fromJson(
            json
          );
        
          default:
            return StakeProgramUnknownAccountData.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$StakeProgramAccountData {

 Object get info;

  /// Serializes this StakeProgramAccountData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakeProgramAccountData&&const DeepCollectionEquality().equals(other.info, info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(info));

@override
String toString() {
  return 'StakeProgramAccountData(info: $info)';
}


}

/// @nodoc
class $StakeProgramAccountDataCopyWith<$Res>  {
$StakeProgramAccountDataCopyWith(StakeProgramAccountData _, $Res Function(StakeProgramAccountData) __);
}


/// Adds pattern-matching-related methods to [StakeProgramAccountData].
extension StakeProgramAccountDataPatterns on StakeProgramAccountData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StakeProgramDelegatedAccountData value)?  delegated,TResult Function( StakeProgramInitializedAccountData value)?  initialize,TResult Function( StakeProgramUnknownAccountData value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData() when delegated != null:
return delegated(_that);case StakeProgramInitializedAccountData() when initialize != null:
return initialize(_that);case StakeProgramUnknownAccountData() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StakeProgramDelegatedAccountData value)  delegated,required TResult Function( StakeProgramInitializedAccountData value)  initialize,required TResult Function( StakeProgramUnknownAccountData value)  unknown,}){
final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData():
return delegated(_that);case StakeProgramInitializedAccountData():
return initialize(_that);case StakeProgramUnknownAccountData():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StakeProgramDelegatedAccountData value)?  delegated,TResult? Function( StakeProgramInitializedAccountData value)?  initialize,TResult? Function( StakeProgramUnknownAccountData value)?  unknown,}){
final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData() when delegated != null:
return delegated(_that);case StakeProgramInitializedAccountData() when initialize != null:
return initialize(_that);case StakeProgramUnknownAccountData() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StakeDelegatedAccountInfo info)?  delegated,TResult Function( StakeInitializedAccountInfo info)?  initialize,TResult Function( Map<String, dynamic> info)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData() when delegated != null:
return delegated(_that.info);case StakeProgramInitializedAccountData() when initialize != null:
return initialize(_that.info);case StakeProgramUnknownAccountData() when unknown != null:
return unknown(_that.info);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StakeDelegatedAccountInfo info)  delegated,required TResult Function( StakeInitializedAccountInfo info)  initialize,required TResult Function( Map<String, dynamic> info)  unknown,}) {final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData():
return delegated(_that.info);case StakeProgramInitializedAccountData():
return initialize(_that.info);case StakeProgramUnknownAccountData():
return unknown(_that.info);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StakeDelegatedAccountInfo info)?  delegated,TResult? Function( StakeInitializedAccountInfo info)?  initialize,TResult? Function( Map<String, dynamic> info)?  unknown,}) {final _that = this;
switch (_that) {
case StakeProgramDelegatedAccountData() when delegated != null:
return delegated(_that.info);case StakeProgramInitializedAccountData() when initialize != null:
return initialize(_that.info);case StakeProgramUnknownAccountData() when unknown != null:
return unknown(_that.info);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class StakeProgramDelegatedAccountData implements StakeProgramAccountData {
  const StakeProgramDelegatedAccountData({required this.info, final  String? $type}): $type = $type ?? 'delegated';
  factory StakeProgramDelegatedAccountData.fromJson(Map<String, dynamic> json) => _$StakeProgramDelegatedAccountDataFromJson(json);

@override final  StakeDelegatedAccountInfo info;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StakeProgramDelegatedAccountDataCopyWith<StakeProgramDelegatedAccountData> get copyWith => _$StakeProgramDelegatedAccountDataCopyWithImpl<StakeProgramDelegatedAccountData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StakeProgramDelegatedAccountDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakeProgramDelegatedAccountData&&(identical(other.info, info) || other.info == info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'StakeProgramAccountData.delegated(info: $info)';
}


}

/// @nodoc
abstract mixin class $StakeProgramDelegatedAccountDataCopyWith<$Res> implements $StakeProgramAccountDataCopyWith<$Res> {
  factory $StakeProgramDelegatedAccountDataCopyWith(StakeProgramDelegatedAccountData value, $Res Function(StakeProgramDelegatedAccountData) _then) = _$StakeProgramDelegatedAccountDataCopyWithImpl;
@useResult
$Res call({
 StakeDelegatedAccountInfo info
});




}
/// @nodoc
class _$StakeProgramDelegatedAccountDataCopyWithImpl<$Res>
    implements $StakeProgramDelegatedAccountDataCopyWith<$Res> {
  _$StakeProgramDelegatedAccountDataCopyWithImpl(this._self, this._then);

  final StakeProgramDelegatedAccountData _self;
  final $Res Function(StakeProgramDelegatedAccountData) _then;

/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(StakeProgramDelegatedAccountData(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as StakeDelegatedAccountInfo,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StakeProgramInitializedAccountData implements StakeProgramAccountData {
  const StakeProgramInitializedAccountData({required this.info, final  String? $type}): $type = $type ?? 'initialize';
  factory StakeProgramInitializedAccountData.fromJson(Map<String, dynamic> json) => _$StakeProgramInitializedAccountDataFromJson(json);

@override final  StakeInitializedAccountInfo info;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StakeProgramInitializedAccountDataCopyWith<StakeProgramInitializedAccountData> get copyWith => _$StakeProgramInitializedAccountDataCopyWithImpl<StakeProgramInitializedAccountData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StakeProgramInitializedAccountDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakeProgramInitializedAccountData&&(identical(other.info, info) || other.info == info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'StakeProgramAccountData.initialize(info: $info)';
}


}

/// @nodoc
abstract mixin class $StakeProgramInitializedAccountDataCopyWith<$Res> implements $StakeProgramAccountDataCopyWith<$Res> {
  factory $StakeProgramInitializedAccountDataCopyWith(StakeProgramInitializedAccountData value, $Res Function(StakeProgramInitializedAccountData) _then) = _$StakeProgramInitializedAccountDataCopyWithImpl;
@useResult
$Res call({
 StakeInitializedAccountInfo info
});




}
/// @nodoc
class _$StakeProgramInitializedAccountDataCopyWithImpl<$Res>
    implements $StakeProgramInitializedAccountDataCopyWith<$Res> {
  _$StakeProgramInitializedAccountDataCopyWithImpl(this._self, this._then);

  final StakeProgramInitializedAccountData _self;
  final $Res Function(StakeProgramInitializedAccountData) _then;

/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(StakeProgramInitializedAccountData(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as StakeInitializedAccountInfo,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StakeProgramUnknownAccountData implements StakeProgramAccountData {
  const StakeProgramUnknownAccountData(final  Map<String, dynamic> info, {final  String? $type}): _info = info,$type = $type ?? 'unknown';
  factory StakeProgramUnknownAccountData.fromJson(Map<String, dynamic> json) => _$StakeProgramUnknownAccountDataFromJson(json);

 final  Map<String, dynamic> _info;
@override Map<String, dynamic> get info {
  if (_info is EqualUnmodifiableMapView) return _info;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_info);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StakeProgramUnknownAccountDataCopyWith<StakeProgramUnknownAccountData> get copyWith => _$StakeProgramUnknownAccountDataCopyWithImpl<StakeProgramUnknownAccountData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StakeProgramUnknownAccountDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakeProgramUnknownAccountData&&const DeepCollectionEquality().equals(other._info, _info));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_info));

@override
String toString() {
  return 'StakeProgramAccountData.unknown(info: $info)';
}


}

/// @nodoc
abstract mixin class $StakeProgramUnknownAccountDataCopyWith<$Res> implements $StakeProgramAccountDataCopyWith<$Res> {
  factory $StakeProgramUnknownAccountDataCopyWith(StakeProgramUnknownAccountData value, $Res Function(StakeProgramUnknownAccountData) _then) = _$StakeProgramUnknownAccountDataCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> info
});




}
/// @nodoc
class _$StakeProgramUnknownAccountDataCopyWithImpl<$Res>
    implements $StakeProgramUnknownAccountDataCopyWith<$Res> {
  _$StakeProgramUnknownAccountDataCopyWithImpl(this._self, this._then);

  final StakeProgramUnknownAccountData _self;
  final $Res Function(StakeProgramUnknownAccountData) _then;

/// Create a copy of StakeProgramAccountData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(StakeProgramUnknownAccountData(
null == info ? _self._info : info // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
