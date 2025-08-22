import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';

const demoUrl = 'https://grpc-demo.espressocash.com';
const localUrl = 'http://localhost:8080';

Future<EspressoCashClient> createClient({bool local = false, Ed25519HDKeyPair? keyPair}) async {
  final kp = keyPair ?? await Ed25519HDKeyPair.random();

  return EspressoCashClient(
    baseUrl: local ? localUrl : demoUrl,
    sign: (message) async {
      final signedMessage = await kp.sign(message);

      return signedMessage.toBase58();
    },
    walletAddress: kp.address,
    onTokenUpdated: (_) async {},
  );
}

EspressoCashClient createAnonymousClient({bool local = false}) => EspressoCashClient.anonymous(
  baseUrl: local ? localUrl : demoUrl,
);
