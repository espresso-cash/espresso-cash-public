import 'package:solana/solana.dart';

const isProd = bool.fromEnvironment('PROD');

const espressoCashLinkDomain = 'pay.espressocash.com';
const espressoCashLinkProtocol = 'espressocash';

const termsUrl = 'https://espressocash.com/docs/legal/terms';
const privacyUrl = 'https://espressocash.com/docs/legal/privacy';

const playstoreName = 'com.pleasecrypto.flutter';
const appstoreId = '1559625715';

final mainnetUsdc = Ed25519HDPublicKey.fromBase58(
  'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
);
final devnetUsdc = Ed25519HDPublicKey.fromBase58(
  '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
);
