// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetTokenListMetaResponseDto _$GetTokenListMetaResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GetTokenListMetaResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GetTokenListMetaResponseDto {
  String get md5 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetTokenListMetaResponseDtoCopyWith<GetTokenListMetaResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetTokenListMetaResponseDtoCopyWith<$Res> {
  factory $GetTokenListMetaResponseDtoCopyWith(
          GetTokenListMetaResponseDto value,
          $Res Function(GetTokenListMetaResponseDto) then) =
      _$GetTokenListMetaResponseDtoCopyWithImpl<$Res,
          GetTokenListMetaResponseDto>;
  @useResult
  $Res call({String md5});
}

/// @nodoc
class _$GetTokenListMetaResponseDtoCopyWithImpl<$Res,
        $Val extends GetTokenListMetaResponseDto>
    implements $GetTokenListMetaResponseDtoCopyWith<$Res> {
  _$GetTokenListMetaResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? md5 = null,
  }) {
    return _then(_value.copyWith(
      md5: null == md5
          ? _value.md5
          : md5 // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetTokenListMetaResponseDtoImplCopyWith<$Res>
    implements $GetTokenListMetaResponseDtoCopyWith<$Res> {
  factory _$$GetTokenListMetaResponseDtoImplCopyWith(
          _$GetTokenListMetaResponseDtoImpl value,
          $Res Function(_$GetTokenListMetaResponseDtoImpl) then) =
      __$$GetTokenListMetaResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String md5});
}

/// @nodoc
class __$$GetTokenListMetaResponseDtoImplCopyWithImpl<$Res>
    extends _$GetTokenListMetaResponseDtoCopyWithImpl<$Res,
        _$GetTokenListMetaResponseDtoImpl>
    implements _$$GetTokenListMetaResponseDtoImplCopyWith<$Res> {
  __$$GetTokenListMetaResponseDtoImplCopyWithImpl(
      _$GetTokenListMetaResponseDtoImpl _value,
      $Res Function(_$GetTokenListMetaResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? md5 = null,
  }) {
    return _then(_$GetTokenListMetaResponseDtoImpl(
      md5: null == md5
          ? _value.md5
          : md5 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetTokenListMetaResponseDtoImpl
    implements _GetTokenListMetaResponseDto {
  const _$GetTokenListMetaResponseDtoImpl({required this.md5});

  factory _$GetTokenListMetaResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetTokenListMetaResponseDtoImplFromJson(json);

  @override
  final String md5;

  @override
  String toString() {
    return 'GetTokenListMetaResponseDto(md5: $md5)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTokenListMetaResponseDtoImpl &&
            (identical(other.md5, md5) || other.md5 == md5));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, md5);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTokenListMetaResponseDtoImplCopyWith<_$GetTokenListMetaResponseDtoImpl>
      get copyWith => __$$GetTokenListMetaResponseDtoImplCopyWithImpl<
          _$GetTokenListMetaResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetTokenListMetaResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GetTokenListMetaResponseDto
    implements GetTokenListMetaResponseDto {
  const factory _GetTokenListMetaResponseDto({required final String md5}) =
      _$GetTokenListMetaResponseDtoImpl;

  factory _GetTokenListMetaResponseDto.fromJson(Map<String, dynamic> json) =
      _$GetTokenListMetaResponseDtoImpl.fromJson;

  @override
  String get md5;
  @override
  @JsonKey(ignore: true)
  _$$GetTokenListMetaResponseDtoImplCopyWith<_$GetTokenListMetaResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
