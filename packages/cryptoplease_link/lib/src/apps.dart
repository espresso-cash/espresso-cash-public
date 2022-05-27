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

final phantomApp = App(
  id: 'phantom',
  name: 'Phantom',
  url: Uri.parse('https://phantom.app/'),
  androidOptions: const AndroidOptions(
    package: 'app.phantom',
    sha256Fingerprints: [
      '5D:08:00:89:DF:53:7F:0D:42:46:DB:6C:8E:3E:F0:7C:72:2C:A3:B4:47:20:73:6A:40:EA:0C:90:C4:AF:9A:0B'
    ],
  ),
  iOSOptions: const IOSOptions(
    appStoreId: '1598432977',
    bundleId: 'app.phantom',
    // TODO(rhbrunetto): missing teamId
    teamId: '',
  ),
  appDisplayStyle: const AppDisplayStyle(
    textColor: '#FFFFFF',
    backgroundColor: '#7A72F1',
    logoUri: 'icons/phantom-icon.png',
  ),
);

final solflareApp = App(
  id: 'solflare',
  name: 'Solflare',
  url: Uri.parse('https://solflare.com/'),
  androidOptions: const AndroidOptions(
    package: 'com.solflare.mobile',
    sha256Fingerprints: [
      'F5:83:3A:28:10:6F:09:D7:69:6F:39:E8:AE:D4:B6:08:72:6A:DB:CC:13:76:A4:6C:E8:05:F2:2A:CD:1E:A0:CB'
    ],
  ),
  iOSOptions: const IOSOptions(
    appStoreId: '1580902717',
    bundleId: 'com.solflare.mobile',
    // TODO(rhbrunetto): missing teamId
    teamId: '',
  ),
  appDisplayStyle: const AppDisplayStyle(
    textColor: '#FFFFFF',
    backgroundColor: '#FC6922',
    logoUri: 'icons/solflare-icon.png',
  ),
);

final apps = [
  cryptoPleaseApp,
  phantomApp,
  solflareApp,
];
