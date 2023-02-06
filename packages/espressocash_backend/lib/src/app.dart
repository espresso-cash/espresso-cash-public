import 'package:freezed_annotation/freezed_annotation.dart';

part 'app.freezed.dart';

@freezed
class App with _$App {
  const factory App({
    required String id,
    required String name,
    required Uri url,
    required AppDisplayStyle appDisplayStyle,
    AndroidOptions? androidOptions,
    IOSOptions? iOSOptions,
  }) = _App;
}

@freezed
class AppDisplayStyle with _$AppDisplayStyle {
  const factory AppDisplayStyle({
    required String textColor,
    required String backgroundColor,
    required String logoUri,
  }) = _AppDisplayStyle;
}

@freezed
class AndroidOptions with _$AndroidOptions {
  const factory AndroidOptions({
    required String package,
    required List<String> sha256Fingerprints,
  }) = _AndroidOptions;
}

@freezed
class IOSOptions with _$IOSOptions {
  const factory IOSOptions({
    required String appStoreId,
    required String bundleId,
    required String teamId,
  }) = _IOSOptions;
}
