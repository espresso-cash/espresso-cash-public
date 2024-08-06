// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClientState {
  GetCapabilitiesResult? get capabilities => throw _privateConstructorUsedError;
  AuthorizationResult? get authorizationResult =>
      throw _privateConstructorUsedError;
  bool get isRequestingAirdrop => throw _privateConstructorUsedError;
  bool get isMainnet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClientStateCopyWith<ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
          ClientState value, $Res Function(ClientState) then) =
      _$ClientStateCopyWithImpl<$Res, ClientState>;
  @useResult
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult,
      bool isRequestingAirdrop,
      bool isMainnet});

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res, $Val extends ClientState>
    implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
    Object? isMainnet = null,
  }) {
    return _then(_value.copyWith(
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: freezed == authorizationResult
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
      isRequestingAirdrop: null == isRequestingAirdrop
          ? _value.isRequestingAirdrop
          : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
      isMainnet: null == isMainnet
          ? _value.isMainnet
          : isMainnet // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_value.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_value.capabilities!, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_value.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_value.authorizationResult!,
        (value) {
      return _then(_value.copyWith(authorizationResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientStateImplCopyWith<$Res>
    implements $ClientStateCopyWith<$Res> {
  factory _$$ClientStateImplCopyWith(
          _$ClientStateImpl value, $Res Function(_$ClientStateImpl) then) =
      __$$ClientStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult,
      bool isRequestingAirdrop,
      bool isMainnet});

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class __$$ClientStateImplCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res, _$ClientStateImpl>
    implements _$$ClientStateImplCopyWith<$Res> {
  __$$ClientStateImplCopyWithImpl(
      _$ClientStateImpl _value, $Res Function(_$ClientStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
    Object? isMainnet = null,
  }) {
    return _then(_$ClientStateImpl(
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: freezed == authorizationResult
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
      isRequestingAirdrop: null == isRequestingAirdrop
          ? _value.isRequestingAirdrop
          : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
      isMainnet: null == isMainnet
          ? _value.isMainnet
          : isMainnet // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ClientStateImpl extends _ClientState with DiagnosticableTreeMixin {
  const _$ClientStateImpl(
      {this.capabilities,
      this.authorizationResult,
      this.isRequestingAirdrop = false,
      this.isMainnet = false})
      : super._();

  @override
  final GetCapabilitiesResult? capabilities;
  @override
  final AuthorizationResult? authorizationResult;
  @override
  @JsonKey()
  final bool isRequestingAirdrop;
  @override
  @JsonKey()
  final bool isMainnet;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientState(capabilities: $capabilities, authorizationResult: $authorizationResult, isRequestingAirdrop: $isRequestingAirdrop, isMainnet: $isMainnet)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientState'))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('authorizationResult', authorizationResult))
      ..add(DiagnosticsProperty('isRequestingAirdrop', isRequestingAirdrop))
      ..add(DiagnosticsProperty('isMainnet', isMainnet));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientStateImpl &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.authorizationResult, authorizationResult) ||
                other.authorizationResult == authorizationResult) &&
            (identical(other.isRequestingAirdrop, isRequestingAirdrop) ||
                other.isRequestingAirdrop == isRequestingAirdrop) &&
            (identical(other.isMainnet, isMainnet) ||
                other.isMainnet == isMainnet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, capabilities,
      authorizationResult, isRequestingAirdrop, isMainnet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientStateImplCopyWith<_$ClientStateImpl> get copyWith =>
      __$$ClientStateImplCopyWithImpl<_$ClientStateImpl>(this, _$identity);
}

abstract class _ClientState extends ClientState {
  const factory _ClientState(
      {final GetCapabilitiesResult? capabilities,
      final AuthorizationResult? authorizationResult,
      final bool isRequestingAirdrop,
      final bool isMainnet}) = _$ClientStateImpl;
  const _ClientState._() : super._();

  @override
  GetCapabilitiesResult? get capabilities;
  @override
  AuthorizationResult? get authorizationResult;
  @override
  bool get isRequestingAirdrop;
  @override
  bool get isMainnet;
  @override
  @JsonKey(ignore: true)
  _$$ClientStateImplCopyWith<_$ClientStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
