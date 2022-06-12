// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$AppCopyWithImpl<$Res>;
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
class _$AppCopyWithImpl<$Res> implements $AppCopyWith<$Res> {
  _$AppCopyWithImpl(this._value, this._then);

  final App _value;
  // ignore: unused_field
  final $Res Function(App) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? appDisplayStyle = freezed,
    Object? androidOptions = freezed,
    Object? iOSOptions = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      appDisplayStyle: appDisplayStyle == freezed
          ? _value.appDisplayStyle
          : appDisplayStyle // ignore: cast_nullable_to_non_nullable
              as AppDisplayStyle,
      androidOptions: androidOptions == freezed
          ? _value.androidOptions
          : androidOptions // ignore: cast_nullable_to_non_nullable
              as AndroidOptions?,
      iOSOptions: iOSOptions == freezed
          ? _value.iOSOptions
          : iOSOptions // ignore: cast_nullable_to_non_nullable
              as IOSOptions?,
    ));
  }

  @override
  $AppDisplayStyleCopyWith<$Res> get appDisplayStyle {
    return $AppDisplayStyleCopyWith<$Res>(_value.appDisplayStyle, (value) {
      return _then(_value.copyWith(appDisplayStyle: value));
    });
  }

  @override
  $AndroidOptionsCopyWith<$Res>? get androidOptions {
    if (_value.androidOptions == null) {
      return null;
    }

    return $AndroidOptionsCopyWith<$Res>(_value.androidOptions!, (value) {
      return _then(_value.copyWith(androidOptions: value));
    });
  }

  @override
  $IOSOptionsCopyWith<$Res>? get iOSOptions {
    if (_value.iOSOptions == null) {
      return null;
    }

    return $IOSOptionsCopyWith<$Res>(_value.iOSOptions!, (value) {
      return _then(_value.copyWith(iOSOptions: value));
    });
  }
}

/// @nodoc
abstract class _$AppCopyWith<$Res> implements $AppCopyWith<$Res> {
  factory _$AppCopyWith(_App value, $Res Function(_App) then) =
      __$AppCopyWithImpl<$Res>;
  @override
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
class __$AppCopyWithImpl<$Res> extends _$AppCopyWithImpl<$Res>
    implements _$AppCopyWith<$Res> {
  __$AppCopyWithImpl(_App _value, $Res Function(_App) _then)
      : super(_value, (v) => _then(v as _App));

  @override
  _App get _value => super._value as _App;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? appDisplayStyle = freezed,
    Object? androidOptions = freezed,
    Object? iOSOptions = freezed,
  }) {
    return _then(_App(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      appDisplayStyle: appDisplayStyle == freezed
          ? _value.appDisplayStyle
          : appDisplayStyle // ignore: cast_nullable_to_non_nullable
              as AppDisplayStyle,
      androidOptions: androidOptions == freezed
          ? _value.androidOptions
          : androidOptions // ignore: cast_nullable_to_non_nullable
              as AndroidOptions?,
      iOSOptions: iOSOptions == freezed
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
            other is _App &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.appDisplayStyle, appDisplayStyle) &&
            const DeepCollectionEquality()
                .equals(other.androidOptions, androidOptions) &&
            const DeepCollectionEquality()
                .equals(other.iOSOptions, iOSOptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(appDisplayStyle),
      const DeepCollectionEquality().hash(androidOptions),
      const DeepCollectionEquality().hash(iOSOptions));

  @JsonKey(ignore: true)
  @override
  _$AppCopyWith<_App> get copyWith =>
      __$AppCopyWithImpl<_App>(this, _$identity);
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
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  Uri get url => throw _privateConstructorUsedError;
  @override
  AppDisplayStyle get appDisplayStyle => throw _privateConstructorUsedError;
  @override
  AndroidOptions? get androidOptions => throw _privateConstructorUsedError;
  @override
  IOSOptions? get iOSOptions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppCopyWith<_App> get copyWith => throw _privateConstructorUsedError;
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
      _$AppDisplayStyleCopyWithImpl<$Res>;
  $Res call({String textColor, String backgroundColor, String logoUri});
}

/// @nodoc
class _$AppDisplayStyleCopyWithImpl<$Res>
    implements $AppDisplayStyleCopyWith<$Res> {
  _$AppDisplayStyleCopyWithImpl(this._value, this._then);

  final AppDisplayStyle _value;
  // ignore: unused_field
  final $Res Function(AppDisplayStyle) _then;

  @override
  $Res call({
    Object? textColor = freezed,
    Object? backgroundColor = freezed,
    Object? logoUri = freezed,
  }) {
    return _then(_value.copyWith(
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUri: logoUri == freezed
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AppDisplayStyleCopyWith<$Res>
    implements $AppDisplayStyleCopyWith<$Res> {
  factory _$AppDisplayStyleCopyWith(
          _AppDisplayStyle value, $Res Function(_AppDisplayStyle) then) =
      __$AppDisplayStyleCopyWithImpl<$Res>;
  @override
  $Res call({String textColor, String backgroundColor, String logoUri});
}

/// @nodoc
class __$AppDisplayStyleCopyWithImpl<$Res>
    extends _$AppDisplayStyleCopyWithImpl<$Res>
    implements _$AppDisplayStyleCopyWith<$Res> {
  __$AppDisplayStyleCopyWithImpl(
      _AppDisplayStyle _value, $Res Function(_AppDisplayStyle) _then)
      : super(_value, (v) => _then(v as _AppDisplayStyle));

  @override
  _AppDisplayStyle get _value => super._value as _AppDisplayStyle;

  @override
  $Res call({
    Object? textColor = freezed,
    Object? backgroundColor = freezed,
    Object? logoUri = freezed,
  }) {
    return _then(_AppDisplayStyle(
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUri: logoUri == freezed
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
            other is _AppDisplayStyle &&
            const DeepCollectionEquality().equals(other.textColor, textColor) &&
            const DeepCollectionEquality()
                .equals(other.backgroundColor, backgroundColor) &&
            const DeepCollectionEquality().equals(other.logoUri, logoUri));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textColor),
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(logoUri));

  @JsonKey(ignore: true)
  @override
  _$AppDisplayStyleCopyWith<_AppDisplayStyle> get copyWith =>
      __$AppDisplayStyleCopyWithImpl<_AppDisplayStyle>(this, _$identity);
}

abstract class _AppDisplayStyle implements AppDisplayStyle {
  const factory _AppDisplayStyle(
      {required final String textColor,
      required final String backgroundColor,
      required final String logoUri}) = _$_AppDisplayStyle;

  @override
  String get textColor => throw _privateConstructorUsedError;
  @override
  String get backgroundColor => throw _privateConstructorUsedError;
  @override
  String get logoUri => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppDisplayStyleCopyWith<_AppDisplayStyle> get copyWith =>
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
      _$AndroidOptionsCopyWithImpl<$Res>;
  $Res call({String package, List<String> sha256Fingerprints});
}

/// @nodoc
class _$AndroidOptionsCopyWithImpl<$Res>
    implements $AndroidOptionsCopyWith<$Res> {
  _$AndroidOptionsCopyWithImpl(this._value, this._then);

  final AndroidOptions _value;
  // ignore: unused_field
  final $Res Function(AndroidOptions) _then;

  @override
  $Res call({
    Object? package = freezed,
    Object? sha256Fingerprints = freezed,
  }) {
    return _then(_value.copyWith(
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      sha256Fingerprints: sha256Fingerprints == freezed
          ? _value.sha256Fingerprints
          : sha256Fingerprints // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$AndroidOptionsCopyWith<$Res>
    implements $AndroidOptionsCopyWith<$Res> {
  factory _$AndroidOptionsCopyWith(
          _AndroidOptions value, $Res Function(_AndroidOptions) then) =
      __$AndroidOptionsCopyWithImpl<$Res>;
  @override
  $Res call({String package, List<String> sha256Fingerprints});
}

/// @nodoc
class __$AndroidOptionsCopyWithImpl<$Res>
    extends _$AndroidOptionsCopyWithImpl<$Res>
    implements _$AndroidOptionsCopyWith<$Res> {
  __$AndroidOptionsCopyWithImpl(
      _AndroidOptions _value, $Res Function(_AndroidOptions) _then)
      : super(_value, (v) => _then(v as _AndroidOptions));

  @override
  _AndroidOptions get _value => super._value as _AndroidOptions;

  @override
  $Res call({
    Object? package = freezed,
    Object? sha256Fingerprints = freezed,
  }) {
    return _then(_AndroidOptions(
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      sha256Fingerprints: sha256Fingerprints == freezed
          ? _value.sha256Fingerprints
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
            other is _AndroidOptions &&
            const DeepCollectionEquality().equals(other.package, package) &&
            const DeepCollectionEquality()
                .equals(other.sha256Fingerprints, sha256Fingerprints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(package),
      const DeepCollectionEquality().hash(sha256Fingerprints));

  @JsonKey(ignore: true)
  @override
  _$AndroidOptionsCopyWith<_AndroidOptions> get copyWith =>
      __$AndroidOptionsCopyWithImpl<_AndroidOptions>(this, _$identity);
}

abstract class _AndroidOptions implements AndroidOptions {
  const factory _AndroidOptions(
      {required final String package,
      required final List<String> sha256Fingerprints}) = _$_AndroidOptions;

  @override
  String get package => throw _privateConstructorUsedError;
  @override
  List<String> get sha256Fingerprints => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AndroidOptionsCopyWith<_AndroidOptions> get copyWith =>
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
      _$IOSOptionsCopyWithImpl<$Res>;
  $Res call({String appStoreId, String bundleId, String teamId});
}

/// @nodoc
class _$IOSOptionsCopyWithImpl<$Res> implements $IOSOptionsCopyWith<$Res> {
  _$IOSOptionsCopyWithImpl(this._value, this._then);

  final IOSOptions _value;
  // ignore: unused_field
  final $Res Function(IOSOptions) _then;

  @override
  $Res call({
    Object? appStoreId = freezed,
    Object? bundleId = freezed,
    Object? teamId = freezed,
  }) {
    return _then(_value.copyWith(
      appStoreId: appStoreId == freezed
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String,
      bundleId: bundleId == freezed
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: teamId == freezed
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$IOSOptionsCopyWith<$Res> implements $IOSOptionsCopyWith<$Res> {
  factory _$IOSOptionsCopyWith(
          _IOSOptions value, $Res Function(_IOSOptions) then) =
      __$IOSOptionsCopyWithImpl<$Res>;
  @override
  $Res call({String appStoreId, String bundleId, String teamId});
}

/// @nodoc
class __$IOSOptionsCopyWithImpl<$Res> extends _$IOSOptionsCopyWithImpl<$Res>
    implements _$IOSOptionsCopyWith<$Res> {
  __$IOSOptionsCopyWithImpl(
      _IOSOptions _value, $Res Function(_IOSOptions) _then)
      : super(_value, (v) => _then(v as _IOSOptions));

  @override
  _IOSOptions get _value => super._value as _IOSOptions;

  @override
  $Res call({
    Object? appStoreId = freezed,
    Object? bundleId = freezed,
    Object? teamId = freezed,
  }) {
    return _then(_IOSOptions(
      appStoreId: appStoreId == freezed
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String,
      bundleId: bundleId == freezed
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: teamId == freezed
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
            other is _IOSOptions &&
            const DeepCollectionEquality()
                .equals(other.appStoreId, appStoreId) &&
            const DeepCollectionEquality().equals(other.bundleId, bundleId) &&
            const DeepCollectionEquality().equals(other.teamId, teamId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appStoreId),
      const DeepCollectionEquality().hash(bundleId),
      const DeepCollectionEquality().hash(teamId));

  @JsonKey(ignore: true)
  @override
  _$IOSOptionsCopyWith<_IOSOptions> get copyWith =>
      __$IOSOptionsCopyWithImpl<_IOSOptions>(this, _$identity);
}

abstract class _IOSOptions implements IOSOptions {
  const factory _IOSOptions(
      {required final String appStoreId,
      required final String bundleId,
      required final String teamId}) = _$_IOSOptions;

  @override
  String get appStoreId => throw _privateConstructorUsedError;
  @override
  String get bundleId => throw _privateConstructorUsedError;
  @override
  String get teamId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IOSOptionsCopyWith<_IOSOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
