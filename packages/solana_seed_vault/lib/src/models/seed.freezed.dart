// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Seed {
  AuthToken get authToken;
  String get name;
  Purpose get purpose;
  List<Account> get accounts;

  /// Create a copy of Seed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeedCopyWith<Seed> get copyWith => _$SeedCopyWithImpl<Seed>(this as Seed, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Seed &&
            (identical(other.authToken, authToken) || other.authToken == authToken) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            const DeepCollectionEquality().equals(other.accounts, accounts));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    authToken,
    name,
    purpose,
    const DeepCollectionEquality().hash(accounts),
  );

  @override
  String toString() {
    return 'Seed(authToken: $authToken, name: $name, purpose: $purpose, accounts: $accounts)';
  }
}

/// @nodoc
abstract mixin class $SeedCopyWith<$Res> {
  factory $SeedCopyWith(Seed value, $Res Function(Seed) _then) = _$SeedCopyWithImpl;
  @useResult
  $Res call({AuthToken authToken, String name, Purpose purpose, List<Account> accounts});
}

/// @nodoc
class _$SeedCopyWithImpl<$Res> implements $SeedCopyWith<$Res> {
  _$SeedCopyWithImpl(this._self, this._then);

  final Seed _self;
  final $Res Function(Seed) _then;

  /// Create a copy of Seed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
    Object? name = null,
    Object? purpose = null,
    Object? accounts = null,
  }) {
    return _then(
      _self.copyWith(
        authToken:
            null == authToken
                ? _self.authToken
                : authToken // ignore: cast_nullable_to_non_nullable
                    as AuthToken,
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        purpose:
            null == purpose
                ? _self.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                    as Purpose,
        accounts:
            null == accounts
                ? _self.accounts
                : accounts // ignore: cast_nullable_to_non_nullable
                    as List<Account>,
      ),
    );
  }
}

/// @nodoc

class _Seed implements Seed {
  const _Seed({
    required this.authToken,
    required this.name,
    required this.purpose,
    required final List<Account> accounts,
  }) : _accounts = accounts;

  @override
  final AuthToken authToken;
  @override
  final String name;
  @override
  final Purpose purpose;
  final List<Account> _accounts;
  @override
  List<Account> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  /// Create a copy of Seed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeedCopyWith<_Seed> get copyWith => __$SeedCopyWithImpl<_Seed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Seed &&
            (identical(other.authToken, authToken) || other.authToken == authToken) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            const DeepCollectionEquality().equals(other._accounts, _accounts));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    authToken,
    name,
    purpose,
    const DeepCollectionEquality().hash(_accounts),
  );

  @override
  String toString() {
    return 'Seed(authToken: $authToken, name: $name, purpose: $purpose, accounts: $accounts)';
  }
}

/// @nodoc
abstract mixin class _$SeedCopyWith<$Res> implements $SeedCopyWith<$Res> {
  factory _$SeedCopyWith(_Seed value, $Res Function(_Seed) _then) = __$SeedCopyWithImpl;
  @override
  @useResult
  $Res call({AuthToken authToken, String name, Purpose purpose, List<Account> accounts});
}

/// @nodoc
class __$SeedCopyWithImpl<$Res> implements _$SeedCopyWith<$Res> {
  __$SeedCopyWithImpl(this._self, this._then);

  final _Seed _self;
  final $Res Function(_Seed) _then;

  /// Create a copy of Seed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? authToken = null,
    Object? name = null,
    Object? purpose = null,
    Object? accounts = null,
  }) {
    return _then(
      _Seed(
        authToken:
            null == authToken
                ? _self.authToken
                : authToken // ignore: cast_nullable_to_non_nullable
                    as AuthToken,
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        purpose:
            null == purpose
                ? _self.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                    as Purpose,
        accounts:
            null == accounts
                ? _self._accounts
                : accounts // ignore: cast_nullable_to_non_nullable
                    as List<Account>,
      ),
    );
  }
}
