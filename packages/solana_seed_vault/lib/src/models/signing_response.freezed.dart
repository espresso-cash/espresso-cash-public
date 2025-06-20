// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SigningResponse implements DiagnosticableTreeMixin {
  List<Uint8List> get signatures;
  List<Uri> get resolvedDerivationPaths;

  /// Create a copy of SigningResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SigningResponseCopyWith<SigningResponse> get copyWith =>
      _$SigningResponseCopyWithImpl<SigningResponse>(this as SigningResponse, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SigningResponse'))
      ..add(DiagnosticsProperty('signatures', signatures))
      ..add(DiagnosticsProperty('resolvedDerivationPaths', resolvedDerivationPaths));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SigningResponse &&
            const DeepCollectionEquality().equals(other.signatures, signatures) &&
            const DeepCollectionEquality().equals(
              other.resolvedDerivationPaths,
              resolvedDerivationPaths,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(signatures),
    const DeepCollectionEquality().hash(resolvedDerivationPaths),
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningResponse(signatures: $signatures, resolvedDerivationPaths: $resolvedDerivationPaths)';
  }
}

/// @nodoc
abstract mixin class $SigningResponseCopyWith<$Res> {
  factory $SigningResponseCopyWith(SigningResponse value, $Res Function(SigningResponse) _then) =
      _$SigningResponseCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signatures, List<Uri> resolvedDerivationPaths});
}

/// @nodoc
class _$SigningResponseCopyWithImpl<$Res> implements $SigningResponseCopyWith<$Res> {
  _$SigningResponseCopyWithImpl(this._self, this._then);

  final SigningResponse _self;
  final $Res Function(SigningResponse) _then;

  /// Create a copy of SigningResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null, Object? resolvedDerivationPaths = null}) {
    return _then(
      _self.copyWith(
        signatures:
            null == signatures
                ? _self.signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        resolvedDerivationPaths:
            null == resolvedDerivationPaths
                ? _self.resolvedDerivationPaths
                : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}

/// @nodoc

class _SigningResponse with DiagnosticableTreeMixin implements SigningResponse {
  const _SigningResponse({
    required final List<Uint8List> signatures,
    required final List<Uri> resolvedDerivationPaths,
  }) : _signatures = signatures,
       _resolvedDerivationPaths = resolvedDerivationPaths;

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  final List<Uri> _resolvedDerivationPaths;
  @override
  List<Uri> get resolvedDerivationPaths {
    if (_resolvedDerivationPaths is EqualUnmodifiableListView) return _resolvedDerivationPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resolvedDerivationPaths);
  }

  /// Create a copy of SigningResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SigningResponseCopyWith<_SigningResponse> get copyWith =>
      __$SigningResponseCopyWithImpl<_SigningResponse>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SigningResponse'))
      ..add(DiagnosticsProperty('signatures', signatures))
      ..add(DiagnosticsProperty('resolvedDerivationPaths', resolvedDerivationPaths));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SigningResponse &&
            const DeepCollectionEquality().equals(other._signatures, _signatures) &&
            const DeepCollectionEquality().equals(
              other._resolvedDerivationPaths,
              _resolvedDerivationPaths,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_signatures),
    const DeepCollectionEquality().hash(_resolvedDerivationPaths),
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningResponse(signatures: $signatures, resolvedDerivationPaths: $resolvedDerivationPaths)';
  }
}

/// @nodoc
abstract mixin class _$SigningResponseCopyWith<$Res> implements $SigningResponseCopyWith<$Res> {
  factory _$SigningResponseCopyWith(_SigningResponse value, $Res Function(_SigningResponse) _then) =
      __$SigningResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<Uint8List> signatures, List<Uri> resolvedDerivationPaths});
}

/// @nodoc
class __$SigningResponseCopyWithImpl<$Res> implements _$SigningResponseCopyWith<$Res> {
  __$SigningResponseCopyWithImpl(this._self, this._then);

  final _SigningResponse _self;
  final $Res Function(_SigningResponse) _then;

  /// Create a copy of SigningResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? signatures = null, Object? resolvedDerivationPaths = null}) {
    return _then(
      _SigningResponse(
        signatures:
            null == signatures
                ? _self._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        resolvedDerivationPaths:
            null == resolvedDerivationPaths
                ? _self._resolvedDerivationPaths
                : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}
