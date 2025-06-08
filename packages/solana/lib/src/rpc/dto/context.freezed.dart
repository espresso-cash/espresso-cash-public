// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Context {
  @JsonKey(fromJson: bigIntFromJson)
  BigInt get slot;

  /// Create a copy of Context
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContextCopyWith<Context> get copyWith =>
      _$ContextCopyWithImpl<Context>(this as Context, _$identity);

  /// Serializes this Context to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Context &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slot);

  @override
  String toString() {
    return 'Context(slot: $slot)';
  }
}

/// @nodoc
abstract mixin class $ContextCopyWith<$Res> {
  factory $ContextCopyWith(Context value, $Res Function(Context) _then) = _$ContextCopyWithImpl;
  @useResult
  $Res call({@JsonKey(fromJson: bigIntFromJson) BigInt slot});
}

/// @nodoc
class _$ContextCopyWithImpl<$Res> implements $ContextCopyWith<$Res> {
  _$ContextCopyWithImpl(this._self, this._then);

  final Context _self;
  final $Res Function(Context) _then;

  /// Create a copy of Context
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? slot = null}) {
    return _then(
      _self.copyWith(
        slot:
            null == slot
                ? _self.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _Context implements Context {
  const _Context({@JsonKey(fromJson: bigIntFromJson) required this.slot});
  factory _Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);

  @override
  @JsonKey(fromJson: bigIntFromJson)
  final BigInt slot;

  /// Create a copy of Context
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContextCopyWith<_Context> get copyWith => __$ContextCopyWithImpl<_Context>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContextToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Context &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slot);

  @override
  String toString() {
    return 'Context(slot: $slot)';
  }
}

/// @nodoc
abstract mixin class _$ContextCopyWith<$Res> implements $ContextCopyWith<$Res> {
  factory _$ContextCopyWith(_Context value, $Res Function(_Context) _then) = __$ContextCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(fromJson: bigIntFromJson) BigInt slot});
}

/// @nodoc
class __$ContextCopyWithImpl<$Res> implements _$ContextCopyWith<$Res> {
  __$ContextCopyWithImpl(this._self, this._then);

  final _Context _self;
  final $Res Function(_Context) _then;

  /// Create a copy of Context
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? slot = null}) {
    return _then(
      _Context(
        slot:
            null == slot
                ? _self.slot
                : slot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
      ),
    );
  }
}
