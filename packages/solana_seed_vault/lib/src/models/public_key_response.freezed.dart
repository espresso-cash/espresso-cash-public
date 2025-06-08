// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_key_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicKeyResponse implements DiagnosticableTreeMixin {
  Uint8List? get publicKey;
  String? get publicKeyEncoded;
  Uri get resolvedDerivationPath;

  /// Create a copy of PublicKeyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PublicKeyResponseCopyWith<PublicKeyResponse> get copyWith =>
      _$PublicKeyResponseCopyWithImpl<PublicKeyResponse>(this as PublicKeyResponse, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is PublicKeyResponse &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PublicKeyResponse(publicKey: $publicKey, publicKeyEncoded: $publicKeyEncoded, resolvedDerivationPath: $resolvedDerivationPath)';
  }
}

/// @nodoc
abstract mixin class $PublicKeyResponseCopyWith<$Res> {
  factory $PublicKeyResponseCopyWith(
    PublicKeyResponse value,
    $Res Function(PublicKeyResponse) _then,
  ) = _$PublicKeyResponseCopyWithImpl;
  @useResult
  $Res call({Uint8List? publicKey, String? publicKeyEncoded, Uri resolvedDerivationPath});
}

/// @nodoc
class _$PublicKeyResponseCopyWithImpl<$Res> implements $PublicKeyResponseCopyWith<$Res> {
  _$PublicKeyResponseCopyWithImpl(this._self, this._then);

  final PublicKeyResponse _self;
  final $Res Function(PublicKeyResponse) _then;

  /// Create a copy of PublicKeyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = freezed,
    Object? publicKeyEncoded = freezed,
    Object? resolvedDerivationPath = null,
  }) {
    return _then(
      _self.copyWith(
        publicKey:
            freezed == publicKey
                ? _self.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as Uint8List?,
        publicKeyEncoded:
            freezed == publicKeyEncoded
                ? _self.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String?,
        resolvedDerivationPath:
            null == resolvedDerivationPath
                ? _self.resolvedDerivationPath
                : resolvedDerivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
      ),
    );
  }
}

/// @nodoc

class _PublicKeyResponse with DiagnosticableTreeMixin implements PublicKeyResponse {
  const _PublicKeyResponse({
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

  /// Create a copy of PublicKeyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PublicKeyResponseCopyWith<_PublicKeyResponse> get copyWith =>
      __$PublicKeyResponseCopyWithImpl<_PublicKeyResponse>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is _PublicKeyResponse &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PublicKeyResponse(publicKey: $publicKey, publicKeyEncoded: $publicKeyEncoded, resolvedDerivationPath: $resolvedDerivationPath)';
  }
}

/// @nodoc
abstract mixin class _$PublicKeyResponseCopyWith<$Res> implements $PublicKeyResponseCopyWith<$Res> {
  factory _$PublicKeyResponseCopyWith(
    _PublicKeyResponse value,
    $Res Function(_PublicKeyResponse) _then,
  ) = __$PublicKeyResponseCopyWithImpl;
  @override
  @useResult
  $Res call({Uint8List? publicKey, String? publicKeyEncoded, Uri resolvedDerivationPath});
}

/// @nodoc
class __$PublicKeyResponseCopyWithImpl<$Res> implements _$PublicKeyResponseCopyWith<$Res> {
  __$PublicKeyResponseCopyWithImpl(this._self, this._then);

  final _PublicKeyResponse _self;
  final $Res Function(_PublicKeyResponse) _then;

  /// Create a copy of PublicKeyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? publicKey = freezed,
    Object? publicKeyEncoded = freezed,
    Object? resolvedDerivationPath = null,
  }) {
    return _then(
      _PublicKeyResponse(
        publicKey:
            freezed == publicKey
                ? _self.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as Uint8List?,
        publicKeyEncoded:
            freezed == publicKeyEncoded
                ? _self.publicKeyEncoded
                : publicKeyEncoded // ignore: cast_nullable_to_non_nullable
                    as String?,
        resolvedDerivationPath:
            null == resolvedDerivationPath
                ? _self.resolvedDerivationPath
                : resolvedDerivationPath // ignore: cast_nullable_to_non_nullable
                    as Uri,
      ),
    );
  }
}
