// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Flow<E extends Exception, R> {}

/// @nodoc

class _$FlowInitialImpl<E extends Exception, R> extends FlowInitial<E, R> {
  const _$FlowInitialImpl() : super._();

  @override
  String toString() {
    return 'Flow<$E, $R>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FlowInitialImpl<E, R>);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class FlowInitial<E extends Exception, R> extends Flow<E, R> {
  const factory FlowInitial() = _$FlowInitialImpl<E, R>;
  const FlowInitial._() : super._();
}

/// @nodoc

class _$FlowProcessingImpl<E extends Exception, R>
    extends FlowProcessing<E, R> {
  const _$FlowProcessingImpl() : super._();

  @override
  String toString() {
    return 'Flow<$E, $R>.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowProcessingImpl<E, R>);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class FlowProcessing<E extends Exception, R> extends Flow<E, R> {
  const factory FlowProcessing() = _$FlowProcessingImpl<E, R>;
  const FlowProcessing._() : super._();
}

/// @nodoc

class _$FlowFailureImpl<E extends Exception, R> extends FlowFailure<E, R> {
  const _$FlowFailureImpl(this.error) : super._();

  @override
  final E error;

  @override
  String toString() {
    return 'Flow<$E, $R>.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowFailureImpl<E, R> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));
}

abstract class FlowFailure<E extends Exception, R> extends Flow<E, R> {
  const factory FlowFailure(final E error) = _$FlowFailureImpl<E, R>;
  const FlowFailure._() : super._();

  E get error;
}

/// @nodoc

class _$FlowSuccessImpl<E extends Exception, R> extends FlowSuccess<E, R> {
  const _$FlowSuccessImpl(this.result) : super._();

  @override
  final R result;

  @override
  String toString() {
    return 'Flow<$E, $R>.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowSuccessImpl<E, R> &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));
}

abstract class FlowSuccess<E extends Exception, R> extends Flow<E, R> {
  const factory FlowSuccess(final R result) = _$FlowSuccessImpl<E, R>;
  const FlowSuccess._() : super._();

  R get result;
}
