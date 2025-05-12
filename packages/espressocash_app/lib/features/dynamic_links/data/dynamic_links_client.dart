import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DynamicLinkClient {
  const DynamicLinkClient();

  Future<Uri> unshortenLink(Uri shortLink) async {
    final client = EspressoCashClient.anonymous();

    final response = await client.expandLink(
      UnshortenLinkRequestDto(shortLink: shortLink.toString()),
    );

    return Uri.parse(response.fullLink);
  }
}
