// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compiled_key_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompiledKeyMeta {
  bool get isSigner;
  bool get isWritable;
  bool get isInvoked;

  /// Create a copy of CompiledKeyMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompiledKeyMetaCopyWith<CompiledKeyMeta> get copyWith =>
      _$CompiledKeyMetaCopyWithImpl<CompiledKeyMeta>(this as CompiledKeyMeta, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompiledKeyMeta &&
            (identical(other.isSigner, isSigner) || other.isSigner == isSigner) &&
            (identical(other.isWritable, isWritable) || other.isWritable == isWritable) &&
            (identical(other.isInvoked, isInvoked) || other.isInvoked == isInvoked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSigner, isWritable, isInvoked);

  @override
  String toString() {
    return 'CompiledKeyMeta(isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked)';
  }
}

/// @nodoc
abstract mixin class $CompiledKeyMetaCopyWith<$Res> {
  factory $CompiledKeyMetaCopyWith(CompiledKeyMeta value, $Res Function(CompiledKeyMeta) _then) =
      _$CompiledKeyMetaCopyWithImpl;
  @useResult
  $Res call({bool isSigner, bool isWritable, bool isInvoked});
}

/// @nodoc
class _$CompiledKeyMetaCopyWithImpl<$Res> implements $CompiledKeyMetaCopyWith<$Res> {
  _$CompiledKeyMetaCopyWithImpl(this._self, this._then);

  final CompiledKeyMeta _self;
  final $Res Function(CompiledKeyMeta) _then;

  /// Create a copy of CompiledKeyMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isSigner = null, Object? isWritable = null, Object? isInvoked = null}) {
    return _then(
      _self.copyWith(
        isSigner:
            null == isSigner
                ? _self.isSigner
                : isSigner // ignore: cast_nullable_to_non_nullable
                    as bool,
        isWritable:
            null == isWritable
                ? _self.isWritable
                : isWritable // ignore: cast_nullable_to_non_nullable
                    as bool,
        isInvoked:
            null == isInvoked
                ? _self.isInvoked
                : isInvoked // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _CompiledKeyMeta implements CompiledKeyMeta {
  const _CompiledKeyMeta({
    required this.isSigner,
    required this.isWritable,
    required this.isInvoked,
  });

  @override
  final bool isSigner;
  @override
  final bool isWritable;
  @override
  final bool isInvoked;

  /// Create a copy of CompiledKeyMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompiledKeyMetaCopyWith<_CompiledKeyMeta> get copyWith =>
      __$CompiledKeyMetaCopyWithImpl<_CompiledKeyMeta>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledKeyMeta &&
            (identical(other.isSigner, isSigner) || other.isSigner == isSigner) &&
            (identical(other.isWritable, isWritable) || other.isWritable == isWritable) &&
            (identical(other.isInvoked, isInvoked) || other.isInvoked == isInvoked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSigner, isWritable, isInvoked);

  @override
  String toString() {
    return 'CompiledKeyMeta(isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked)';
  }
}

/// @nodoc
abstract mixin class _$CompiledKeyMetaCopyWith<$Res> implements $CompiledKeyMetaCopyWith<$Res> {
  factory _$CompiledKeyMetaCopyWith(_CompiledKeyMeta value, $Res Function(_CompiledKeyMeta) _then) =
      __$CompiledKeyMetaCopyWithImpl;
  @override
  @useResult
  $Res call({bool isSigner, bool isWritable, bool isInvoked});
}

/// @nodoc
class __$CompiledKeyMetaCopyWithImpl<$Res> implements _$CompiledKeyMetaCopyWith<$Res> {
  __$CompiledKeyMetaCopyWithImpl(this._self, this._then);

  final _CompiledKeyMeta _self;
  final $Res Function(_CompiledKeyMeta) _then;

  /// Create a copy of CompiledKeyMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? isSigner = null, Object? isWritable = null, Object? isInvoked = null}) {
    return _then(
      _CompiledKeyMeta(
        isSigner:
            null == isSigner
                ? _self.isSigner
                : isSigner // ignore: cast_nullable_to_non_nullable
                    as bool,
        isWritable:
            null == isWritable
                ? _self.isWritable
                : isWritable // ignore: cast_nullable_to_non_nullable
                    as bool,
        isInvoked:
            null == isInvoked
                ? _self.isInvoked
                : isInvoked // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}
