// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SigningRequest {
  Uint8List get payload => throw _privateConstructorUsedError;
  List<Uri> get requestedSignatures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SigningRequestCopyWith<SigningRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningRequestCopyWith<$Res> {
  factory $SigningRequestCopyWith(
          SigningRequest value, $Res Function(SigningRequest) then) =
      _$SigningRequestCopyWithImpl<$Res, SigningRequest>;
  @useResult
  $Res call({Uint8List payload, List<Uri> requestedSignatures});
}

/// @nodoc
class _$SigningRequestCopyWithImpl<$Res, $Val extends SigningRequest>
    implements $SigningRequestCopyWith<$Res> {
  _$SigningRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? requestedSignatures = null,
  }) {
    return _then(_value.copyWith(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      requestedSignatures: null == requestedSignatures
          ? _value.requestedSignatures
          : requestedSignatures // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SigningRequestCopyWith<$Res>
    implements $SigningRequestCopyWith<$Res> {
  factory _$$_SigningRequestCopyWith(
          _$_SigningRequest value, $Res Function(_$_SigningRequest) then) =
      __$$_SigningRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List payload, List<Uri> requestedSignatures});
}

/// @nodoc
class __$$_SigningRequestCopyWithImpl<$Res>
    extends _$SigningRequestCopyWithImpl<$Res, _$_SigningRequest>
    implements _$$_SigningRequestCopyWith<$Res> {
  __$$_SigningRequestCopyWithImpl(
      _$_SigningRequest _value, $Res Function(_$_SigningRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? requestedSignatures = null,
  }) {
    return _then(_$_SigningRequest(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      requestedSignatures: null == requestedSignatures
          ? _value._requestedSignatures
          : requestedSignatures // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ));
  }
}

/// @nodoc

class _$_SigningRequest
    with DiagnosticableTreeMixin
    implements _SigningRequest {
  const _$_SigningRequest(
      {required this.payload, required final List<Uri> requestedSignatures})
      : _requestedSignatures = requestedSignatures;

  @override
  final Uint8List payload;
  final List<Uri> _requestedSignatures;
  @override
  List<Uri> get requestedSignatures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestedSignatures);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningRequest(payload: $payload, requestedSignatures: $requestedSignatures)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SigningRequest'))
      ..add(DiagnosticsProperty('payload', payload))
      ..add(DiagnosticsProperty('requestedSignatures', requestedSignatures));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SigningRequest &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            const DeepCollectionEquality()
                .equals(other._requestedSignatures, _requestedSignatures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(payload),
      const DeepCollectionEquality().hash(_requestedSignatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SigningRequestCopyWith<_$_SigningRequest> get copyWith =>
      __$$_SigningRequestCopyWithImpl<_$_SigningRequest>(this, _$identity);
}

abstract class _SigningRequest implements SigningRequest {
  const factory _SigningRequest(
      {required final Uint8List payload,
      required final List<Uri> requestedSignatures}) = _$_SigningRequest;

  @override
  Uint8List get payload;
  @override
  List<Uri> get requestedSignatures;
  @override
  @JsonKey(ignore: true)
  _$$_SigningRequestCopyWith<_$_SigningRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SigningResponse {
  List<Uint8List> get signatures => throw _privateConstructorUsedError;
  List<Uri> get resolvedDerivationPaths => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SigningResponseCopyWith<SigningResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningResponseCopyWith<$Res> {
  factory $SigningResponseCopyWith(
          SigningResponse value, $Res Function(SigningResponse) then) =
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
  $Res call({
    Object? signatures = null,
    Object? resolvedDerivationPaths = null,
  }) {
    return _then(_value.copyWith(
      signatures: null == signatures
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      resolvedDerivationPaths: null == resolvedDerivationPaths
          ? _value.resolvedDerivationPaths
          : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SigningResponseCopyWith<$Res>
    implements $SigningResponseCopyWith<$Res> {
  factory _$$_SigningResponseCopyWith(
          _$_SigningResponse value, $Res Function(_$_SigningResponse) then) =
      __$$_SigningResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uint8List> signatures, List<Uri> resolvedDerivationPaths});
}

/// @nodoc
class __$$_SigningResponseCopyWithImpl<$Res>
    extends _$SigningResponseCopyWithImpl<$Res, _$_SigningResponse>
    implements _$$_SigningResponseCopyWith<$Res> {
  __$$_SigningResponseCopyWithImpl(
      _$_SigningResponse _value, $Res Function(_$_SigningResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
    Object? resolvedDerivationPaths = null,
  }) {
    return _then(_$_SigningResponse(
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      resolvedDerivationPaths: null == resolvedDerivationPaths
          ? _value._resolvedDerivationPaths
          : resolvedDerivationPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ));
  }
}

/// @nodoc

class _$_SigningResponse
    with DiagnosticableTreeMixin
    implements _SigningResponse {
  const _$_SigningResponse(
      {required final List<Uint8List> signatures,
      required final List<Uri> resolvedDerivationPaths})
      : _signatures = signatures,
        _resolvedDerivationPaths = resolvedDerivationPaths;

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  final List<Uri> _resolvedDerivationPaths;
  @override
  List<Uri> get resolvedDerivationPaths {
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
      ..add(DiagnosticsProperty(
          'resolvedDerivationPaths', resolvedDerivationPaths));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SigningResponse &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures) &&
            const DeepCollectionEquality().equals(
                other._resolvedDerivationPaths, _resolvedDerivationPaths));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_signatures),
      const DeepCollectionEquality().hash(_resolvedDerivationPaths));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SigningResponseCopyWith<_$_SigningResponse> get copyWith =>
      __$$_SigningResponseCopyWithImpl<_$_SigningResponse>(this, _$identity);
}

abstract class _SigningResponse implements SigningResponse {
  const factory _SigningResponse(
      {required final List<Uint8List> signatures,
      required final List<Uri> resolvedDerivationPaths}) = _$_SigningResponse;

  @override
  List<Uint8List> get signatures;
  @override
  List<Uri> get resolvedDerivationPaths;
  @override
  @JsonKey(ignore: true)
  _$$_SigningResponseCopyWith<_$_SigningResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
