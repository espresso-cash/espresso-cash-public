// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'properties.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
class _$PropertiesTearOff {
  const _$PropertiesTearOff();

  Unknown unknown() {
    return const Unknown();
  }

  Video video({required List<File> files}) {
    return Video(
      files: files,
    );
  }

  Image image({required List<File> files}) {
    return Image(
      files: files,
    );
  }

  Model3D vr({required List<File> files}) {
    return Model3D(
      files: files,
    );
  }

  Audio audio({required List<File> files}) {
    return Audio(
      files: files,
    );
  }

  Html html({required List<File> files}) {
    return Html(
      files: files,
    );
  }

  Properties fromJson(Map<String, Object?> json) {
    return Properties.fromJson(json);
  }
}

/// @nodoc
const $Properties = _$PropertiesTearOff();

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
      _$PropertiesCopyWithImpl<$Res>;
}

/// @nodoc
class _$PropertiesCopyWithImpl<$Res> implements $PropertiesCopyWith<$Res> {
  _$PropertiesCopyWithImpl(this._value, this._then);

  final Properties _value;
  // ignore: unused_field
  final $Res Function(Properties) _then;
}

/// @nodoc
abstract class $UnknownCopyWith<$Res> {
  factory $UnknownCopyWith(Unknown value, $Res Function(Unknown) then) =
      _$UnknownCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnknownCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $UnknownCopyWith<$Res> {
  _$UnknownCopyWithImpl(Unknown _value, $Res Function(Unknown) _then)
      : super(_value, (v) => _then(v as Unknown));

  @override
  Unknown get _value => super._value as Unknown;
}

/// @nodoc
@JsonSerializable()
class _$Unknown implements Unknown {
  const _$Unknown({String? $type}) : $type = $type ?? 'unknown';

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
        (other.runtimeType == runtimeType && other is Unknown);
  }

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$UnknownToJson(this);
  }
}

abstract class Unknown implements Properties {
  const factory Unknown() = _$Unknown;

  factory Unknown.fromJson(Map<String, dynamic> json) = _$Unknown.fromJson;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res>;
  $Res call({List<File> files});
}

/// @nodoc
class _$VideoCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(Video _value, $Res Function(Video) _then)
      : super(_value, (v) => _then(v as Video));

  @override
  Video get _value => super._value as Video;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(Video(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Video implements Video {
  const _$Video({required this.files, String? $type})
      : $type = $type ?? 'video';

  factory _$Video.fromJson(Map<String, dynamic> json) => _$$VideoFromJson(json);

  @override
  final List<File> files;

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
            other is Video &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(files));

  @JsonKey(ignore: true)
  @override
  $VideoCopyWith<Video> get copyWith =>
      _$VideoCopyWithImpl<Video>(this, _$identity);

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$VideoToJson(this);
  }
}

abstract class Video implements Properties {
  const factory Video({required List<File> files}) = _$Video;

  factory Video.fromJson(Map<String, dynamic> json) = _$Video.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCopyWith<$Res> {
  factory $ImageCopyWith(Image value, $Res Function(Image) then) =
      _$ImageCopyWithImpl<$Res>;
  $Res call({List<File> files});
}

/// @nodoc
class _$ImageCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $ImageCopyWith<$Res> {
  _$ImageCopyWithImpl(Image _value, $Res Function(Image) _then)
      : super(_value, (v) => _then(v as Image));

  @override
  Image get _value => super._value as Image;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(Image(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Image implements Image {
  const _$Image({required this.files, String? $type})
      : $type = $type ?? 'image';

  factory _$Image.fromJson(Map<String, dynamic> json) => _$$ImageFromJson(json);

  @override
  final List<File> files;

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
            other is Image &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(files));

  @JsonKey(ignore: true)
  @override
  $ImageCopyWith<Image> get copyWith =>
      _$ImageCopyWithImpl<Image>(this, _$identity);

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$ImageToJson(this);
  }
}

abstract class Image implements Properties {
  const factory Image({required List<File> files}) = _$Image;

  factory Image.fromJson(Map<String, dynamic> json) = _$Image.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  $ImageCopyWith<Image> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Model3DCopyWith<$Res> {
  factory $Model3DCopyWith(Model3D value, $Res Function(Model3D) then) =
      _$Model3DCopyWithImpl<$Res>;
  $Res call({List<File> files});
}

/// @nodoc
class _$Model3DCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $Model3DCopyWith<$Res> {
  _$Model3DCopyWithImpl(Model3D _value, $Res Function(Model3D) _then)
      : super(_value, (v) => _then(v as Model3D));

  @override
  Model3D get _value => super._value as Model3D;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(Model3D(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Model3D implements Model3D {
  const _$Model3D({required this.files, String? $type}) : $type = $type ?? 'vr';

  factory _$Model3D.fromJson(Map<String, dynamic> json) =>
      _$$Model3DFromJson(json);

  @override
  final List<File> files;

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
            other is Model3D &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(files));

  @JsonKey(ignore: true)
  @override
  $Model3DCopyWith<Model3D> get copyWith =>
      _$Model3DCopyWithImpl<Model3D>(this, _$identity);

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$Model3DToJson(this);
  }
}

abstract class Model3D implements Properties {
  const factory Model3D({required List<File> files}) = _$Model3D;

  factory Model3D.fromJson(Map<String, dynamic> json) = _$Model3D.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  $Model3DCopyWith<Model3D> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioCopyWith<$Res> {
  factory $AudioCopyWith(Audio value, $Res Function(Audio) then) =
      _$AudioCopyWithImpl<$Res>;
  $Res call({List<File> files});
}

/// @nodoc
class _$AudioCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $AudioCopyWith<$Res> {
  _$AudioCopyWithImpl(Audio _value, $Res Function(Audio) _then)
      : super(_value, (v) => _then(v as Audio));

  @override
  Audio get _value => super._value as Audio;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(Audio(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Audio implements Audio {
  const _$Audio({required this.files, String? $type})
      : $type = $type ?? 'audio';

  factory _$Audio.fromJson(Map<String, dynamic> json) => _$$AudioFromJson(json);

  @override
  final List<File> files;

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
            other is Audio &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(files));

  @JsonKey(ignore: true)
  @override
  $AudioCopyWith<Audio> get copyWith =>
      _$AudioCopyWithImpl<Audio>(this, _$identity);

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$AudioToJson(this);
  }
}

abstract class Audio implements Properties {
  const factory Audio({required List<File> files}) = _$Audio;

  factory Audio.fromJson(Map<String, dynamic> json) = _$Audio.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  $AudioCopyWith<Audio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HtmlCopyWith<$Res> {
  factory $HtmlCopyWith(Html value, $Res Function(Html) then) =
      _$HtmlCopyWithImpl<$Res>;
  $Res call({List<File> files});
}

/// @nodoc
class _$HtmlCopyWithImpl<$Res> extends _$PropertiesCopyWithImpl<$Res>
    implements $HtmlCopyWith<$Res> {
  _$HtmlCopyWithImpl(Html _value, $Res Function(Html) _then)
      : super(_value, (v) => _then(v as Html));

  @override
  Html get _value => super._value as Html;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(Html(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Html implements Html {
  const _$Html({required this.files, String? $type}) : $type = $type ?? 'html';

  factory _$Html.fromJson(Map<String, dynamic> json) => _$$HtmlFromJson(json);

  @override
  final List<File> files;

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
            other is Html &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(files));

  @JsonKey(ignore: true)
  @override
  $HtmlCopyWith<Html> get copyWith =>
      _$HtmlCopyWithImpl<Html>(this, _$identity);

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
    TResult Function()? unknown,
    TResult Function(List<File> files)? video,
    TResult Function(List<File> files)? image,
    TResult Function(List<File> files)? vr,
    TResult Function(List<File> files)? audio,
    TResult Function(List<File> files)? html,
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
    TResult Function(Unknown value)? unknown,
    TResult Function(Video value)? video,
    TResult Function(Image value)? image,
    TResult Function(Model3D value)? vr,
    TResult Function(Audio value)? audio,
    TResult Function(Html value)? html,
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
    return _$$HtmlToJson(this);
  }
}

abstract class Html implements Properties {
  const factory Html({required List<File> files}) = _$Html;

  factory Html.fromJson(Map<String, dynamic> json) = _$Html.fromJson;

  List<File> get files;
  @JsonKey(ignore: true)
  $HtmlCopyWith<Html> get copyWith => throw _privateConstructorUsedError;
}
