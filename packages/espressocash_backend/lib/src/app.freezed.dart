// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$App {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Uri get url => throw _privateConstructorUsedError;
  AppDisplayStyle get appDisplayStyle => throw _privateConstructorUsedError;
  AndroidOptions? get androidOptions => throw _privateConstructorUsedError;
  IOSOptions? get iOSOptions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppCopyWith<App> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppCopyWith<$Res> {
  factory $AppCopyWith(App value, $Res Function(App) then) =
      _$AppCopyWithImpl<$Res, App>;
  @useResult
  $Res call(
      {String id,
      String name,
      Uri url,
      AppDisplayStyle appDisplayStyle,
      AndroidOptions? androidOptions,
      IOSOptions? iOSOptions});

  $AppDisplayStyleCopyWith<$Res> get appDisplayStyle;
  $AndroidOptionsCopyWith<$Res>? get androidOptions;
  $IOSOptionsCopyWith<$Res>? get iOSOptions;
}

/// @nodoc
class _$AppCopyWithImpl<$Res, $Val extends App> implements $AppCopyWith<$Res> {
  _$AppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? appDisplayStyle = null,
    Object? androidOptions = freezed,
    Object? iOSOptions = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      appDisplayStyle: null == appDisplayStyle
          ? _value.appDisplayStyle
          : appDisplayStyle // ignore: cast_nullable_to_non_nullable
              as AppDisplayStyle,
      androidOptions: freezed == androidOptions
          ? _value.androidOptions
          : androidOptions // ignore: cast_nullable_to_non_nullable
              as AndroidOptions?,
      iOSOptions: freezed == iOSOptions
          ? _value.iOSOptions
          : iOSOptions // ignore: cast_nullable_to_non_nullable
              as IOSOptions?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppDisplayStyleCopyWith<$Res> get appDisplayStyle {
    return $AppDisplayStyleCopyWith<$Res>(_value.appDisplayStyle, (value) {
      return _then(_value.copyWith(appDisplayStyle: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AndroidOptionsCopyWith<$Res>? get androidOptions {
    if (_value.androidOptions == null) {
      return null;
    }

    return $AndroidOptionsCopyWith<$Res>(_value.androidOptions!, (value) {
      return _then(_value.copyWith(androidOptions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IOSOptionsCopyWith<$Res>? get iOSOptions {
    if (_value.iOSOptions == null) {
      return null;
    }

    return $IOSOptionsCopyWith<$Res>(_value.iOSOptions!, (value) {
      return _then(_value.copyWith(iOSOptions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory _$$_AppCopyWith(_$_App value, $Res Function(_$_App) then) =
      __$$_AppCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Uri url,
      AppDisplayStyle appDisplayStyle,
      AndroidOptions? androidOptions,
      IOSOptions? iOSOptions});

  @override
  $AppDisplayStyleCopyWith<$Res> get appDisplayStyle;
  @override
  $AndroidOptionsCopyWith<$Res>? get androidOptions;
  @override
  $IOSOptionsCopyWith<$Res>? get iOSOptions;
}

/// @nodoc
class __$$_AppCopyWithImpl<$Res> extends _$AppCopyWithImpl<$Res, _$_App>
    implements _$$_AppCopyWith<$Res> {
  __$$_AppCopyWithImpl(_$_App _value, $Res Function(_$_App) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? appDisplayStyle = null,
    Object? androidOptions = freezed,
    Object? iOSOptions = freezed,
  }) {
    return _then(_$_App(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      appDisplayStyle: null == appDisplayStyle
          ? _value.appDisplayStyle
          : appDisplayStyle // ignore: cast_nullable_to_non_nullable
              as AppDisplayStyle,
      androidOptions: freezed == androidOptions
          ? _value.androidOptions
          : androidOptions // ignore: cast_nullable_to_non_nullable
              as AndroidOptions?,
      iOSOptions: freezed == iOSOptions
          ? _value.iOSOptions
          : iOSOptions // ignore: cast_nullable_to_non_nullable
              as IOSOptions?,
    ));
  }
}

/// @nodoc

class _$_App implements _App {
  const _$_App(
      {required this.id,
      required this.name,
      required this.url,
      required this.appDisplayStyle,
      this.androidOptions,
      this.iOSOptions});

  @override
  final String id;
  @override
  final String name;
  @override
  final Uri url;
  @override
  final AppDisplayStyle appDisplayStyle;
  @override
  final AndroidOptions? androidOptions;
  @override
  final IOSOptions? iOSOptions;

  @override
  String toString() {
    return 'App(id: $id, name: $name, url: $url, appDisplayStyle: $appDisplayStyle, androidOptions: $androidOptions, iOSOptions: $iOSOptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_App &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.appDisplayStyle, appDisplayStyle) ||
                other.appDisplayStyle == appDisplayStyle) &&
            (identical(other.androidOptions, androidOptions) ||
                other.androidOptions == androidOptions) &&
            (identical(other.iOSOptions, iOSOptions) ||
                other.iOSOptions == iOSOptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, url, appDisplayStyle, androidOptions, iOSOptions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppCopyWith<_$_App> get copyWith =>
      __$$_AppCopyWithImpl<_$_App>(this, _$identity);
}

abstract class _App implements App {
  const factory _App(
      {required final String id,
      required final String name,
      required final Uri url,
      required final AppDisplayStyle appDisplayStyle,
      final AndroidOptions? androidOptions,
      final IOSOptions? iOSOptions}) = _$_App;

  @override
  String get id;
  @override
  String get name;
  @override
  Uri get url;
  @override
  AppDisplayStyle get appDisplayStyle;
  @override
  AndroidOptions? get androidOptions;
  @override
  IOSOptions? get iOSOptions;
  @override
  @JsonKey(ignore: true)
  _$$_AppCopyWith<_$_App> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppDisplayStyle {
  String get textColor => throw _privateConstructorUsedError;
  String get backgroundColor => throw _privateConstructorUsedError;
  String get logoUri => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppDisplayStyleCopyWith<AppDisplayStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDisplayStyleCopyWith<$Res> {
  factory $AppDisplayStyleCopyWith(
          AppDisplayStyle value, $Res Function(AppDisplayStyle) then) =
      _$AppDisplayStyleCopyWithImpl<$Res, AppDisplayStyle>;
  @useResult
  $Res call({String textColor, String backgroundColor, String logoUri});
}

/// @nodoc
class _$AppDisplayStyleCopyWithImpl<$Res, $Val extends AppDisplayStyle>
    implements $AppDisplayStyleCopyWith<$Res> {
  _$AppDisplayStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textColor = null,
    Object? backgroundColor = null,
    Object? logoUri = null,
  }) {
    return _then(_value.copyWith(
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppDisplayStyleCopyWith<$Res>
    implements $AppDisplayStyleCopyWith<$Res> {
  factory _$$_AppDisplayStyleCopyWith(
          _$_AppDisplayStyle value, $Res Function(_$_AppDisplayStyle) then) =
      __$$_AppDisplayStyleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String textColor, String backgroundColor, String logoUri});
}

/// @nodoc
class __$$_AppDisplayStyleCopyWithImpl<$Res>
    extends _$AppDisplayStyleCopyWithImpl<$Res, _$_AppDisplayStyle>
    implements _$$_AppDisplayStyleCopyWith<$Res> {
  __$$_AppDisplayStyleCopyWithImpl(
      _$_AppDisplayStyle _value, $Res Function(_$_AppDisplayStyle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textColor = null,
    Object? backgroundColor = null,
    Object? logoUri = null,
  }) {
    return _then(_$_AppDisplayStyle(
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppDisplayStyle implements _AppDisplayStyle {
  const _$_AppDisplayStyle(
      {required this.textColor,
      required this.backgroundColor,
      required this.logoUri});

  @override
  final String textColor;
  @override
  final String backgroundColor;
  @override
  final String logoUri;

  @override
  String toString() {
    return 'AppDisplayStyle(textColor: $textColor, backgroundColor: $backgroundColor, logoUri: $logoUri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppDisplayStyle &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.logoUri, logoUri) || other.logoUri == logoUri));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textColor, backgroundColor, logoUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppDisplayStyleCopyWith<_$_AppDisplayStyle> get copyWith =>
      __$$_AppDisplayStyleCopyWithImpl<_$_AppDisplayStyle>(this, _$identity);
}

abstract class _AppDisplayStyle implements AppDisplayStyle {
  const factory _AppDisplayStyle(
      {required final String textColor,
      required final String backgroundColor,
      required final String logoUri}) = _$_AppDisplayStyle;

  @override
  String get textColor;
  @override
  String get backgroundColor;
  @override
  String get logoUri;
  @override
  @JsonKey(ignore: true)
  _$$_AppDisplayStyleCopyWith<_$_AppDisplayStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AndroidOptions {
  String get package => throw _privateConstructorUsedError;
  List<String> get sha256Fingerprints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AndroidOptionsCopyWith<AndroidOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidOptionsCopyWith<$Res> {
  factory $AndroidOptionsCopyWith(
          AndroidOptions value, $Res Function(AndroidOptions) then) =
      _$AndroidOptionsCopyWithImpl<$Res, AndroidOptions>;
  @useResult
  $Res call({String package, List<String> sha256Fingerprints});
}

/// @nodoc
class _$AndroidOptionsCopyWithImpl<$Res, $Val extends AndroidOptions>
    implements $AndroidOptionsCopyWith<$Res> {
  _$AndroidOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = null,
    Object? sha256Fingerprints = null,
  }) {
    return _then(_value.copyWith(
      package: null == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      sha256Fingerprints: null == sha256Fingerprints
          ? _value.sha256Fingerprints
          : sha256Fingerprints // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AndroidOptionsCopyWith<$Res>
    implements $AndroidOptionsCopyWith<$Res> {
  factory _$$_AndroidOptionsCopyWith(
          _$_AndroidOptions value, $Res Function(_$_AndroidOptions) then) =
      __$$_AndroidOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String package, List<String> sha256Fingerprints});
}

/// @nodoc
class __$$_AndroidOptionsCopyWithImpl<$Res>
    extends _$AndroidOptionsCopyWithImpl<$Res, _$_AndroidOptions>
    implements _$$_AndroidOptionsCopyWith<$Res> {
  __$$_AndroidOptionsCopyWithImpl(
      _$_AndroidOptions _value, $Res Function(_$_AndroidOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = null,
    Object? sha256Fingerprints = null,
  }) {
    return _then(_$_AndroidOptions(
      package: null == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      sha256Fingerprints: null == sha256Fingerprints
          ? _value._sha256Fingerprints
          : sha256Fingerprints // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_AndroidOptions implements _AndroidOptions {
  const _$_AndroidOptions(
      {required this.package, required final List<String> sha256Fingerprints})
      : _sha256Fingerprints = sha256Fingerprints;

  @override
  final String package;
  final List<String> _sha256Fingerprints;
  @override
  List<String> get sha256Fingerprints {
    if (_sha256Fingerprints is EqualUnmodifiableListView)
      return _sha256Fingerprints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sha256Fingerprints);
  }

  @override
  String toString() {
    return 'AndroidOptions(package: $package, sha256Fingerprints: $sha256Fingerprints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AndroidOptions &&
            (identical(other.package, package) || other.package == package) &&
            const DeepCollectionEquality()
                .equals(other._sha256Fingerprints, _sha256Fingerprints));
  }

  @override
  int get hashCode => Object.hash(runtimeType, package,
      const DeepCollectionEquality().hash(_sha256Fingerprints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AndroidOptionsCopyWith<_$_AndroidOptions> get copyWith =>
      __$$_AndroidOptionsCopyWithImpl<_$_AndroidOptions>(this, _$identity);
}

abstract class _AndroidOptions implements AndroidOptions {
  const factory _AndroidOptions(
      {required final String package,
      required final List<String> sha256Fingerprints}) = _$_AndroidOptions;

  @override
  String get package;
  @override
  List<String> get sha256Fingerprints;
  @override
  @JsonKey(ignore: true)
  _$$_AndroidOptionsCopyWith<_$_AndroidOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IOSOptions {
  String get appStoreId => throw _privateConstructorUsedError;
  String get bundleId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IOSOptionsCopyWith<IOSOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOSOptionsCopyWith<$Res> {
  factory $IOSOptionsCopyWith(
          IOSOptions value, $Res Function(IOSOptions) then) =
      _$IOSOptionsCopyWithImpl<$Res, IOSOptions>;
  @useResult
  $Res call({String appStoreId, String bundleId, String teamId});
}

/// @nodoc
class _$IOSOptionsCopyWithImpl<$Res, $Val extends IOSOptions>
    implements $IOSOptionsCopyWith<$Res> {
  _$IOSOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appStoreId = null,
    Object? bundleId = null,
    Object? teamId = null,
  }) {
    return _then(_value.copyWith(
      appStoreId: null == appStoreId
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String,
      bundleId: null == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IOSOptionsCopyWith<$Res>
    implements $IOSOptionsCopyWith<$Res> {
  factory _$$_IOSOptionsCopyWith(
          _$_IOSOptions value, $Res Function(_$_IOSOptions) then) =
      __$$_IOSOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appStoreId, String bundleId, String teamId});
}

/// @nodoc
class __$$_IOSOptionsCopyWithImpl<$Res>
    extends _$IOSOptionsCopyWithImpl<$Res, _$_IOSOptions>
    implements _$$_IOSOptionsCopyWith<$Res> {
  __$$_IOSOptionsCopyWithImpl(
      _$_IOSOptions _value, $Res Function(_$_IOSOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appStoreId = null,
    Object? bundleId = null,
    Object? teamId = null,
  }) {
    return _then(_$_IOSOptions(
      appStoreId: null == appStoreId
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String,
      bundleId: null == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_IOSOptions implements _IOSOptions {
  const _$_IOSOptions(
      {required this.appStoreId, required this.bundleId, required this.teamId});

  @override
  final String appStoreId;
  @override
  final String bundleId;
  @override
  final String teamId;

  @override
  String toString() {
    return 'IOSOptions(appStoreId: $appStoreId, bundleId: $bundleId, teamId: $teamId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IOSOptions &&
            (identical(other.appStoreId, appStoreId) ||
                other.appStoreId == appStoreId) &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appStoreId, bundleId, teamId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IOSOptionsCopyWith<_$_IOSOptions> get copyWith =>
      __$$_IOSOptionsCopyWithImpl<_$_IOSOptions>(this, _$identity);
}

abstract class _IOSOptions implements IOSOptions {
  const factory _IOSOptions(
      {required final String appStoreId,
      required final String bundleId,
      required final String teamId}) = _$_IOSOptions;

  @override
  String get appStoreId;
  @override
  String get bundleId;
  @override
  String get teamId;
  @override
  @JsonKey(ignore: true)
  _$$_IOSOptionsCopyWith<_$_IOSOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
