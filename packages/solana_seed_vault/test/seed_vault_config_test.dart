import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

import 'seed_vault_config_test.mocks.dart';

@GenerateMocks([SeedVaultApiHost])
Future<void> main() async {
  late MockSeedVaultApiHost apiHost;

  setUp(() {
    apiHost = MockSeedVaultApiHost();
    SeedVaultConfig.instance = SeedVaultConfig(apiHost);
  });

  
}
