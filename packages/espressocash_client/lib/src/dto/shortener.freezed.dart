// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortener.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ShortenLinkRequestDto {
  String get fullLink => throw _privateConstructorUsedError;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShortenLinkRequestDtoCopyWith<ShortenLinkRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortenLinkRequestDtoCopyWith<$Res> {
  factory $ShortenLinkRequestDtoCopyWith(
    ShortenLinkRequestDto value,
    $Res Function(ShortenLinkRequestDto) then,
  ) = _$ShortenLinkRequestDtoCopyWithImpl<$Res, ShortenLinkRequestDto>;
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class _$ShortenLinkRequestDtoCopyWithImpl<$Res, $Val extends ShortenLinkRequestDto>
    implements $ShortenLinkRequestDtoCopyWith<$Res> {
  _$ShortenLinkRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _value.copyWith(
            fullLink:
                null == fullLink
                    ? _value.fullLink
                    : fullLink // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShortenLinkRequestDtoImplCopyWith<$Res>
    implements $ShortenLinkRequestDtoCopyWith<$Res> {
  factory _$$ShortenLinkRequestDtoImplCopyWith(
    _$ShortenLinkRequestDtoImpl value,
    $Res Function(_$ShortenLinkRequestDtoImpl) then,
  ) = __$$ShortenLinkRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class __$$ShortenLinkRequestDtoImplCopyWithImpl<$Res>
    extends _$ShortenLinkRequestDtoCopyWithImpl<$Res, _$ShortenLinkRequestDtoImpl>
    implements _$$ShortenLinkRequestDtoImplCopyWith<$Res> {
  __$$ShortenLinkRequestDtoImplCopyWithImpl(
    _$ShortenLinkRequestDtoImpl _value,
    $Res Function(_$ShortenLinkRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _$ShortenLinkRequestDtoImpl(
        fullLink:
            null == fullLink
                ? _value.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ShortenLinkRequestDtoImpl implements _ShortenLinkRequestDto {
  const _$ShortenLinkRequestDtoImpl({required this.fullLink});

  @override
  final String fullLink;

  @override
  String toString() {
    return 'ShortenLinkRequestDto(fullLink: $fullLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortenLinkRequestDtoImpl &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortenLinkRequestDtoImplCopyWith<_$ShortenLinkRequestDtoImpl> get copyWith =>
      __$$ShortenLinkRequestDtoImplCopyWithImpl<_$ShortenLinkRequestDtoImpl>(this, _$identity);
}

abstract class _ShortenLinkRequestDto implements ShortenLinkRequestDto {
  const factory _ShortenLinkRequestDto({required final String fullLink}) =
      _$ShortenLinkRequestDtoImpl;

  @override
  String get fullLink;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortenLinkRequestDtoImplCopyWith<_$ShortenLinkRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShortenLinkResponseDto {
  String get shortLink => throw _privateConstructorUsedError;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShortenLinkResponseDtoCopyWith<ShortenLinkResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortenLinkResponseDtoCopyWith<$Res> {
  factory $ShortenLinkResponseDtoCopyWith(
    ShortenLinkResponseDto value,
    $Res Function(ShortenLinkResponseDto) then,
  ) = _$ShortenLinkResponseDtoCopyWithImpl<$Res, ShortenLinkResponseDto>;
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class _$ShortenLinkResponseDtoCopyWithImpl<$Res, $Val extends ShortenLinkResponseDto>
    implements $ShortenLinkResponseDtoCopyWith<$Res> {
  _$ShortenLinkResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _value.copyWith(
            shortLink:
                null == shortLink
                    ? _value.shortLink
                    : shortLink // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShortenLinkResponseDtoImplCopyWith<$Res>
    implements $ShortenLinkResponseDtoCopyWith<$Res> {
  factory _$$ShortenLinkResponseDtoImplCopyWith(
    _$ShortenLinkResponseDtoImpl value,
    $Res Function(_$ShortenLinkResponseDtoImpl) then,
  ) = __$$ShortenLinkResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class __$$ShortenLinkResponseDtoImplCopyWithImpl<$Res>
    extends _$ShortenLinkResponseDtoCopyWithImpl<$Res, _$ShortenLinkResponseDtoImpl>
    implements _$$ShortenLinkResponseDtoImplCopyWith<$Res> {
  __$$ShortenLinkResponseDtoImplCopyWithImpl(
    _$ShortenLinkResponseDtoImpl _value,
    $Res Function(_$ShortenLinkResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _$ShortenLinkResponseDtoImpl(
        shortLink:
            null == shortLink
                ? _value.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ShortenLinkResponseDtoImpl implements _ShortenLinkResponseDto {
  const _$ShortenLinkResponseDtoImpl({required this.shortLink});

  @override
  final String shortLink;

  @override
  String toString() {
    return 'ShortenLinkResponseDto(shortLink: $shortLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortenLinkResponseDtoImpl &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortenLinkResponseDtoImplCopyWith<_$ShortenLinkResponseDtoImpl> get copyWith =>
      __$$ShortenLinkResponseDtoImplCopyWithImpl<_$ShortenLinkResponseDtoImpl>(this, _$identity);
}

abstract class _ShortenLinkResponseDto implements ShortenLinkResponseDto {
  const factory _ShortenLinkResponseDto({required final String shortLink}) =
      _$ShortenLinkResponseDtoImpl;

  @override
  String get shortLink;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortenLinkResponseDtoImplCopyWith<_$ShortenLinkResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UnshortenLinkRequestDto {
  String get shortLink => throw _privateConstructorUsedError;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnshortenLinkRequestDtoCopyWith<UnshortenLinkRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnshortenLinkRequestDtoCopyWith<$Res> {
  factory $UnshortenLinkRequestDtoCopyWith(
    UnshortenLinkRequestDto value,
    $Res Function(UnshortenLinkRequestDto) then,
  ) = _$UnshortenLinkRequestDtoCopyWithImpl<$Res, UnshortenLinkRequestDto>;
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class _$UnshortenLinkRequestDtoCopyWithImpl<$Res, $Val extends UnshortenLinkRequestDto>
    implements $UnshortenLinkRequestDtoCopyWith<$Res> {
  _$UnshortenLinkRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _value.copyWith(
            shortLink:
                null == shortLink
                    ? _value.shortLink
                    : shortLink // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnshortenLinkRequestDtoImplCopyWith<$Res>
    implements $UnshortenLinkRequestDtoCopyWith<$Res> {
  factory _$$UnshortenLinkRequestDtoImplCopyWith(
    _$UnshortenLinkRequestDtoImpl value,
    $Res Function(_$UnshortenLinkRequestDtoImpl) then,
  ) = __$$UnshortenLinkRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class __$$UnshortenLinkRequestDtoImplCopyWithImpl<$Res>
    extends _$UnshortenLinkRequestDtoCopyWithImpl<$Res, _$UnshortenLinkRequestDtoImpl>
    implements _$$UnshortenLinkRequestDtoImplCopyWith<$Res> {
  __$$UnshortenLinkRequestDtoImplCopyWithImpl(
    _$UnshortenLinkRequestDtoImpl _value,
    $Res Function(_$UnshortenLinkRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _$UnshortenLinkRequestDtoImpl(
        shortLink:
            null == shortLink
                ? _value.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$UnshortenLinkRequestDtoImpl implements _UnshortenLinkRequestDto {
  const _$UnshortenLinkRequestDtoImpl({required this.shortLink});

  @override
  final String shortLink;

  @override
  String toString() {
    return 'UnshortenLinkRequestDto(shortLink: $shortLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnshortenLinkRequestDtoImpl &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnshortenLinkRequestDtoImplCopyWith<_$UnshortenLinkRequestDtoImpl> get copyWith =>
      __$$UnshortenLinkRequestDtoImplCopyWithImpl<_$UnshortenLinkRequestDtoImpl>(this, _$identity);
}

abstract class _UnshortenLinkRequestDto implements UnshortenLinkRequestDto {
  const factory _UnshortenLinkRequestDto({required final String shortLink}) =
      _$UnshortenLinkRequestDtoImpl;

  @override
  String get shortLink;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnshortenLinkRequestDtoImplCopyWith<_$UnshortenLinkRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UnshortenLinkResponseDto {
  String get fullLink => throw _privateConstructorUsedError;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnshortenLinkResponseDtoCopyWith<UnshortenLinkResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnshortenLinkResponseDtoCopyWith<$Res> {
  factory $UnshortenLinkResponseDtoCopyWith(
    UnshortenLinkResponseDto value,
    $Res Function(UnshortenLinkResponseDto) then,
  ) = _$UnshortenLinkResponseDtoCopyWithImpl<$Res, UnshortenLinkResponseDto>;
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class _$UnshortenLinkResponseDtoCopyWithImpl<$Res, $Val extends UnshortenLinkResponseDto>
    implements $UnshortenLinkResponseDtoCopyWith<$Res> {
  _$UnshortenLinkResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _value.copyWith(
            fullLink:
                null == fullLink
                    ? _value.fullLink
                    : fullLink // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnshortenLinkResponseDtoImplCopyWith<$Res>
    implements $UnshortenLinkResponseDtoCopyWith<$Res> {
  factory _$$UnshortenLinkResponseDtoImplCopyWith(
    _$UnshortenLinkResponseDtoImpl value,
    $Res Function(_$UnshortenLinkResponseDtoImpl) then,
  ) = __$$UnshortenLinkResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class __$$UnshortenLinkResponseDtoImplCopyWithImpl<$Res>
    extends _$UnshortenLinkResponseDtoCopyWithImpl<$Res, _$UnshortenLinkResponseDtoImpl>
    implements _$$UnshortenLinkResponseDtoImplCopyWith<$Res> {
  __$$UnshortenLinkResponseDtoImplCopyWithImpl(
    _$UnshortenLinkResponseDtoImpl _value,
    $Res Function(_$UnshortenLinkResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _$UnshortenLinkResponseDtoImpl(
        fullLink:
            null == fullLink
                ? _value.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$UnshortenLinkResponseDtoImpl implements _UnshortenLinkResponseDto {
  const _$UnshortenLinkResponseDtoImpl({required this.fullLink});

  @override
  final String fullLink;

  @override
  String toString() {
    return 'UnshortenLinkResponseDto(fullLink: $fullLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnshortenLinkResponseDtoImpl &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnshortenLinkResponseDtoImplCopyWith<_$UnshortenLinkResponseDtoImpl> get copyWith =>
      __$$UnshortenLinkResponseDtoImplCopyWithImpl<_$UnshortenLinkResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _UnshortenLinkResponseDto implements UnshortenLinkResponseDto {
  const factory _UnshortenLinkResponseDto({required final String fullLink}) =
      _$UnshortenLinkResponseDtoImpl;

  @override
  String get fullLink;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnshortenLinkResponseDtoImplCopyWith<_$UnshortenLinkResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
