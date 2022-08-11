// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MobileWalletState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() sessionTerminated,
    required TResult Function(RemoteRequest request) remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(None value) none,
    required TResult Function(SessionTerminated value) sessionTerminated,
    required TResult Function(Remote value) remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileWalletStateCopyWith<$Res> {
  factory $MobileWalletStateCopyWith(
          MobileWalletState value, $Res Function(MobileWalletState) then) =
      _$MobileWalletStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MobileWalletStateCopyWithImpl<$Res>
    implements $MobileWalletStateCopyWith<$Res> {
  _$MobileWalletStateCopyWithImpl(this._value, this._then);

  final MobileWalletState _value;
  // ignore: unused_field
  final $Res Function(MobileWalletState) _then;
}

/// @nodoc
abstract class _$$NoneCopyWith<$Res> {
  factory _$$NoneCopyWith(_$None value, $Res Function(_$None) then) =
      __$$NoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneCopyWithImpl<$Res> extends _$MobileWalletStateCopyWithImpl<$Res>
    implements _$$NoneCopyWith<$Res> {
  __$$NoneCopyWithImpl(_$None _value, $Res Function(_$None) _then)
      : super(_value, (v) => _then(v as _$None));

  @override
  _$None get _value => super._value as _$None;
}

/// @nodoc

class _$None implements None {
  const _$None();

  @override
  String toString() {
    return 'MobileWalletState.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() sessionTerminated,
    required TResult Function(RemoteRequest request) remote,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(None value) none,
    required TResult Function(SessionTerminated value) sessionTerminated,
    required TResult Function(Remote value) remote,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class None implements MobileWalletState {
  const factory None() = _$None;
}

/// @nodoc
abstract class _$$SessionTerminatedCopyWith<$Res> {
  factory _$$SessionTerminatedCopyWith(
          _$SessionTerminated value, $Res Function(_$SessionTerminated) then) =
      __$$SessionTerminatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionTerminatedCopyWithImpl<$Res>
    extends _$MobileWalletStateCopyWithImpl<$Res>
    implements _$$SessionTerminatedCopyWith<$Res> {
  __$$SessionTerminatedCopyWithImpl(
      _$SessionTerminated _value, $Res Function(_$SessionTerminated) _then)
      : super(_value, (v) => _then(v as _$SessionTerminated));

  @override
  _$SessionTerminated get _value => super._value as _$SessionTerminated;
}

/// @nodoc

class _$SessionTerminated implements SessionTerminated {
  const _$SessionTerminated();

  @override
  String toString() {
    return 'MobileWalletState.sessionTerminated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionTerminated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() sessionTerminated,
    required TResult Function(RemoteRequest request) remote,
  }) {
    return sessionTerminated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
  }) {
    return sessionTerminated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
    required TResult orElse(),
  }) {
    if (sessionTerminated != null) {
      return sessionTerminated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(None value) none,
    required TResult Function(SessionTerminated value) sessionTerminated,
    required TResult Function(Remote value) remote,
  }) {
    return sessionTerminated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
  }) {
    return sessionTerminated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
    required TResult orElse(),
  }) {
    if (sessionTerminated != null) {
      return sessionTerminated(this);
    }
    return orElse();
  }
}

abstract class SessionTerminated implements MobileWalletState {
  const factory SessionTerminated() = _$SessionTerminated;
}

/// @nodoc
abstract class _$$RemoteCopyWith<$Res> {
  factory _$$RemoteCopyWith(_$Remote value, $Res Function(_$Remote) then) =
      __$$RemoteCopyWithImpl<$Res>;
  $Res call({RemoteRequest request});

  $RemoteRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$RemoteCopyWithImpl<$Res> extends _$MobileWalletStateCopyWithImpl<$Res>
    implements _$$RemoteCopyWith<$Res> {
  __$$RemoteCopyWithImpl(_$Remote _value, $Res Function(_$Remote) _then)
      : super(_value, (v) => _then(v as _$Remote));

  @override
  _$Remote get _value => super._value as _$Remote;

  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$Remote(
      request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as RemoteRequest,
    ));
  }

  @override
  $RemoteRequestCopyWith<$Res> get request {
    return $RemoteRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc

class _$Remote implements Remote {
  const _$Remote(this.request);

  @override
  final RemoteRequest request;

  @override
  String toString() {
    return 'MobileWalletState.remote(request: $request)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Remote &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  _$$RemoteCopyWith<_$Remote> get copyWith =>
      __$$RemoteCopyWithImpl<_$Remote>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() sessionTerminated,
    required TResult Function(RemoteRequest request) remote,
  }) {
    return remote(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
  }) {
    return remote?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? sessionTerminated,
    TResult Function(RemoteRequest request)? remote,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(None value) none,
    required TResult Function(SessionTerminated value) sessionTerminated,
    required TResult Function(Remote value) remote,
  }) {
    return remote(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
  }) {
    return remote?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(None value)? none,
    TResult Function(SessionTerminated value)? sessionTerminated,
    TResult Function(Remote value)? remote,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(this);
    }
    return orElse();
  }
}

abstract class Remote implements MobileWalletState {
  const factory Remote(final RemoteRequest request) = _$Remote;

  RemoteRequest get request;
  @JsonKey(ignore: true)
  _$$RemoteCopyWith<_$Remote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RemoteRequest {
  AuthorizeRequest get request => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthorizeRequest request) authorizeDapp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthorizeRequest request)? authorizeDapp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthorizeRequest request)? authorizeDapp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthorizeDapp value) authorizeDapp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthorizeDapp value)? authorizeDapp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthorizeDapp value)? authorizeDapp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RemoteRequestCopyWith<RemoteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteRequestCopyWith<$Res> {
  factory $RemoteRequestCopyWith(
          RemoteRequest value, $Res Function(RemoteRequest) then) =
      _$RemoteRequestCopyWithImpl<$Res>;
  $Res call({AuthorizeRequest request});

  $AuthorizeRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RemoteRequestCopyWithImpl<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  _$RemoteRequestCopyWithImpl(this._value, this._then);

  final RemoteRequest _value;
  // ignore: unused_field
  final $Res Function(RemoteRequest) _then;

  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_value.copyWith(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as AuthorizeRequest,
    ));
  }

  @override
  $AuthorizeRequestCopyWith<$Res> get request {
    return $AuthorizeRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc
abstract class _$$AuthorizeDappCopyWith<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  factory _$$AuthorizeDappCopyWith(
          _$AuthorizeDapp value, $Res Function(_$AuthorizeDapp) then) =
      __$$AuthorizeDappCopyWithImpl<$Res>;
  @override
  $Res call({AuthorizeRequest request});

  @override
  $AuthorizeRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$AuthorizeDappCopyWithImpl<$Res>
    extends _$RemoteRequestCopyWithImpl<$Res>
    implements _$$AuthorizeDappCopyWith<$Res> {
  __$$AuthorizeDappCopyWithImpl(
      _$AuthorizeDapp _value, $Res Function(_$AuthorizeDapp) _then)
      : super(_value, (v) => _then(v as _$AuthorizeDapp));

  @override
  _$AuthorizeDapp get _value => super._value as _$AuthorizeDapp;

  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$AuthorizeDapp(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as AuthorizeRequest,
    ));
  }
}

/// @nodoc

class _$AuthorizeDapp implements AuthorizeDapp {
  const _$AuthorizeDapp({required this.request});

  @override
  final AuthorizeRequest request;

  @override
  String toString() {
    return 'RemoteRequest.authorizeDapp(request: $request)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorizeDapp &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  _$$AuthorizeDappCopyWith<_$AuthorizeDapp> get copyWith =>
      __$$AuthorizeDappCopyWithImpl<_$AuthorizeDapp>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthorizeRequest request) authorizeDapp,
  }) {
    return authorizeDapp(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthorizeRequest request)? authorizeDapp,
  }) {
    return authorizeDapp?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthorizeRequest request)? authorizeDapp,
    required TResult orElse(),
  }) {
    if (authorizeDapp != null) {
      return authorizeDapp(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthorizeDapp value) authorizeDapp,
  }) {
    return authorizeDapp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthorizeDapp value)? authorizeDapp,
  }) {
    return authorizeDapp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthorizeDapp value)? authorizeDapp,
    required TResult orElse(),
  }) {
    if (authorizeDapp != null) {
      return authorizeDapp(this);
    }
    return orElse();
  }
}

abstract class AuthorizeDapp implements RemoteRequest {
  const factory AuthorizeDapp({required final AuthorizeRequest request}) =
      _$AuthorizeDapp;

  @override
  AuthorizeRequest get request;
  @override
  @JsonKey(ignore: true)
  _$$AuthorizeDappCopyWith<_$AuthorizeDapp> get copyWith =>
      throw _privateConstructorUsedError;
}
