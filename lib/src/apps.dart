import 'package:cryptoplease_link/src/app.dart';

final cryptoPleaseApp = App(
  id: 'cp',
  name: 'Crypto Please',
  url: Uri.parse('https://cryptoplease.com'),
  androidOptions: const AndroidOptions(
    package: 'com.pleasecrypto.flutter',
    sha256Fingerprints: [
      '4F:CF:06:20:AF:A6:B1:23:07:73:75:8B:68:AE:38:24:03:80:FD:00:29:E2:91:D0:7F:A8:83:02:59:D8:EF:6F',
      'AE:7F:14:33:60:90:35:C0:AF:20:BB:52:6B:44:CC:12:31:C2:5A:EE:1A:99:06:3D:B4:25:9B:04:52:FE:53:A1',
      'BE:5F:4F:8D:F8:79:EC:85:53:E0:3E:14:AC:7A:07:A8:E3:BB:68:D4:89:DA:F6:30:78:25:1F:01:A0:BA:32:D2',
    ],
  ),
  iOSOptions: const IOSOptions(
    appStoreId: '1559625715',
    bundleId: 'com.pleasecrypto.flutter',
    teamId: 'US38KFXH3P',
  ),
  appDisplayStyle: const AppDisplayStyle(
    textColor: '#000000',
    backgroundColor: '#FACF48',
    logoUri: 'icons/cp-icon.png',
  ),
);

final apps = [
  cryptoPleaseApp,
];
