import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class DynamicLinkClient {
  DynamicLinkClient();

  final EspressoCashClient _ecClient = EspressoCashClient(
    sign: (data) async => null,
  );

  Future<Uri> unshortenLink(Uri shortLink) => _ecClient
      .unshortenLink(UnshortenLinkRequestDto(shortLink: shortLink.toString()))
      .then((e) => Uri.parse(e.fullLink));
}
