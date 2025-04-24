import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DynamicLinkClient {
  const DynamicLinkClient();

  Future<Uri> unshortenLink(Uri shortLink) async {
    //TODO
    final client = await EspressoCashClient.create(
      baseUrl: 'grpc-demo.espressocash.com',
      walletAddress: '',
      sign: (_) async => '',
    );

    final response = await client.expandLink(
      UnshortenLinkRequestDto(shortLink: shortLink.toString()),
    );

    return Uri.parse(response.fullLink);
  }
}
