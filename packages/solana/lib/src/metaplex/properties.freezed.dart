// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'properties.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
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
  /// Serializes this Properties to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is Properties);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Properties()';
  }
}

/// @nodoc
class $PropertiesCopyWith<$Res> {
  $PropertiesCopyWith(Properties _, $Res Function(Properties) __);
}

/// @nodoc
@JsonSerializable()
class Unknown implements Properties {
  const Unknown({final String? $type}) : $type = $type ?? 'unknown';
  factory Unknown.fromJson(Map<String, dynamic> json) => _$UnknownFromJson(json);

  @JsonKey(name: 'category')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$UnknownToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is Unknown);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Properties.unknown()';
  }
}

/// @nodoc
@JsonSerializable()
class Video implements Properties {
  const Video({required final List<File> files, final String? $type})
    : _files = files,
      $type = $type ?? 'video';
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VideoCopyWith<Video> get copyWith => _$VideoCopyWithImpl<Video>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VideoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Video &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'Properties.video(files: $files)';
  }
}

/// @nodoc
abstract mixin class $VideoCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) _then) = _$VideoCopyWithImpl;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class _$VideoCopyWithImpl<$Res> implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._self, this._then);

  final Video _self;
  final $Res Function(Video) _then;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null}) {
    return _then(
      Video(
        files:
            null == files
                ? _self._files
                : files // ignore: cast_nullable_to_non_nullable
                    as List<File>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class Image implements Properties {
  const Image({required final List<File> files, final String? $type})
    : _files = files,
      $type = $type ?? 'image';
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageCopyWith<Image> get copyWith => _$ImageCopyWithImpl<Image>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Image &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'Properties.image(files: $files)';
  }
}

/// @nodoc
abstract mixin class $ImageCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory $ImageCopyWith(Image value, $Res Function(Image) _then) = _$ImageCopyWithImpl;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class _$ImageCopyWithImpl<$Res> implements $ImageCopyWith<$Res> {
  _$ImageCopyWithImpl(this._self, this._then);

  final Image _self;
  final $Res Function(Image) _then;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null}) {
    return _then(
      Image(
        files:
            null == files
                ? _self._files
                : files // ignore: cast_nullable_to_non_nullable
                    as List<File>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class Model3D implements Properties {
  const Model3D({required final List<File> files, final String? $type})
    : _files = files,
      $type = $type ?? 'vr';
  factory Model3D.fromJson(Map<String, dynamic> json) => _$Model3DFromJson(json);

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Model3DCopyWith<Model3D> get copyWith => _$Model3DCopyWithImpl<Model3D>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$Model3DToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Model3D &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'Properties.vr(files: $files)';
  }
}

/// @nodoc
abstract mixin class $Model3DCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory $Model3DCopyWith(Model3D value, $Res Function(Model3D) _then) = _$Model3DCopyWithImpl;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class _$Model3DCopyWithImpl<$Res> implements $Model3DCopyWith<$Res> {
  _$Model3DCopyWithImpl(this._self, this._then);

  final Model3D _self;
  final $Res Function(Model3D) _then;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null}) {
    return _then(
      Model3D(
        files:
            null == files
                ? _self._files
                : files // ignore: cast_nullable_to_non_nullable
                    as List<File>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class Audio implements Properties {
  const Audio({required final List<File> files, final String? $type})
    : _files = files,
      $type = $type ?? 'audio';
  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AudioCopyWith<Audio> get copyWith => _$AudioCopyWithImpl<Audio>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AudioToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Audio &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'Properties.audio(files: $files)';
  }
}

/// @nodoc
abstract mixin class $AudioCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory $AudioCopyWith(Audio value, $Res Function(Audio) _then) = _$AudioCopyWithImpl;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class _$AudioCopyWithImpl<$Res> implements $AudioCopyWith<$Res> {
  _$AudioCopyWithImpl(this._self, this._then);

  final Audio _self;
  final $Res Function(Audio) _then;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null}) {
    return _then(
      Audio(
        files:
            null == files
                ? _self._files
                : files // ignore: cast_nullable_to_non_nullable
                    as List<File>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class Html implements Properties {
  const Html({required final List<File> files, final String? $type})
    : _files = files,
      $type = $type ?? 'html';
  factory Html.fromJson(Map<String, dynamic> json) => _$HtmlFromJson(json);

  final List<File> _files;
  List<File> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'category')
  final String $type;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HtmlCopyWith<Html> get copyWith => _$HtmlCopyWithImpl<Html>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HtmlToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Html &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'Properties.html(files: $files)';
  }
}

/// @nodoc
abstract mixin class $HtmlCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory $HtmlCopyWith(Html value, $Res Function(Html) _then) = _$HtmlCopyWithImpl;
  @useResult
  $Res call({List<File> files});
}

/// @nodoc
class _$HtmlCopyWithImpl<$Res> implements $HtmlCopyWith<$Res> {
  _$HtmlCopyWithImpl(this._self, this._then);

  final Html _self;
  final $Res Function(Html) _then;

  /// Create a copy of Properties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? files = null}) {
    return _then(
      Html(
        files:
            null == files
                ? _self._files
                : files // ignore: cast_nullable_to_non_nullable
                    as List<File>,
      ),
    );
  }
}
