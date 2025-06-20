// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetTokensMetaResponseDto {
  String get md5;

  /// Create a copy of GetTokensMetaResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetTokensMetaResponseDtoCopyWith<GetTokensMetaResponseDto> get copyWith =>
      _$GetTokensMetaResponseDtoCopyWithImpl<GetTokensMetaResponseDto>(
        this as GetTokensMetaResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetTokensMetaResponseDto &&
            (identical(other.md5, md5) || other.md5 == md5));
  }

  @override
  int get hashCode => Object.hash(runtimeType, md5);

  @override
  String toString() {
    return 'GetTokensMetaResponseDto(md5: $md5)';
  }
}

/// @nodoc
abstract mixin class $GetTokensMetaResponseDtoCopyWith<$Res> {
  factory $GetTokensMetaResponseDtoCopyWith(
    GetTokensMetaResponseDto value,
    $Res Function(GetTokensMetaResponseDto) _then,
  ) = _$GetTokensMetaResponseDtoCopyWithImpl;
  @useResult
  $Res call({String md5});
}

/// @nodoc
class _$GetTokensMetaResponseDtoCopyWithImpl<$Res>
    implements $GetTokensMetaResponseDtoCopyWith<$Res> {
  _$GetTokensMetaResponseDtoCopyWithImpl(this._self, this._then);

  final GetTokensMetaResponseDto _self;
  final $Res Function(GetTokensMetaResponseDto) _then;

  /// Create a copy of GetTokensMetaResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? md5 = null}) {
    return _then(
      _self.copyWith(
        md5:
            null == md5
                ? _self.md5
                : md5 // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _GetTokensMetaResponseDto implements GetTokensMetaResponseDto {
  const _GetTokensMetaResponseDto({required this.md5});

  @override
  final String md5;

  /// Create a copy of GetTokensMetaResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetTokensMetaResponseDtoCopyWith<_GetTokensMetaResponseDto> get copyWith =>
      __$GetTokensMetaResponseDtoCopyWithImpl<_GetTokensMetaResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetTokensMetaResponseDto &&
            (identical(other.md5, md5) || other.md5 == md5));
  }

  @override
  int get hashCode => Object.hash(runtimeType, md5);

  @override
  String toString() {
    return 'GetTokensMetaResponseDto(md5: $md5)';
  }
}

/// @nodoc
abstract mixin class _$GetTokensMetaResponseDtoCopyWith<$Res>
    implements $GetTokensMetaResponseDtoCopyWith<$Res> {
  factory _$GetTokensMetaResponseDtoCopyWith(
    _GetTokensMetaResponseDto value,
    $Res Function(_GetTokensMetaResponseDto) _then,
  ) = __$GetTokensMetaResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String md5});
}

/// @nodoc
class __$GetTokensMetaResponseDtoCopyWithImpl<$Res>
    implements _$GetTokensMetaResponseDtoCopyWith<$Res> {
  __$GetTokensMetaResponseDtoCopyWithImpl(this._self, this._then);

  final _GetTokensMetaResponseDto _self;
  final $Res Function(_GetTokensMetaResponseDto) _then;

  /// Create a copy of GetTokensMetaResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? md5 = null}) {
    return _then(
      _GetTokensMetaResponseDto(
        md5:
            null == md5
                ? _self.md5
                : md5 // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
