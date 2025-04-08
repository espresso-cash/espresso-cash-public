// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SigningResponse {
  List<Uint8List> get signatures => throw _privateConstructorUsedError;
  List<Uri> get resolvedDerivationPaths => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SigningResponseCopyWith<SigningResponse> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningResponseCopyWith<$Res> {
  factory $SigningResponseCopyWith(SigningResponse value, $Res Function(SigningResponse) then) =
      _$SigningResponseCopyWithImpl<$Res, SigningResponse>;
  @useResult
  $Res call({List<Uint8List> signatures, List<Uri> resolvedDerivationPaths});
}

/// @nodoc
class _$SigningResponseCopyWithImpl<$Res, $Val extends SigningResponse>
    implements $SigningResponseCopyWith<$Res> {
  _$SigningResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null, Object? resolvedDerivationPaths = null}) {
    return _then(
      _value.copyWith(
            signatures:
                null == signatures
                    ? _value.signatures
                    : signatures // ignore: cast_nullable_to_non_nullable
                        as List<Uint8List>,
            resolvedDerivationPaths:
                null == resolvedDerivationPaths
                    ? _value.resolvedDerivationPaths
                    : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
                        as List<Uri>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SigningResponseImplCopyWith<$Res> implements $SigningResponseCopyWith<$Res> {
  factory _$$SigningResponseImplCopyWith(
    _$SigningResponseImpl value,
    $Res Function(_$SigningResponseImpl) then,
  ) = __$$SigningResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uint8List> signatures, List<Uri> resolvedDerivationPaths});
}

/// @nodoc
class __$$SigningResponseImplCopyWithImpl<$Res>
    extends _$SigningResponseCopyWithImpl<$Res, _$SigningResponseImpl>
    implements _$$SigningResponseImplCopyWith<$Res> {
  __$$SigningResponseImplCopyWithImpl(
    _$SigningResponseImpl _value,
    $Res Function(_$SigningResponseImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null, Object? resolvedDerivationPaths = null}) {
    return _then(
      _$SigningResponseImpl(
        signatures:
            null == signatures
                ? _value._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        resolvedDerivationPaths:
            null == resolvedDerivationPaths
                ? _value._resolvedDerivationPaths
                : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}

/// @nodoc

class _$SigningResponseImpl with DiagnosticableTreeMixin implements _SigningResponse {
  const _$SigningResponseImpl({
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningResponse(signatures: $signatures, resolvedDerivationPaths: $resolvedDerivationPaths)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SigningResponse'))
      ..add(DiagnosticsProperty('signatures', signatures))
      ..add(DiagnosticsProperty('resolvedDerivationPaths', resolvedDerivationPaths));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigningResponseImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SigningResponseImplCopyWith<_$SigningResponseImpl> get copyWith =>
      __$$SigningResponseImplCopyWithImpl<_$SigningResponseImpl>(this, _$identity);
}

abstract class _SigningResponse implements SigningResponse {
  const factory _SigningResponse({
    required final List<Uint8List> signatures,
    required final List<Uri> resolvedDerivationPaths,
  }) = _$SigningResponseImpl;

  @override
  List<Uint8List> get signatures;
  @override
  List<Uri> get resolvedDerivationPaths;
  @override
  @JsonKey(ignore: true)
  _$$SigningResponseImplCopyWith<_$SigningResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
