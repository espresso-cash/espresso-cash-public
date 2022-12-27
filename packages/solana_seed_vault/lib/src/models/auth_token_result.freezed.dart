// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_token_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthTokenResult {
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
    required TResult Function(_ATRSuccess value) success,
    required TResult Function(_ATRFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ATRSuccess value)? success,
    TResult? Function(_ATRFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ATRSuccess value)? success,
    TResult Function(_ATRFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthTokenResultCopyWith<$Res> {
  factory $AuthTokenResultCopyWith(
          AuthTokenResult value, $Res Function(AuthTokenResult) then) =
      _$AuthTokenResultCopyWithImpl<$Res, AuthTokenResult>;
}

/// @nodoc
class _$AuthTokenResultCopyWithImpl<$Res, $Val extends AuthTokenResult>
    implements $AuthTokenResultCopyWith<$Res> {
  _$AuthTokenResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ATRSuccessCopyWith<$Res> {
  factory _$$_ATRSuccessCopyWith(
          _$_ATRSuccess value, $Res Function(_$_ATRSuccess) then) =
      __$$_ATRSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({int authToken});
}

/// @nodoc
class __$$_ATRSuccessCopyWithImpl<$Res>
    extends _$AuthTokenResultCopyWithImpl<$Res, _$_ATRSuccess>
    implements _$$_ATRSuccessCopyWith<$Res> {
  __$$_ATRSuccessCopyWithImpl(
      _$_ATRSuccess _value, $Res Function(_$_ATRSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
  }) {
    return _then(_$_ATRSuccess(
      null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ATRSuccess implements _ATRSuccess {
  const _$_ATRSuccess(this.authToken);

  @override
  final int authToken;

  @override
  String toString() {
    return 'AuthTokenResult.success(authToken: $authToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ATRSuccess &&
            (identical(other.authToken, authToken) ||
                other.authToken == authToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ATRSuccessCopyWith<_$_ATRSuccess> get copyWith =>
      __$$_ATRSuccessCopyWithImpl<_$_ATRSuccess>(this, _$identity);

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
    required TResult Function(_ATRSuccess value) success,
    required TResult Function(_ATRFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ATRSuccess value)? success,
    TResult? Function(_ATRFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ATRSuccess value)? success,
    TResult Function(_ATRFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ATRSuccess implements AuthTokenResult {
  const factory _ATRSuccess(final int authToken) = _$_ATRSuccess;

  int get authToken;
  @JsonKey(ignore: true)
  _$$_ATRSuccessCopyWith<_$_ATRSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ATRFailureCopyWith<$Res> {
  factory _$$_ATRFailureCopyWith(
          _$_ATRFailure value, $Res Function(_$_ATRFailure) then) =
      __$$_ATRFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({Exception exception});
}

/// @nodoc
class __$$_ATRFailureCopyWithImpl<$Res>
    extends _$AuthTokenResultCopyWithImpl<$Res, _$_ATRFailure>
    implements _$$_ATRFailureCopyWith<$Res> {
  __$$_ATRFailureCopyWithImpl(
      _$_ATRFailure _value, $Res Function(_$_ATRFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$_ATRFailure(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$_ATRFailure implements _ATRFailure {
  const _$_ATRFailure(this.exception);

  @override
  final Exception exception;

  @override
  String toString() {
    return 'AuthTokenResult.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ATRFailure &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ATRFailureCopyWith<_$_ATRFailure> get copyWith =>
      __$$_ATRFailureCopyWithImpl<_$_ATRFailure>(this, _$identity);

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
    required TResult Function(_ATRSuccess value) success,
    required TResult Function(_ATRFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ATRSuccess value)? success,
    TResult? Function(_ATRFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ATRSuccess value)? success,
    TResult Function(_ATRFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _ATRFailure implements AuthTokenResult {
  const factory _ATRFailure(final Exception exception) = _$_ATRFailure;

  Exception get exception;
  @JsonKey(ignore: true)
  _$$_ATRFailureCopyWith<_$_ATRFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
