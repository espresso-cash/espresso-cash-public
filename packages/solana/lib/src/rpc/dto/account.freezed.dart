// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Account {

/// Number of lamports assigned to this account, as a u64
 int get lamports;/// base-58 encoded Pubkey of the program this account has been
/// assigned to
 String get owner;/// Data associated with the account, either as encoded binary
/// data or JSON format {program: state}, depending on
/// encoding parameter
 AccountData? get data;/// Boolean indicating if the account contains a program (and
/// is strictly read-only)
 bool get executable;/// The epoch at which this account will next owe rent, as u64
@JsonKey(fromJson: bigIntFromJson) BigInt get rentEpoch;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.lamports, lamports) || other.lamports == lamports)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.data, data) || other.data == data)&&(identical(other.executable, executable) || other.executable == executable)&&(identical(other.rentEpoch, rentEpoch) || other.rentEpoch == rentEpoch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lamports,owner,data,executable,rentEpoch);

@override
String toString() {
  return 'Account(lamports: $lamports, owner: $owner, data: $data, executable: $executable, rentEpoch: $rentEpoch)';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 int lamports, String owner, AccountData? data, bool executable,@JsonKey(fromJson: bigIntFromJson) BigInt rentEpoch
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lamports = null,Object? owner = null,Object? data = freezed,Object? executable = null,Object? rentEpoch = null,}) {
  return _then(_self.copyWith(
lamports: null == lamports ? _self.lamports : lamports // ignore: cast_nullable_to_non_nullable
as int,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AccountData?,executable: null == executable ? _self.executable : executable // ignore: cast_nullable_to_non_nullable
as bool,rentEpoch: null == rentEpoch ? _self.rentEpoch : rentEpoch // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Account value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Account value)  $default,){
final _that = this;
switch (_that) {
case _Account():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Account value)?  $default,){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lamports,  String owner,  AccountData? data,  bool executable, @JsonKey(fromJson: bigIntFromJson)  BigInt rentEpoch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.lamports,_that.owner,_that.data,_that.executable,_that.rentEpoch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lamports,  String owner,  AccountData? data,  bool executable, @JsonKey(fromJson: bigIntFromJson)  BigInt rentEpoch)  $default,) {final _that = this;
switch (_that) {
case _Account():
return $default(_that.lamports,_that.owner,_that.data,_that.executable,_that.rentEpoch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lamports,  String owner,  AccountData? data,  bool executable, @JsonKey(fromJson: bigIntFromJson)  BigInt rentEpoch)?  $default,) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.lamports,_that.owner,_that.data,_that.executable,_that.rentEpoch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Account implements Account {
  const _Account({required this.lamports, required this.owner, required this.data, required this.executable, @JsonKey(fromJson: bigIntFromJson) required this.rentEpoch});
  factory _Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

/// Number of lamports assigned to this account, as a u64
@override final  int lamports;
/// base-58 encoded Pubkey of the program this account has been
/// assigned to
@override final  String owner;
/// Data associated with the account, either as encoded binary
/// data or JSON format {program: state}, depending on
/// encoding parameter
@override final  AccountData? data;
/// Boolean indicating if the account contains a program (and
/// is strictly read-only)
@override final  bool executable;
/// The epoch at which this account will next owe rent, as u64
@override@JsonKey(fromJson: bigIntFromJson) final  BigInt rentEpoch;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCopyWith<_Account> get copyWith => __$AccountCopyWithImpl<_Account>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Account&&(identical(other.lamports, lamports) || other.lamports == lamports)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.data, data) || other.data == data)&&(identical(other.executable, executable) || other.executable == executable)&&(identical(other.rentEpoch, rentEpoch) || other.rentEpoch == rentEpoch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lamports,owner,data,executable,rentEpoch);

@override
String toString() {
  return 'Account(lamports: $lamports, owner: $owner, data: $data, executable: $executable, rentEpoch: $rentEpoch)';
}


}

/// @nodoc
abstract mixin class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) _then) = __$AccountCopyWithImpl;
@override @useResult
$Res call({
 int lamports, String owner, AccountData? data, bool executable,@JsonKey(fromJson: bigIntFromJson) BigInt rentEpoch
});




}
/// @nodoc
class __$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(this._self, this._then);

  final _Account _self;
  final $Res Function(_Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lamports = null,Object? owner = null,Object? data = freezed,Object? executable = null,Object? rentEpoch = null,}) {
  return _then(_Account(
lamports: null == lamports ? _self.lamports : lamports // ignore: cast_nullable_to_non_nullable
as int,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AccountData?,executable: null == executable ? _self.executable : executable // ignore: cast_nullable_to_non_nullable
as bool,rentEpoch: null == rentEpoch ? _self.rentEpoch : rentEpoch // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}

// dart format on
