// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'authorization_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthorizationResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(Exception e) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(Exception e)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(Exception e)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthorizationResultSuccess<T> value) success,
    required TResult Function(_AuthorizationResultFailed<T> value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthorizationResultSuccess<T> value)? success,
    TResult? Function(_AuthorizationResultFailed<T> value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthorizationResultSuccess<T> value)? success,
    TResult Function(_AuthorizationResultFailed<T> value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorizationResultCopyWith<T, $Res> {
  factory $AuthorizationResultCopyWith(AuthorizationResult<T> value,
          $Res Function(AuthorizationResult<T>) then) =
      _$AuthorizationResultCopyWithImpl<T, $Res, AuthorizationResult<T>>;
}

/// @nodoc
class _$AuthorizationResultCopyWithImpl<T, $Res,
        $Val extends AuthorizationResult<T>>
    implements $AuthorizationResultCopyWith<T, $Res> {
  _$AuthorizationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AuthorizationResultSuccessCopyWith<T, $Res> {
  factory _$$_AuthorizationResultSuccessCopyWith(
          _$_AuthorizationResultSuccess<T> value,
          $Res Function(_$_AuthorizationResultSuccess<T>) then) =
      __$$_AuthorizationResultSuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_AuthorizationResultSuccessCopyWithImpl<T, $Res>
    extends _$AuthorizationResultCopyWithImpl<T, $Res,
        _$_AuthorizationResultSuccess<T>>
    implements _$$_AuthorizationResultSuccessCopyWith<T, $Res> {
  __$$_AuthorizationResultSuccessCopyWithImpl(
      _$_AuthorizationResultSuccess<T> _value,
      $Res Function(_$_AuthorizationResultSuccess<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_AuthorizationResultSuccess<T>(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_AuthorizationResultSuccess<T>
    implements _AuthorizationResultSuccess<T> {
  const _$_AuthorizationResultSuccess(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'AuthorizationResult<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthorizationResultSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthorizationResultSuccessCopyWith<T, _$_AuthorizationResultSuccess<T>>
      get copyWith => __$$_AuthorizationResultSuccessCopyWithImpl<T,
          _$_AuthorizationResultSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(Exception e) failed,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(Exception e)? failed,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(Exception e)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthorizationResultSuccess<T> value) success,
    required TResult Function(_AuthorizationResultFailed<T> value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthorizationResultSuccess<T> value)? success,
    TResult? Function(_AuthorizationResultFailed<T> value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthorizationResultSuccess<T> value)? success,
    TResult Function(_AuthorizationResultFailed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AuthorizationResultSuccess<T>
    implements AuthorizationResult<T> {
  const factory _AuthorizationResultSuccess(final T data) =
      _$_AuthorizationResultSuccess<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$_AuthorizationResultSuccessCopyWith<T, _$_AuthorizationResultSuccess<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthorizationResultFailedCopyWith<T, $Res> {
  factory _$$_AuthorizationResultFailedCopyWith(
          _$_AuthorizationResultFailed<T> value,
          $Res Function(_$_AuthorizationResultFailed<T>) then) =
      __$$_AuthorizationResultFailedCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Exception e});
}

/// @nodoc
class __$$_AuthorizationResultFailedCopyWithImpl<T, $Res>
    extends _$AuthorizationResultCopyWithImpl<T, $Res,
        _$_AuthorizationResultFailed<T>>
    implements _$$_AuthorizationResultFailedCopyWith<T, $Res> {
  __$$_AuthorizationResultFailedCopyWithImpl(
      _$_AuthorizationResultFailed<T> _value,
      $Res Function(_$_AuthorizationResultFailed<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$_AuthorizationResultFailed<T>(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$_AuthorizationResultFailed<T> implements _AuthorizationResultFailed<T> {
  const _$_AuthorizationResultFailed(this.e);

  @override
  final Exception e;

  @override
  String toString() {
    return 'AuthorizationResult<$T>.failed(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthorizationResultFailed<T> &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthorizationResultFailedCopyWith<T, _$_AuthorizationResultFailed<T>>
      get copyWith => __$$_AuthorizationResultFailedCopyWithImpl<T,
          _$_AuthorizationResultFailed<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(Exception e) failed,
  }) {
    return failed(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(Exception e)? failed,
  }) {
    return failed?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(Exception e)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthorizationResultSuccess<T> value) success,
    required TResult Function(_AuthorizationResultFailed<T> value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthorizationResultSuccess<T> value)? success,
    TResult? Function(_AuthorizationResultFailed<T> value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthorizationResultSuccess<T> value)? success,
    TResult Function(_AuthorizationResultFailed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _AuthorizationResultFailed<T> implements AuthorizationResult<T> {
  const factory _AuthorizationResultFailed(final Exception e) =
      _$_AuthorizationResultFailed<T>;

  Exception get e;
  @JsonKey(ignore: true)
  _$$_AuthorizationResultFailedCopyWith<T, _$_AuthorizationResultFailed<T>>
      get copyWith => throw _privateConstructorUsedError;
}
