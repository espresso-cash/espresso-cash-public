import 'package:freezed_annotation/freezed_annotation.dart';

part 'app.freezed.dart';

@freezed
class App with _$App {
  const factory App({
    required String id,
    required String name,
    required Uri url,
    AndroidOptions? androidOptions,
    IOSOptions? iOSOptions,
  }) = _App;
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
