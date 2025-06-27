// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountFilter {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is AccountFilter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountFilter()';
  }
}

/// @nodoc
class $AccountFilterCopyWith<$Res> {
  $AccountFilterCopyWith(AccountFilter _, $Res Function(AccountFilter) __);
}

/// @nodoc

class AccountFilterNone implements AccountFilter {
  const AccountFilterNone();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AccountFilterNone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountFilter()';
  }
}

/// @nodoc

class AccountFilterId implements AccountFilter {
  const AccountFilterId(this.id);

  final int id;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterIdCopyWith<AccountFilterId> get copyWith =>
      _$AccountFilterIdCopyWithImpl<AccountFilterId>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterId &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'AccountFilter.byId(id: $id)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterIdCopyWith<$Res> implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterIdCopyWith(AccountFilterId value, $Res Function(AccountFilterId) _then) =
      _$AccountFilterIdCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$AccountFilterIdCopyWithImpl<$Res> implements $AccountFilterIdCopyWith<$Res> {
  _$AccountFilterIdCopyWithImpl(this._self, this._then);

  final AccountFilterId _self;
  final $Res Function(AccountFilterId) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? id = null}) {
    return _then(
      AccountFilterId(
        null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class AccountFilterName implements AccountFilter {
  const AccountFilterName(this.name);

  final String name;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterNameCopyWith<AccountFilterName> get copyWith =>
      _$AccountFilterNameCopyWithImpl<AccountFilterName>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterName &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'AccountFilter.byName(name: $name)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterNameCopyWith<$Res> implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterNameCopyWith(
    AccountFilterName value,
    $Res Function(AccountFilterName) _then,
  ) = _$AccountFilterNameCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$AccountFilterNameCopyWithImpl<$Res> implements $AccountFilterNameCopyWith<$Res> {
  _$AccountFilterNameCopyWithImpl(this._self, this._then);

  final AccountFilterName _self;
  final $Res Function(AccountFilterName) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? name = null}) {
    return _then(
      AccountFilterName(
        null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class AccountFilterDerivationPath implements AccountFilter {
  const AccountFilterDerivationPath(this.derivationPath);

  final Uri derivationPath;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterDerivationPathCopyWith<AccountFilterDerivationPath> get copyWith =>
      _$AccountFilterDerivationPathCopyWithImpl<AccountFilterDerivationPath>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterDerivationPath &&
            (identical(other.derivationPath, derivationPath) ||
                other.derivationPath == derivationPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, derivationPath);

  @override
  String toString() {
    return 'AccountFilter.byDerivationPath(derivationPath: $derivationPath)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterDerivationPathCopyWith<$Res>
    implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterDerivationPathCopyWith(
    AccountFilterDerivationPath value,
    $Res Function(AccountFilterDerivationPath) _then,
  ) = _$AccountFilterDerivationPathCopyWithImpl;
  @useResult
  $Res call({Uri derivationPath});
}

/// @nodoc
class _$AccountFilterDerivationPathCopyWithImpl<$Res>
    implements $AccountFilterDerivationPathCopyWith<$Res> {
  _$AccountFilterDerivationPathCopyWithImpl(this._self, this._then);

  final AccountFilterDerivationPath _self;
  final $Res Function(AccountFilterDerivationPath) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? derivationPath = null}) {
    return _then(
      AccountFilterDerivationPath(
        null == derivationPath
            ? _self.derivationPath
            : derivationPath // ignore: cast_nullable_to_non_nullable
                as Uri,
      ),
    );
  }
}

/// @nodoc

class AccountFilterPublicKeyEncoded implements AccountFilter {
  const AccountFilterPublicKeyEncoded(this.publicKeyEncoded);

  final String publicKeyEncoded;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterPublicKeyEncodedCopyWith<AccountFilterPublicKeyEncoded> get copyWith =>
      _$AccountFilterPublicKeyEncodedCopyWithImpl<AccountFilterPublicKeyEncoded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterPublicKeyEncoded &&
            (identical(other.publicKeyEncoded, publicKeyEncoded) ||
                other.publicKeyEncoded == publicKeyEncoded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKeyEncoded);

  @override
  String toString() {
    return 'AccountFilter.byPublicKeyEncoded(publicKeyEncoded: $publicKeyEncoded)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterPublicKeyEncodedCopyWith<$Res>
    implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterPublicKeyEncodedCopyWith(
    AccountFilterPublicKeyEncoded value,
    $Res Function(AccountFilterPublicKeyEncoded) _then,
  ) = _$AccountFilterPublicKeyEncodedCopyWithImpl;
  @useResult
  $Res call({String publicKeyEncoded});
}

/// @nodoc
class _$AccountFilterPublicKeyEncodedCopyWithImpl<$Res>
    implements $AccountFilterPublicKeyEncodedCopyWith<$Res> {
  _$AccountFilterPublicKeyEncodedCopyWithImpl(this._self, this._then);

  final AccountFilterPublicKeyEncoded _self;
  final $Res Function(AccountFilterPublicKeyEncoded) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? publicKeyEncoded = null}) {
    return _then(
      AccountFilterPublicKeyEncoded(
        null == publicKeyEncoded
            ? _self.publicKeyEncoded
            : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class AccountFilterIsUserWallet implements AccountFilter {
  const AccountFilterIsUserWallet(this.isUserWallet);

  final bool isUserWallet;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterIsUserWalletCopyWith<AccountFilterIsUserWallet> get copyWith =>
      _$AccountFilterIsUserWalletCopyWithImpl<AccountFilterIsUserWallet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterIsUserWallet &&
            (identical(other.isUserWallet, isUserWallet) || other.isUserWallet == isUserWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isUserWallet);

  @override
  String toString() {
    return 'AccountFilter.byIsUserWallet(isUserWallet: $isUserWallet)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterIsUserWalletCopyWith<$Res>
    implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterIsUserWalletCopyWith(
    AccountFilterIsUserWallet value,
    $Res Function(AccountFilterIsUserWallet) _then,
  ) = _$AccountFilterIsUserWalletCopyWithImpl;
  @useResult
  $Res call({bool isUserWallet});
}

/// @nodoc
class _$AccountFilterIsUserWalletCopyWithImpl<$Res>
    implements $AccountFilterIsUserWalletCopyWith<$Res> {
  _$AccountFilterIsUserWalletCopyWithImpl(this._self, this._then);

  final AccountFilterIsUserWallet _self;
  final $Res Function(AccountFilterIsUserWallet) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? isUserWallet = null}) {
    return _then(
      AccountFilterIsUserWallet(
        null == isUserWallet
            ? _self.isUserWallet
            : isUserWallet // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc

class AccountFilterIsValid implements AccountFilter {
  const AccountFilterIsValid(this.isValid);

  final bool isValid;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountFilterIsValidCopyWith<AccountFilterIsValid> get copyWith =>
      _$AccountFilterIsValidCopyWithImpl<AccountFilterIsValid>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountFilterIsValid &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isValid);

  @override
  String toString() {
    return 'AccountFilter.byIsValid(isValid: $isValid)';
  }
}

/// @nodoc
abstract mixin class $AccountFilterIsValidCopyWith<$Res> implements $AccountFilterCopyWith<$Res> {
  factory $AccountFilterIsValidCopyWith(
    AccountFilterIsValid value,
    $Res Function(AccountFilterIsValid) _then,
  ) = _$AccountFilterIsValidCopyWithImpl;
  @useResult
  $Res call({bool isValid});
}

/// @nodoc
class _$AccountFilterIsValidCopyWithImpl<$Res> implements $AccountFilterIsValidCopyWith<$Res> {
  _$AccountFilterIsValidCopyWithImpl(this._self, this._then);

  final AccountFilterIsValid _self;
  final $Res Function(AccountFilterIsValid) _then;

  /// Create a copy of AccountFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? isValid = null}) {
    return _then(
      AccountFilterIsValid(
        null == isValid
            ? _self.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}
