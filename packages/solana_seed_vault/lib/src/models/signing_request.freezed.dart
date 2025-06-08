// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SigningRequest implements DiagnosticableTreeMixin {
  Uint8List get payload;
  List<Uri> get requestedSignatures;

  /// Create a copy of SigningRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SigningRequestCopyWith<SigningRequest> get copyWith =>
      _$SigningRequestCopyWithImpl<SigningRequest>(this as SigningRequest, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SigningRequest'))
      ..add(DiagnosticsProperty('payload', payload))
      ..add(DiagnosticsProperty('requestedSignatures', requestedSignatures));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SigningRequest &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            const DeepCollectionEquality().equals(other.requestedSignatures, requestedSignatures));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(payload),
    const DeepCollectionEquality().hash(requestedSignatures),
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningRequest(payload: $payload, requestedSignatures: $requestedSignatures)';
  }
}

/// @nodoc
abstract mixin class $SigningRequestCopyWith<$Res> {
  factory $SigningRequestCopyWith(SigningRequest value, $Res Function(SigningRequest) _then) =
      _$SigningRequestCopyWithImpl;
  @useResult
  $Res call({Uint8List payload, List<Uri> requestedSignatures});
}

/// @nodoc
class _$SigningRequestCopyWithImpl<$Res> implements $SigningRequestCopyWith<$Res> {
  _$SigningRequestCopyWithImpl(this._self, this._then);

  final SigningRequest _self;
  final $Res Function(SigningRequest) _then;

  /// Create a copy of SigningRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? payload = null, Object? requestedSignatures = null}) {
    return _then(
      _self.copyWith(
        payload:
            null == payload
                ? _self.payload
                : payload // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        requestedSignatures:
            null == requestedSignatures
                ? _self.requestedSignatures
                : requestedSignatures // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}

/// @nodoc

class _SigningRequest with DiagnosticableTreeMixin implements SigningRequest {
  const _SigningRequest({required this.payload, required final List<Uri> requestedSignatures})
    : _requestedSignatures = requestedSignatures;

  @override
  final Uint8List payload;
  final List<Uri> _requestedSignatures;
  @override
  List<Uri> get requestedSignatures {
    if (_requestedSignatures is EqualUnmodifiableListView) return _requestedSignatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestedSignatures);
  }

  /// Create a copy of SigningRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SigningRequestCopyWith<_SigningRequest> get copyWith =>
      __$SigningRequestCopyWithImpl<_SigningRequest>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SigningRequest'))
      ..add(DiagnosticsProperty('payload', payload))
      ..add(DiagnosticsProperty('requestedSignatures', requestedSignatures));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SigningRequest &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            const DeepCollectionEquality().equals(
              other._requestedSignatures,
              _requestedSignatures,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(payload),
    const DeepCollectionEquality().hash(_requestedSignatures),
  );

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SigningRequest(payload: $payload, requestedSignatures: $requestedSignatures)';
  }
}

/// @nodoc
abstract mixin class _$SigningRequestCopyWith<$Res> implements $SigningRequestCopyWith<$Res> {
  factory _$SigningRequestCopyWith(_SigningRequest value, $Res Function(_SigningRequest) _then) =
      __$SigningRequestCopyWithImpl;
  @override
  @useResult
  $Res call({Uint8List payload, List<Uri> requestedSignatures});
}

/// @nodoc
class __$SigningRequestCopyWithImpl<$Res> implements _$SigningRequestCopyWith<$Res> {
  __$SigningRequestCopyWithImpl(this._self, this._then);

  final _SigningRequest _self;
  final $Res Function(_SigningRequest) _then;

  /// Create a copy of SigningRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? payload = null, Object? requestedSignatures = null}) {
    return _then(
      _SigningRequest(
        payload:
            null == payload
                ? _self.payload
                : payload // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        requestedSignatures:
            null == requestedSignatures
                ? _self._requestedSignatures
                : requestedSignatures // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}
