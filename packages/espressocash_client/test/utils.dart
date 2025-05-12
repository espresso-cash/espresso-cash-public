import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';

const demoUrl = 'grpc-demo.espressocash.com';
const localUrl = 'localhost';

Future<EspressoCashClient> createClient({bool local = false, Ed25519HDKeyPair? keyPair}) async {
  final kp = keyPair ?? await Ed25519HDKeyPair.random();

  return EspressoCashClient(
    baseUrl: local ? localUrl : demoUrl,
    port: local ? 8080 : 443,
    sign: (message) async {
      final signedMessage = await kp.sign(message);

      return signedMessage.toBase58();
    },
    walletAddress: kp.address,
    secure: !local,
    onTokenUpdated: (_) async {},
  );
}

EspressoCashClient createAnonymousClient({bool local = false}) => EspressoCashClient.anonymous(
  baseUrl: local ? localUrl : demoUrl,
  port: local ? 8080 : 443,
  secure: !local,
);
