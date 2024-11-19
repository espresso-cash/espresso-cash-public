// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ambassador_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AmbassadorStatsResponseDto _$AmbassadorStatsResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _AmbassadorStatsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$AmbassadorStatsResponseDto {
  int get referralCount => throw _privateConstructorUsedError;

  /// Serializes this AmbassadorStatsResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmbassadorStatsResponseDtoCopyWith<AmbassadorStatsResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory $AmbassadorStatsResponseDtoCopyWith(AmbassadorStatsResponseDto value,
          $Res Function(AmbassadorStatsResponseDto) then) =
      _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
          AmbassadorStatsResponseDto>;
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
        $Val extends AmbassadorStatsResponseDto>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  _$AmbassadorStatsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCount = null,
  }) {
    return _then(_value.copyWith(
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbassadorStatsResponseDtoImplCopyWith<$Res>
    implements $AmbassadorStatsResponseDtoCopyWith<$Res> {
  factory _$$AmbassadorStatsResponseDtoImplCopyWith(
          _$AmbassadorStatsResponseDtoImpl value,
          $Res Function(_$AmbassadorStatsResponseDtoImpl) then) =
      __$$AmbassadorStatsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int referralCount});
}

/// @nodoc
class __$$AmbassadorStatsResponseDtoImplCopyWithImpl<$Res>
    extends _$AmbassadorStatsResponseDtoCopyWithImpl<$Res,
        _$AmbassadorStatsResponseDtoImpl>
    implements _$$AmbassadorStatsResponseDtoImplCopyWith<$Res> {
  __$$AmbassadorStatsResponseDtoImplCopyWithImpl(
      _$AmbassadorStatsResponseDtoImpl _value,
      $Res Function(_$AmbassadorStatsResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCount = null,
  }) {
    return _then(_$AmbassadorStatsResponseDtoImpl(
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbassadorStatsResponseDtoImpl implements _AmbassadorStatsResponseDto {
  const _$AmbassadorStatsResponseDtoImpl({required this.referralCount});

  factory _$AmbassadorStatsResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AmbassadorStatsResponseDtoImplFromJson(json);

  @override
  final int referralCount;

  @override
  String toString() {
    return 'AmbassadorStatsResponseDto(referralCount: $referralCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbassadorStatsResponseDtoImpl &&
            (identical(other.referralCount, referralCount) ||
                other.referralCount == referralCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, referralCount);

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbassadorStatsResponseDtoImplCopyWith<_$AmbassadorStatsResponseDtoImpl>
      get copyWith => __$$AmbassadorStatsResponseDtoImplCopyWithImpl<
          _$AmbassadorStatsResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbassadorStatsResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _AmbassadorStatsResponseDto
    implements AmbassadorStatsResponseDto {
  const factory _AmbassadorStatsResponseDto(
      {required final int referralCount}) = _$AmbassadorStatsResponseDtoImpl;

  factory _AmbassadorStatsResponseDto.fromJson(Map<String, dynamic> json) =
      _$AmbassadorStatsResponseDtoImpl.fromJson;

  @override
  int get referralCount;

  /// Create a copy of AmbassadorStatsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmbassadorStatsResponseDtoImplCopyWith<_$AmbassadorStatsResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
