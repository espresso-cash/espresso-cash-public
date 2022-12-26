// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Account {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Uri get derivationPath => throw _privateConstructorUsedError;
  String get publicKeyEncoded => throw _privateConstructorUsedError;
  bool get isUserWallet => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {int id,
      String name,
      Uri derivationPath,
      String publicKeyEncoded,
      bool isUserWallet,
      bool isValid});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? derivationPath = null,
    Object? publicKeyEncoded = null,
    Object? isUserWallet = null,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      derivationPath: null == derivationPath
          ? _value.derivationPath
          : derivationPath // ignore: cast_nullable_to_non_nullable
              as Uri,
      publicKeyEncoded: null == publicKeyEncoded
          ? _value.publicKeyEncoded
          : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
              as String,
      isUserWallet: null == isUserWallet
          ? _value.isUserWallet
          : isUserWallet // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$_AccountCopyWith(
          _$_Account value, $Res Function(_$_Account) then) =
      __$$_AccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      Uri derivationPath,
      String publicKeyEncoded,
      bool isUserWallet,
      bool isValid});
}

/// @nodoc
class __$$_AccountCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$_Account>
    implements _$$_AccountCopyWith<$Res> {
  __$$_AccountCopyWithImpl(_$_Account _value, $Res Function(_$_Account) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? derivationPath = null,
    Object? publicKeyEncoded = null,
    Object? isUserWallet = null,
    Object? isValid = null,
  }) {
    return _then(_$_Account(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      derivationPath: null == derivationPath
          ? _value.derivationPath
          : derivationPath // ignore: cast_nullable_to_non_nullable
              as Uri,
      publicKeyEncoded: null == publicKeyEncoded
          ? _value.publicKeyEncoded
          : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
              as String,
      isUserWallet: null == isUserWallet
          ? _value.isUserWallet
          : isUserWallet // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Account implements _Account {
  const _$_Account(
      {required this.id,
      required this.name,
      required this.derivationPath,
      required this.publicKeyEncoded,
      required this.isUserWallet,
      required this.isValid});

  @override
  final int id;
  @override
  final String name;
  @override
  final Uri derivationPath;
  @override
  final String publicKeyEncoded;
  @override
  final bool isUserWallet;
  @override
  final bool isValid;

  @override
  String toString() {
    return 'Account(id: $id, name: $name, derivationPath: $derivationPath, publicKeyEncoded: $publicKeyEncoded, isUserWallet: $isUserWallet, isValid: $isValid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Account &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.derivationPath, derivationPath) ||
                other.derivationPath == derivationPath) &&
            (identical(other.publicKeyEncoded, publicKeyEncoded) ||
                other.publicKeyEncoded == publicKeyEncoded) &&
            (identical(other.isUserWallet, isUserWallet) ||
                other.isUserWallet == isUserWallet) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, derivationPath,
      publicKeyEncoded, isUserWallet, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      __$$_AccountCopyWithImpl<_$_Account>(this, _$identity);
}

abstract class _Account implements Account {
  const factory _Account(
      {required final int id,
      required final String name,
      required final Uri derivationPath,
      required final String publicKeyEncoded,
      required final bool isUserWallet,
      required final bool isValid}) = _$_Account;

  @override
  int get id;
  @override
  String get name;
  @override
  Uri get derivationPath;
  @override
  String get publicKeyEncoded;
  @override
  bool get isUserWallet;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AccountFilter {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() any,
    required TResult Function() isUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? any,
    TResult? Function()? isUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? any,
    TResult Function()? isUserWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Any value) any,
    required TResult Function(_isUserWallet value) isUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Any value)? any,
    TResult? Function(_isUserWallet value)? isUserWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Any value)? any,
    TResult Function(_isUserWallet value)? isUserWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountFilterCopyWith<$Res> {
  factory $AccountFilterCopyWith(
          AccountFilter value, $Res Function(AccountFilter) then) =
      _$AccountFilterCopyWithImpl<$Res, AccountFilter>;
}

/// @nodoc
class _$AccountFilterCopyWithImpl<$Res, $Val extends AccountFilter>
    implements $AccountFilterCopyWith<$Res> {
  _$AccountFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AnyCopyWith<$Res> {
  factory _$$_AnyCopyWith(_$_Any value, $Res Function(_$_Any) then) =
      __$$_AnyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AnyCopyWithImpl<$Res>
    extends _$AccountFilterCopyWithImpl<$Res, _$_Any>
    implements _$$_AnyCopyWith<$Res> {
  __$$_AnyCopyWithImpl(_$_Any _value, $Res Function(_$_Any) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Any implements _Any {
  const _$_Any();

  @override
  String toString() {
    return 'AccountFilter.any()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Any);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() any,
    required TResult Function() isUserWallet,
  }) {
    return any();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? any,
    TResult? Function()? isUserWallet,
  }) {
    return any?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? any,
    TResult Function()? isUserWallet,
    required TResult orElse(),
  }) {
    if (any != null) {
      return any();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Any value) any,
    required TResult Function(_isUserWallet value) isUserWallet,
  }) {
    return any(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Any value)? any,
    TResult? Function(_isUserWallet value)? isUserWallet,
  }) {
    return any?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Any value)? any,
    TResult Function(_isUserWallet value)? isUserWallet,
    required TResult orElse(),
  }) {
    if (any != null) {
      return any(this);
    }
    return orElse();
  }
}

abstract class _Any implements AccountFilter {
  const factory _Any() = _$_Any;
}

/// @nodoc
abstract class _$$_isUserWalletCopyWith<$Res> {
  factory _$$_isUserWalletCopyWith(
          _$_isUserWallet value, $Res Function(_$_isUserWallet) then) =
      __$$_isUserWalletCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_isUserWalletCopyWithImpl<$Res>
    extends _$AccountFilterCopyWithImpl<$Res, _$_isUserWallet>
    implements _$$_isUserWalletCopyWith<$Res> {
  __$$_isUserWalletCopyWithImpl(
      _$_isUserWallet _value, $Res Function(_$_isUserWallet) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_isUserWallet implements _isUserWallet {
  const _$_isUserWallet();

  @override
  String toString() {
    return 'AccountFilter.isUserWallet()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_isUserWallet);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() any,
    required TResult Function() isUserWallet,
  }) {
    return isUserWallet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? any,
    TResult? Function()? isUserWallet,
  }) {
    return isUserWallet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? any,
    TResult Function()? isUserWallet,
    required TResult orElse(),
  }) {
    if (isUserWallet != null) {
      return isUserWallet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Any value) any,
    required TResult Function(_isUserWallet value) isUserWallet,
  }) {
    return isUserWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Any value)? any,
    TResult? Function(_isUserWallet value)? isUserWallet,
  }) {
    return isUserWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Any value)? any,
    TResult Function(_isUserWallet value)? isUserWallet,
    required TResult orElse(),
  }) {
    if (isUserWallet != null) {
      return isUserWallet(this);
    }
    return orElse();
  }
}

abstract class _isUserWallet implements AccountFilter {
  const factory _isUserWallet() = _$_isUserWallet;
}
