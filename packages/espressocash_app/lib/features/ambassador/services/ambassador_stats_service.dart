import 'package:async/async.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class AmbassadorStatsService {
  AmbassadorStatsService(this._client);

  final EspressoCashClient _client;

  final _cache = AsyncCache<int>(const Duration(minutes: 5));

  Future<int> fetchStats() => _cache.fetch(_fetch);

  Future<int> _fetch() async {
    final stats =
        await _client.getAmbassadorStats().timeout(const Duration(seconds: 10));

    return stats.referralCount;
  }
}
