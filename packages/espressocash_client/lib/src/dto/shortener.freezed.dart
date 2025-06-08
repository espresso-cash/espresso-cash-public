// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortener.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShortenLinkRequestDto {
  String get fullLink;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShortenLinkRequestDtoCopyWith<ShortenLinkRequestDto> get copyWith =>
      _$ShortenLinkRequestDtoCopyWithImpl<ShortenLinkRequestDto>(
        this as ShortenLinkRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShortenLinkRequestDto &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  @override
  String toString() {
    return 'ShortenLinkRequestDto(fullLink: $fullLink)';
  }
}

/// @nodoc
abstract mixin class $ShortenLinkRequestDtoCopyWith<$Res> {
  factory $ShortenLinkRequestDtoCopyWith(
    ShortenLinkRequestDto value,
    $Res Function(ShortenLinkRequestDto) _then,
  ) = _$ShortenLinkRequestDtoCopyWithImpl;
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class _$ShortenLinkRequestDtoCopyWithImpl<$Res> implements $ShortenLinkRequestDtoCopyWith<$Res> {
  _$ShortenLinkRequestDtoCopyWithImpl(this._self, this._then);

  final ShortenLinkRequestDto _self;
  final $Res Function(ShortenLinkRequestDto) _then;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _self.copyWith(
        fullLink:
            null == fullLink
                ? _self.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _ShortenLinkRequestDto implements ShortenLinkRequestDto {
  const _ShortenLinkRequestDto({required this.fullLink});

  @override
  final String fullLink;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShortenLinkRequestDtoCopyWith<_ShortenLinkRequestDto> get copyWith =>
      __$ShortenLinkRequestDtoCopyWithImpl<_ShortenLinkRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShortenLinkRequestDto &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  @override
  String toString() {
    return 'ShortenLinkRequestDto(fullLink: $fullLink)';
  }
}

/// @nodoc
abstract mixin class _$ShortenLinkRequestDtoCopyWith<$Res>
    implements $ShortenLinkRequestDtoCopyWith<$Res> {
  factory _$ShortenLinkRequestDtoCopyWith(
    _ShortenLinkRequestDto value,
    $Res Function(_ShortenLinkRequestDto) _then,
  ) = __$ShortenLinkRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class __$ShortenLinkRequestDtoCopyWithImpl<$Res> implements _$ShortenLinkRequestDtoCopyWith<$Res> {
  __$ShortenLinkRequestDtoCopyWithImpl(this._self, this._then);

  final _ShortenLinkRequestDto _self;
  final $Res Function(_ShortenLinkRequestDto) _then;

  /// Create a copy of ShortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? fullLink = null}) {
    return _then(
      _ShortenLinkRequestDto(
        fullLink:
            null == fullLink
                ? _self.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$ShortenLinkResponseDto {
  String get shortLink;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShortenLinkResponseDtoCopyWith<ShortenLinkResponseDto> get copyWith =>
      _$ShortenLinkResponseDtoCopyWithImpl<ShortenLinkResponseDto>(
        this as ShortenLinkResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShortenLinkResponseDto &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  @override
  String toString() {
    return 'ShortenLinkResponseDto(shortLink: $shortLink)';
  }
}

/// @nodoc
abstract mixin class $ShortenLinkResponseDtoCopyWith<$Res> {
  factory $ShortenLinkResponseDtoCopyWith(
    ShortenLinkResponseDto value,
    $Res Function(ShortenLinkResponseDto) _then,
  ) = _$ShortenLinkResponseDtoCopyWithImpl;
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class _$ShortenLinkResponseDtoCopyWithImpl<$Res> implements $ShortenLinkResponseDtoCopyWith<$Res> {
  _$ShortenLinkResponseDtoCopyWithImpl(this._self, this._then);

  final ShortenLinkResponseDto _self;
  final $Res Function(ShortenLinkResponseDto) _then;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _self.copyWith(
        shortLink:
            null == shortLink
                ? _self.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _ShortenLinkResponseDto implements ShortenLinkResponseDto {
  const _ShortenLinkResponseDto({required this.shortLink});

  @override
  final String shortLink;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShortenLinkResponseDtoCopyWith<_ShortenLinkResponseDto> get copyWith =>
      __$ShortenLinkResponseDtoCopyWithImpl<_ShortenLinkResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShortenLinkResponseDto &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  @override
  String toString() {
    return 'ShortenLinkResponseDto(shortLink: $shortLink)';
  }
}

/// @nodoc
abstract mixin class _$ShortenLinkResponseDtoCopyWith<$Res>
    implements $ShortenLinkResponseDtoCopyWith<$Res> {
  factory _$ShortenLinkResponseDtoCopyWith(
    _ShortenLinkResponseDto value,
    $Res Function(_ShortenLinkResponseDto) _then,
  ) = __$ShortenLinkResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class __$ShortenLinkResponseDtoCopyWithImpl<$Res>
    implements _$ShortenLinkResponseDtoCopyWith<$Res> {
  __$ShortenLinkResponseDtoCopyWithImpl(this._self, this._then);

  final _ShortenLinkResponseDto _self;
  final $Res Function(_ShortenLinkResponseDto) _then;

  /// Create a copy of ShortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? shortLink = null}) {
    return _then(
      _ShortenLinkResponseDto(
        shortLink:
            null == shortLink
                ? _self.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$UnshortenLinkRequestDto {
  String get shortLink;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnshortenLinkRequestDtoCopyWith<UnshortenLinkRequestDto> get copyWith =>
      _$UnshortenLinkRequestDtoCopyWithImpl<UnshortenLinkRequestDto>(
        this as UnshortenLinkRequestDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnshortenLinkRequestDto &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  @override
  String toString() {
    return 'UnshortenLinkRequestDto(shortLink: $shortLink)';
  }
}

/// @nodoc
abstract mixin class $UnshortenLinkRequestDtoCopyWith<$Res> {
  factory $UnshortenLinkRequestDtoCopyWith(
    UnshortenLinkRequestDto value,
    $Res Function(UnshortenLinkRequestDto) _then,
  ) = _$UnshortenLinkRequestDtoCopyWithImpl;
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class _$UnshortenLinkRequestDtoCopyWithImpl<$Res>
    implements $UnshortenLinkRequestDtoCopyWith<$Res> {
  _$UnshortenLinkRequestDtoCopyWithImpl(this._self, this._then);

  final UnshortenLinkRequestDto _self;
  final $Res Function(UnshortenLinkRequestDto) _then;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shortLink = null}) {
    return _then(
      _self.copyWith(
        shortLink:
            null == shortLink
                ? _self.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _UnshortenLinkRequestDto implements UnshortenLinkRequestDto {
  const _UnshortenLinkRequestDto({required this.shortLink});

  @override
  final String shortLink;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnshortenLinkRequestDtoCopyWith<_UnshortenLinkRequestDto> get copyWith =>
      __$UnshortenLinkRequestDtoCopyWithImpl<_UnshortenLinkRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnshortenLinkRequestDto &&
            (identical(other.shortLink, shortLink) || other.shortLink == shortLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortLink);

  @override
  String toString() {
    return 'UnshortenLinkRequestDto(shortLink: $shortLink)';
  }
}

/// @nodoc
abstract mixin class _$UnshortenLinkRequestDtoCopyWith<$Res>
    implements $UnshortenLinkRequestDtoCopyWith<$Res> {
  factory _$UnshortenLinkRequestDtoCopyWith(
    _UnshortenLinkRequestDto value,
    $Res Function(_UnshortenLinkRequestDto) _then,
  ) = __$UnshortenLinkRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String shortLink});
}

/// @nodoc
class __$UnshortenLinkRequestDtoCopyWithImpl<$Res>
    implements _$UnshortenLinkRequestDtoCopyWith<$Res> {
  __$UnshortenLinkRequestDtoCopyWithImpl(this._self, this._then);

  final _UnshortenLinkRequestDto _self;
  final $Res Function(_UnshortenLinkRequestDto) _then;

  /// Create a copy of UnshortenLinkRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? shortLink = null}) {
    return _then(
      _UnshortenLinkRequestDto(
        shortLink:
            null == shortLink
                ? _self.shortLink
                : shortLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$UnshortenLinkResponseDto {
  String get fullLink;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnshortenLinkResponseDtoCopyWith<UnshortenLinkResponseDto> get copyWith =>
      _$UnshortenLinkResponseDtoCopyWithImpl<UnshortenLinkResponseDto>(
        this as UnshortenLinkResponseDto,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnshortenLinkResponseDto &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  @override
  String toString() {
    return 'UnshortenLinkResponseDto(fullLink: $fullLink)';
  }
}

/// @nodoc
abstract mixin class $UnshortenLinkResponseDtoCopyWith<$Res> {
  factory $UnshortenLinkResponseDtoCopyWith(
    UnshortenLinkResponseDto value,
    $Res Function(UnshortenLinkResponseDto) _then,
  ) = _$UnshortenLinkResponseDtoCopyWithImpl;
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class _$UnshortenLinkResponseDtoCopyWithImpl<$Res>
    implements $UnshortenLinkResponseDtoCopyWith<$Res> {
  _$UnshortenLinkResponseDtoCopyWithImpl(this._self, this._then);

  final UnshortenLinkResponseDto _self;
  final $Res Function(UnshortenLinkResponseDto) _then;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fullLink = null}) {
    return _then(
      _self.copyWith(
        fullLink:
            null == fullLink
                ? _self.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _UnshortenLinkResponseDto implements UnshortenLinkResponseDto {
  const _UnshortenLinkResponseDto({required this.fullLink});

  @override
  final String fullLink;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnshortenLinkResponseDtoCopyWith<_UnshortenLinkResponseDto> get copyWith =>
      __$UnshortenLinkResponseDtoCopyWithImpl<_UnshortenLinkResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnshortenLinkResponseDto &&
            (identical(other.fullLink, fullLink) || other.fullLink == fullLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullLink);

  @override
  String toString() {
    return 'UnshortenLinkResponseDto(fullLink: $fullLink)';
  }
}

/// @nodoc
abstract mixin class _$UnshortenLinkResponseDtoCopyWith<$Res>
    implements $UnshortenLinkResponseDtoCopyWith<$Res> {
  factory _$UnshortenLinkResponseDtoCopyWith(
    _UnshortenLinkResponseDto value,
    $Res Function(_UnshortenLinkResponseDto) _then,
  ) = __$UnshortenLinkResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String fullLink});
}

/// @nodoc
class __$UnshortenLinkResponseDtoCopyWithImpl<$Res>
    implements _$UnshortenLinkResponseDtoCopyWith<$Res> {
  __$UnshortenLinkResponseDtoCopyWithImpl(this._self, this._then);

  final _UnshortenLinkResponseDto _self;
  final $Res Function(_UnshortenLinkResponseDto) _then;

  /// Create a copy of UnshortenLinkResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? fullLink = null}) {
    return _then(
      _UnshortenLinkResponseDto(
        fullLink:
            null == fullLink
                ? _self.fullLink
                : fullLink // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}
