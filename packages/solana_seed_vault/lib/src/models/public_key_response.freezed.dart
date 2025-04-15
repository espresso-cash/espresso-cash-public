// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_key_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PublicKeyResponse {
  Uint8List? get publicKey => throw _privateConstructorUsedError;
  String? get publicKeyEncoded => throw _privateConstructorUsedError;
  Uri get resolvedDerivationPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PublicKeyResponseCopyWith<PublicKeyResponse> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicKeyResponseCopyWith<$Res> {
  factory $PublicKeyResponseCopyWith(
    PublicKeyResponse value,
    $Res Function(PublicKeyResponse) then,
  ) = _$PublicKeyResponseCopyWithImpl<$Res, PublicKeyResponse>;
  @useResult
  $Res call({Uint8List? publicKey, String? publicKeyEncoded, Uri resolvedDerivationPath});
}

/// @nodoc
class _$PublicKeyResponseCopyWithImpl<$Res, $Val extends PublicKeyResponse>
    implements $PublicKeyResponseCopyWith<$Res> {
  _$PublicKeyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = freezed,
    Object? publicKeyEncoded = freezed,
    Object? resolvedDerivationPath = null,
  }) {
    return _then(
      _value.copyWith(
            publicKey:
                freezed == publicKey
                    ? _value.publicKey
                    : publicKey // ignore: cast_nullable_to_non_nullable
                        as Uint8List?,
            publicKeyEncoded:
                freezed == publicKeyEncoded
                    ? _value.publicKeyEncoded
                    : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                        as String?,
            resolvedDerivationPath:
                null == resolvedDerivationPath
                    ? _value.resolvedDerivationPath
                    : resolvedDerivationPath // ignore: cast_nullable_to_non_nullable
                        as Uri,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PublicKeyResponseImplCopyWith<$Res> implements $PublicKeyResponseCopyWith<$Res> {
  factory _$$PublicKeyResponseImplCopyWith(
    _$PublicKeyResponseImpl value,
    $Res Function(_$PublicKeyResponseImpl) then,
  ) = __$$PublicKeyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List? publicKey, String? publicKeyEncoded, Uri resolvedDerivationPath});
}

/// @nodoc
class __$$PublicKeyResponseImplCopyWithImpl<$Res>
    extends _$PublicKeyResponseCopyWithImpl<$Res, _$PublicKeyResponseImpl>
    implements _$$PublicKeyResponseImplCopyWith<$Res> {
  __$$PublicKeyResponseImplCopyWithImpl(
    _$PublicKeyResponseImpl _value,
    $Res Function(_$PublicKeyResponseImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = freezed,
    Object? publicKeyEncoded = freezed,
    Object? resolvedDerivationPath = null,
  }) {
    return _then(
      _$PublicKeyResponseImpl(
        publicKey:
            freezed == publicKey
                ? _value.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as Uint8List?,
        publicKeyEncoded:
            freezed == publicKeyEncoded
                ? _value.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String?,
        resolvedDerivationPath:
            null == resolvedDerivationPath
                ? _value.resolvedDerivationPath
                : resolvedDerivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
      ),
    );
  }
}

/// @nodoc

class _$PublicKeyResponseImpl with DiagnosticableTreeMixin implements _PublicKeyResponse {
  const _$PublicKeyResponseImpl({
    required this.publicKey,
    required this.publicKeyEncoded,
    required this.resolvedDerivationPath,
  });

  @override
  final Uint8List? publicKey;
  @override
  final String? publicKeyEncoded;
  @override
  final Uri resolvedDerivationPath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PublicKeyResponse(publicKey: $publicKey, publicKeyEncoded: $publicKeyEncoded, resolvedDerivationPath: $resolvedDerivationPath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PublicKeyResponse'))
      ..add(DiagnosticsProperty('publicKey', publicKey))
      ..add(DiagnosticsProperty('publicKeyEncoded', publicKeyEncoded))
      ..add(DiagnosticsProperty('resolvedDerivationPath', resolvedDerivationPath));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicKeyResponseImpl &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.publicKeyEncoded, publicKeyEncoded) ||
                other.publicKeyEncoded == publicKeyEncoded) &&
            (identical(other.resolvedDerivationPath, resolvedDerivationPath) ||
                other.resolvedDerivationPath == resolvedDerivationPath));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(publicKey),
    publicKeyEncoded,
    resolvedDerivationPath,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicKeyResponseImplCopyWith<_$PublicKeyResponseImpl> get copyWith =>
      __$$PublicKeyResponseImplCopyWithImpl<_$PublicKeyResponseImpl>(this, _$identity);
}

abstract class _PublicKeyResponse implements PublicKeyResponse {
  const factory _PublicKeyResponse({
    required final Uint8List? publicKey,
    required final String? publicKeyEncoded,
    required final Uri resolvedDerivationPath,
  }) = _$PublicKeyResponseImpl;

  @override
  Uint8List? get publicKey;
  @override
  String? get publicKeyEncoded;
  @override
  Uri get resolvedDerivationPath;
  @override
  @JsonKey(ignore: true)
  _$$PublicKeyResponseImplCopyWith<_$PublicKeyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
