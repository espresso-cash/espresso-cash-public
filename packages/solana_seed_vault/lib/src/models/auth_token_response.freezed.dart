// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthTokenResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int authToken) success,
    required TResult Function(Exception exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int authToken)? success,
    TResult? Function(Exception exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int authToken)? success,
    TResult Function(Exception exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthTokenResponseSuccess value) success,
    required TResult Function(_AuthTokenResponseFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthTokenResponseSuccess value)? success,
    TResult? Function(_AuthTokenResponseFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthTokenResponseSuccess value)? success,
    TResult Function(_AuthTokenResponseFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthTokenResponseCopyWith<$Res> {
  factory $AuthTokenResponseCopyWith(
          AuthTokenResponse value, $Res Function(AuthTokenResponse) then) =
      _$AuthTokenResponseCopyWithImpl<$Res, AuthTokenResponse>;
}

/// @nodoc
class _$AuthTokenResponseCopyWithImpl<$Res, $Val extends AuthTokenResponse>
    implements $AuthTokenResponseCopyWith<$Res> {
  _$AuthTokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AuthTokenResponseSuccessCopyWith<$Res> {
  factory _$$_AuthTokenResponseSuccessCopyWith(
          _$_AuthTokenResponseSuccess value,
          $Res Function(_$_AuthTokenResponseSuccess) then) =
      __$$_AuthTokenResponseSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({int authToken});
}

/// @nodoc
class __$$_AuthTokenResponseSuccessCopyWithImpl<$Res>
    extends _$AuthTokenResponseCopyWithImpl<$Res, _$_AuthTokenResponseSuccess>
    implements _$$_AuthTokenResponseSuccessCopyWith<$Res> {
  __$$_AuthTokenResponseSuccessCopyWithImpl(_$_AuthTokenResponseSuccess _value,
      $Res Function(_$_AuthTokenResponseSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
  }) {
    return _then(_$_AuthTokenResponseSuccess(
      null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_AuthTokenResponseSuccess implements _AuthTokenResponseSuccess {
  const _$_AuthTokenResponseSuccess(this.authToken);

  @override
  final int authToken;

  @override
  String toString() {
    return 'AuthTokenResponse.success(authToken: $authToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthTokenResponseSuccess &&
            (identical(other.authToken, authToken) ||
                other.authToken == authToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthTokenResponseSuccessCopyWith<_$_AuthTokenResponseSuccess>
      get copyWith => __$$_AuthTokenResponseSuccessCopyWithImpl<
          _$_AuthTokenResponseSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int authToken) success,
    required TResult Function(Exception exception) failure,
  }) {
    return success(authToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int authToken)? success,
    TResult? Function(Exception exception)? failure,
  }) {
    return success?.call(authToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int authToken)? success,
    TResult Function(Exception exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(authToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthTokenResponseSuccess value) success,
    required TResult Function(_AuthTokenResponseFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthTokenResponseSuccess value)? success,
    TResult? Function(_AuthTokenResponseFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthTokenResponseSuccess value)? success,
    TResult Function(_AuthTokenResponseFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AuthTokenResponseSuccess implements AuthTokenResponse {
  const factory _AuthTokenResponseSuccess(final int authToken) =
      _$_AuthTokenResponseSuccess;

  int get authToken;
  @JsonKey(ignore: true)
  _$$_AuthTokenResponseSuccessCopyWith<_$_AuthTokenResponseSuccess>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthTokenResponseFailureCopyWith<$Res> {
  factory _$$_AuthTokenResponseFailureCopyWith(
          _$_AuthTokenResponseFailure value,
          $Res Function(_$_AuthTokenResponseFailure) then) =
      __$$_AuthTokenResponseFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({Exception exception});
}

/// @nodoc
class __$$_AuthTokenResponseFailureCopyWithImpl<$Res>
    extends _$AuthTokenResponseCopyWithImpl<$Res, _$_AuthTokenResponseFailure>
    implements _$$_AuthTokenResponseFailureCopyWith<$Res> {
  __$$_AuthTokenResponseFailureCopyWithImpl(_$_AuthTokenResponseFailure _value,
      $Res Function(_$_AuthTokenResponseFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$_AuthTokenResponseFailure(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$_AuthTokenResponseFailure implements _AuthTokenResponseFailure {
  const _$_AuthTokenResponseFailure(this.exception);

  @override
  final Exception exception;

  @override
  String toString() {
    return 'AuthTokenResponse.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthTokenResponseFailure &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthTokenResponseFailureCopyWith<_$_AuthTokenResponseFailure>
      get copyWith => __$$_AuthTokenResponseFailureCopyWithImpl<
          _$_AuthTokenResponseFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int authToken) success,
    required TResult Function(Exception exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int authToken)? success,
    TResult? Function(Exception exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int authToken)? success,
    TResult Function(Exception exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthTokenResponseSuccess value) success,
    required TResult Function(_AuthTokenResponseFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthTokenResponseSuccess value)? success,
    TResult? Function(_AuthTokenResponseFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthTokenResponseSuccess value)? success,
    TResult Function(_AuthTokenResponseFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _AuthTokenResponseFailure implements AuthTokenResponse {
  const factory _AuthTokenResponseFailure(final Exception exception) =
      _$_AuthTokenResponseFailure;

  Exception get exception;
  @JsonKey(ignore: true)
  _$$_AuthTokenResponseFailureCopyWith<_$_AuthTokenResponseFailure>
      get copyWith => throw _privateConstructorUsedError;
}
