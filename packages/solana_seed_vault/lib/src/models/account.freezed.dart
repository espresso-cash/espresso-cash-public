// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Account {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Uri get derivationPath => throw _privateConstructorUsedError;
  String get publicKeyEncoded => throw _privateConstructorUsedError;
  Uint8List get publicKeyRaw => throw _privateConstructorUsedError;
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
class _$AccountCopyWithImpl<$Res, $Val extends Account> implements $AccountCopyWith<$Res> {
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
    Object? publicKeyRaw = null,
    Object? isUserWallet = null,
    Object? isValid = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            derivationPath:
                null == derivationPath
                    ? _value.derivationPath
                    : derivationPath // ignore: cast_nullable_to_non_nullable
                        as Uri,
            publicKeyEncoded:
                null == publicKeyEncoded
                    ? _value.publicKeyEncoded
                    : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                        as String,
            publicKeyRaw:
                null == publicKeyRaw
                    ? _value.publicKeyRaw
                    : publicKeyRaw // ignore: cast_nullable_to_non_nullable
                        as Uint8List,
            isUserWallet:
                null == isUserWallet
                    ? _value.isUserWallet
                    : isUserWallet // ignore: cast_nullable_to_non_nullable
                        as bool,
            isValid:
                null == isValid
                    ? _value.isValid
                    : isValid // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(_$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
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
class __$$AccountImplCopyWithImpl<$Res> extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(_$AccountImpl _value, $Res Function(_$AccountImpl) _then)
    : super(_value, _then);

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
      _$AccountImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        derivationPath:
            null == derivationPath
                ? _value.derivationPath
                : derivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
        publicKeyEncoded:
            null == publicKeyEncoded
                ? _value.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String,
        publicKeyRaw:
            null == publicKeyRaw
                ? _value.publicKeyRaw
                : publicKeyRaw // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        isUserWallet:
            null == isUserWallet
                ? _value.isUserWallet
                : isUserWallet // ignore: cast_nullable_to_non_nullable
                    as bool,
        isValid:
            null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$AccountImpl with DiagnosticableTreeMixin implements _Account {
  const _$AccountImpl({
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Account(id: $id, name: $name, derivationPath: $derivationPath, publicKeyEncoded: $publicKeyEncoded, publicKeyRaw: $publicKeyRaw, isUserWallet: $isUserWallet, isValid: $isValid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
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
            other is _$AccountImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);
}

abstract class _Account implements Account {
  const factory _Account({
    required final int id,
    required final String name,
    required final Uri derivationPath,
    required final String publicKeyEncoded,
    required final Uint8List publicKeyRaw,
    required final bool isUserWallet,
    required final bool isValid,
  }) = _$AccountImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  Uri get derivationPath;
  @override
  String get publicKeyEncoded;
  @override
  Uint8List get publicKeyRaw;
  @override
  bool get isUserWallet;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith => throw _privateConstructorUsedError;
}
