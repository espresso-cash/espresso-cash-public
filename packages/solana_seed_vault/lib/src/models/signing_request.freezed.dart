// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SigningRequest {
  Uint8List get payload => throw _privateConstructorUsedError;
  List<Uri> get requestedSignatures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SigningRequestCopyWith<SigningRequest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningRequestCopyWith<$Res> {
  factory $SigningRequestCopyWith(SigningRequest value, $Res Function(SigningRequest) then) =
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
  $Res call({Object? payload = null, Object? requestedSignatures = null}) {
    return _then(
      _value.copyWith(
            payload:
                null == payload
                    ? _value.payload
                    : payload // ignore: cast_nullable_to_non_nullable
                        as Uint8List,
            requestedSignatures:
                null == requestedSignatures
                    ? _value.requestedSignatures
                    : requestedSignatures // ignore: cast_nullable_to_non_nullable
                        as List<Uri>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SigningRequestImplCopyWith<$Res> implements $SigningRequestCopyWith<$Res> {
  factory _$$SigningRequestImplCopyWith(
    _$SigningRequestImpl value,
    $Res Function(_$SigningRequestImpl) then,
  ) = __$$SigningRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List payload, List<Uri> requestedSignatures});
}

/// @nodoc
class __$$SigningRequestImplCopyWithImpl<$Res>
    extends _$SigningRequestCopyWithImpl<$Res, _$SigningRequestImpl>
    implements _$$SigningRequestImplCopyWith<$Res> {
  __$$SigningRequestImplCopyWithImpl(
    _$SigningRequestImpl _value,
    $Res Function(_$SigningRequestImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? payload = null, Object? requestedSignatures = null}) {
    return _then(
      _$SigningRequestImpl(
        payload:
            null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        requestedSignatures:
            null == requestedSignatures
                ? _value._requestedSignatures
                : requestedSignatures // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
      ),
    );
  }
}

/// @nodoc

class _$SigningRequestImpl with DiagnosticableTreeMixin implements _SigningRequest {
  const _$SigningRequestImpl({required this.payload, required final List<Uri> requestedSignatures})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigningRequestImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SigningRequestImplCopyWith<_$SigningRequestImpl> get copyWith =>
      __$$SigningRequestImplCopyWithImpl<_$SigningRequestImpl>(this, _$identity);
}

abstract class _SigningRequest implements SigningRequest {
  const factory _SigningRequest({
    required final Uint8List payload,
    required final List<Uri> requestedSignatures,
  }) = _$SigningRequestImpl;

  @override
  Uint8List get payload;
  @override
  List<Uri> get requestedSignatures;
  @override
  @JsonKey(ignore: true)
  _$$SigningRequestImplCopyWith<_$SigningRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
