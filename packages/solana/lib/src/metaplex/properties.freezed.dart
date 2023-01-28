// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'properties.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  switch (json['category']) {
    case 'video':
      return Video.fromJson(json);
    case 'image':
      return Image.fromJson(json);
    case 'vr':
      return Model3D.fromJson(json);
    case 'audio':
      return Audio.fromJson(json);
    case 'html':
      return Html.fromJson(json);

    default:
      return Unknown.fromJson(json);
  }
}

/// @nodoc
mixin _$Properties {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertiesCopyWith<$Res> {
  factory $PropertiesCopyWith(
          Properties value, $Res Function(Properties) then) =
      _$PropertiesCopyWithImpl<$Res, Properties>;
}

/// @nodoc
class _$PropertiesCopyWithImpl<$Res, $Val extends Properties>
    implements $PropertiesCopyWith<$Res> {
  _$PropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnknownCopyWith<$Res> {
  factory _$$UnknownCopyWith(_$Unknown value, $Res Function(_$Unknown) then) =
      __$$UnknownCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnknownCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$Unknown>
    implements _$$UnknownCopyWith<$Res> {
  __$$UnknownCopyWithImpl(_$Unknown _value, $Res Function(_$Unknown) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$Unknown implements Unknown {
  const _$Unknown({final String? $type}) : $type = $type ?? 'unknown';

  factory _$Unknown.fromJson(Map<String, dynamic> json) =>
      _$$UnknownFromJson(json);

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Unknown);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownToJson(
      this,
    );
  }
}

abstract class Unknown implements Properties {
  const factory Unknown() = _$Unknown;

  factory Unknown.fromJson(Map<String, dynamic> json) = _$Unknown.fromJson;
}

/// @nodoc
abstract class _$$VideoCopyWith<$Res> {
  factory _$$VideoCopyWith(_$Video value, $Res Function(_$Video) then) =
      __$$VideoCopyWithImpl<$Res>;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class __$$VideoCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$Video>
    implements _$$VideoCopyWith<$Res> {
  __$$VideoCopyWithImpl(_$Video _value, $Res Function(_$Video) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$Video(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Video implements Video {
  const _$Video({required final List<File> files, final String? $type})
      : _files = files,
        $type = $type ?? 'video';

  factory _$Video.fromJson(Map<String, dynamic> json) => _$$VideoFromJson(json);

  final List<File> _files;
  @override
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.video(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Video &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoCopyWith<_$Video> get copyWith =>
      __$$VideoCopyWithImpl<_$Video>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return video(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return video?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return video(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return video?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoToJson(
      this,
    );
  }
}

abstract class Video implements Properties {
  const factory Video({required final List<File> files}) = _$Video;

  factory Video.fromJson(Map<String, dynamic> json) = _$Video.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  _$$VideoCopyWith<_$Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageCopyWith<$Res> {
  factory _$$ImageCopyWith(_$Image value, $Res Function(_$Image) then) =
      __$$ImageCopyWithImpl<$Res>;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class __$$ImageCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$Image>
    implements _$$ImageCopyWith<$Res> {
  __$$ImageCopyWithImpl(_$Image _value, $Res Function(_$Image) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$Image(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Image implements Image {
  const _$Image({required final List<File> files, final String? $type})
      : _files = files,
        $type = $type ?? 'image';

  factory _$Image.fromJson(Map<String, dynamic> json) => _$$ImageFromJson(json);

  final List<File> _files;
  @override
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.image(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Image &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageCopyWith<_$Image> get copyWith =>
      __$$ImageCopyWithImpl<_$Image>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return image(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return image?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageToJson(
      this,
    );
  }
}

abstract class Image implements Properties {
  const factory Image({required final List<File> files}) = _$Image;

  factory Image.fromJson(Map<String, dynamic> json) = _$Image.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  _$$ImageCopyWith<_$Image> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Model3DCopyWith<$Res> {
  factory _$$Model3DCopyWith(_$Model3D value, $Res Function(_$Model3D) then) =
      __$$Model3DCopyWithImpl<$Res>;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class __$$Model3DCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$Model3D>
    implements _$$Model3DCopyWith<$Res> {
  __$$Model3DCopyWithImpl(_$Model3D _value, $Res Function(_$Model3D) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$Model3D(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Model3D implements Model3D {
  const _$Model3D({required final List<File> files, final String? $type})
      : _files = files,
        $type = $type ?? 'vr';

  factory _$Model3D.fromJson(Map<String, dynamic> json) =>
      _$$Model3DFromJson(json);

  final List<File> _files;
  @override
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.vr(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Model3D &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Model3DCopyWith<_$Model3D> get copyWith =>
      __$$Model3DCopyWithImpl<_$Model3D>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return vr(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return vr?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (vr != null) {
      return vr(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return vr(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return vr?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (vr != null) {
      return vr(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Model3DToJson(
      this,
    );
  }
}

abstract class Model3D implements Properties {
  const factory Model3D({required final List<File> files}) = _$Model3D;

  factory Model3D.fromJson(Map<String, dynamic> json) = _$Model3D.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  _$$Model3DCopyWith<_$Model3D> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AudioCopyWith<$Res> {
  factory _$$AudioCopyWith(_$Audio value, $Res Function(_$Audio) then) =
      __$$AudioCopyWithImpl<$Res>;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class __$$AudioCopyWithImpl<$Res>
    extends _$PropertiesCopyWithImpl<$Res, _$Audio>
    implements _$$AudioCopyWith<$Res> {
  __$$AudioCopyWithImpl(_$Audio _value, $Res Function(_$Audio) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$Audio(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Audio implements Audio {
  const _$Audio({required final List<File> files, final String? $type})
      : _files = files,
        $type = $type ?? 'audio';

  factory _$Audio.fromJson(Map<String, dynamic> json) => _$$AudioFromJson(json);

  final List<File> _files;
  @override
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.audio(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Audio &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioCopyWith<_$Audio> get copyWith =>
      __$$AudioCopyWithImpl<_$Audio>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return audio(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return audio?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (audio != null) {
      return audio(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return audio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return audio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (audio != null) {
      return audio(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioToJson(
      this,
    );
  }
}

abstract class Audio implements Properties {
  const factory Audio({required final List<File> files}) = _$Audio;

  factory Audio.fromJson(Map<String, dynamic> json) = _$Audio.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  _$$AudioCopyWith<_$Audio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HtmlCopyWith<$Res> {
  factory _$$HtmlCopyWith(_$Html value, $Res Function(_$Html) then) =
      __$$HtmlCopyWithImpl<$Res>;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class __$$HtmlCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res, _$Html>
    implements _$$HtmlCopyWith<$Res> {
  __$$HtmlCopyWithImpl(_$Html _value, $Res Function(_$Html) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$Html(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Html implements Html {
  const _$Html({required final List<File> files, final String? $type})
      : _files = files,
        $type = $type ?? 'html';

  factory _$Html.fromJson(Map<String, dynamic> json) => _$$HtmlFromJson(json);

  final List<File> _files;
  @override
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  @override
  String toString() {
    return 'Properties.html(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Html &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HtmlCopyWith<_$Html> get copyWith =>
      __$$HtmlCopyWithImpl<_$Html>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(List<File> files) video,
    required TResult Function(List<File> files) image,
    required TResult Function(List<File> files) vr,
    required TResult Function(List<File> files) audio,
    required TResult Function(List<File> files) html,
  }) {
    return html(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(List<File> files)? video,
    TResult? Function(List<File> files)? image,
    TResult? Function(List<File> files)? vr,
    TResult? Function(List<File> files)? audio,
    TResult? Function(List<File> files)? html,
  }) {
    return html?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
    required TResult orElse(),
  }) {
    if (html != null) {
      return html(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Video value) video,
    required TResult Function(Image value) image,
    required TResult Function(Model3D value) vr,
    required TResult Function(Audio value) audio,
    required TResult Function(Html value) html,
  }) {
    return html(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Video value)? video,
    TResult? Function(Image value)? image,
    TResult? Function(Model3D value)? vr,
    TResult? Function(Audio value)? audio,
    TResult? Function(Html value)? html,
  }) {
    return html?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
    required TResult orElse(),
  }) {
    if (html != null) {
      return html(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HtmlToJson(
      this,
    );
  }
}

abstract class Html implements Properties {
  const factory Html({required final List<File> files}) = _$Html;

  factory Html.fromJson(Map<String, dynamic> json) = _$Html.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  _$$HtmlCopyWith<_$Html> get copyWith => throw _privateConstructorUsedError;
}
