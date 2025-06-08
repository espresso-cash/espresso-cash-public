// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Account implements DiagnosticableTreeMixin {
  int get id;
  String get name;
  Uri get derivationPath;
  String get publicKeyEncoded;
  Uint8List get publicKeyRaw;
  bool get isUserWallet;
  bool get isValid;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountCopyWith<Account> get copyWith =>
      _$AccountCopyWithImpl<Account>(this as Account, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Account'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('derivationPath', derivationPath))
      ..add(DiagnosticsProperty('publicKeyEncoded', publicKeyEncoded))
      ..add(DiagnosticsProperty('publicKeyRaw', publicKeyRaw))
      ..add(DiagnosticsProperty('isUserWallet', isUserWallet))
      ..add(DiagnosticsProperty('isValid', isValid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Account &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.derivationPath, derivationPath) ||
                other.derivationPath == derivationPath) &&
            (identical(other.publicKeyEncoded, publicKeyEncoded) ||
                other.publicKeyEncoded == publicKeyEncoded) &&
            const DeepCollectionEquality().equals(other.publicKeyRaw, publicKeyRaw) &&
            (identical(other.isUserWallet, isUserWallet) || other.isUserWallet == isUserWallet) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    derivationPath,
    publicKeyEncoded,
    const DeepCollectionEquality().hash(publicKeyRaw),
    isUserWallet,
    isValid,
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Account(id: $id, name: $name, derivationPath: $derivationPath, publicKeyEncoded: $publicKeyEncoded, publicKeyRaw: $publicKeyRaw, isUserWallet: $isUserWallet, isValid: $isValid)';
  }
}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
  @useResult
  $Res call({
    int id,
    String name,
    Uri derivationPath,
    String publicKeyEncoded,
    Uint8List publicKeyRaw,
    bool isUserWallet,
    bool isValid,
  });
}

/// @nodoc
class _$AccountCopyWithImpl<$Res> implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? derivationPath = null,
    Object? publicKeyEncoded = null,
    Object? publicKeyRaw = null,
    Object? isUserWallet = null,
    Object? isValid = null,
  }) {
    return _then(
      _self.copyWith(
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        derivationPath:
            null == derivationPath
                ? _self.derivationPath
                : derivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
        publicKeyEncoded:
            null == publicKeyEncoded
                ? _self.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String,
        publicKeyRaw:
            null == publicKeyRaw
                ? _self.publicKeyRaw
                : publicKeyRaw // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        isUserWallet:
            null == isUserWallet
                ? _self.isUserWallet
                : isUserWallet // ignore: cast_nullable_to_non_nullable
                    as bool,
        isValid:
            null == isValid
                ? _self.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _Account with DiagnosticableTreeMixin implements Account {
  const _Account({
    required this.id,
    required this.name,
    required this.derivationPath,
    required this.publicKeyEncoded,
    required this.publicKeyRaw,
    required this.isUserWallet,
    required this.isValid,
  });

  @override
  final int id;
  @override
  final String name;
  @override
  final Uri derivationPath;
  @override
  final String publicKeyEncoded;
  @override
  final Uint8List publicKeyRaw;
  @override
  final bool isUserWallet;
  @override
  final bool isValid;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccountCopyWith<_Account> get copyWith => __$AccountCopyWithImpl<_Account>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Account'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('derivationPath', derivationPath))
      ..add(DiagnosticsProperty('publicKeyEncoded', publicKeyEncoded))
      ..add(DiagnosticsProperty('publicKeyRaw', publicKeyRaw))
      ..add(DiagnosticsProperty('isUserWallet', isUserWallet))
      ..add(DiagnosticsProperty('isValid', isValid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Account &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.derivationPath, derivationPath) ||
                other.derivationPath == derivationPath) &&
            (identical(other.publicKeyEncoded, publicKeyEncoded) ||
                other.publicKeyEncoded == publicKeyEncoded) &&
            const DeepCollectionEquality().equals(other.publicKeyRaw, publicKeyRaw) &&
            (identical(other.isUserWallet, isUserWallet) || other.isUserWallet == isUserWallet) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    derivationPath,
    publicKeyEncoded,
    const DeepCollectionEquality().hash(publicKeyRaw),
    isUserWallet,
    isValid,
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Account(id: $id, name: $name, derivationPath: $derivationPath, publicKeyEncoded: $publicKeyEncoded, publicKeyRaw: $publicKeyRaw, isUserWallet: $isUserWallet, isValid: $isValid)';
  }
}

/// @nodoc
abstract mixin class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) _then) = __$AccountCopyWithImpl;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    Uri derivationPath,
    String publicKeyEncoded,
    Uint8List publicKeyRaw,
    bool isUserWallet,
    bool isValid,
  });
}

/// @nodoc
class __$AccountCopyWithImpl<$Res> implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(this._self, this._then);

  final _Account _self;
  final $Res Function(_Account) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? derivationPath = null,
    Object? publicKeyEncoded = null,
    Object? publicKeyRaw = null,
    Object? isUserWallet = null,
    Object? isValid = null,
  }) {
    return _then(
      _Account(
        id:
            null == id
                ? _self.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        derivationPath:
            null == derivationPath
                ? _self.derivationPath
                : derivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
        publicKeyEncoded:
            null == publicKeyEncoded
                ? _self.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String,
        publicKeyRaw:
            null == publicKeyRaw
                ? _self.publicKeyRaw
                : publicKeyRaw // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        isUserWallet:
            null == isUserWallet
                ? _self.isUserWallet
                : isUserWallet // ignore: cast_nullable_to_non_nullable
                    as bool,
        isValid:
            null == isValid
                ? _self.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}
