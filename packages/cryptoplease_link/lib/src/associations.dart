import 'package:cryptoplease_link/src/app.dart';

List<Map<String, dynamic>> getAssetLinks(Iterable<AndroidOptions> apps) => apps
    .map(
      (app) => <String, dynamic>{
        'relation': ['delegate_permission/common.handle_all_urls'],
        'target': {
          'namespace': 'android_app',
          'package_name': app.package,
          'sha256_cert_fingerprints': app.sha256Fingerprints,
        }
      },
    )
    .toList();

Map<String, dynamic> getAppAssociations(Iterable<IOSOptions> apps) =>
    <String, dynamic>{
      'applinks': {
        'apps': <dynamic>[],
        'details': apps
            .map(
              (app) => {
                'appID': '${app.teamId}.${app.bundleId}',
                'paths': ['NOT /_/*', '/*'],
              },
            )
            .toList(),
      }
    };
