import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

import 'seed_vault_test.mocks.dart';

@GenerateMocks([SeedVaultApiHost])
Future<void> main() async {
  late MockSeedVaultApiHost apiHost;

  setUp(() {
    apiHost = MockSeedVaultApiHost();
    SeedVault.instance = SeedVault(apiHost);
  });

  test('Check for Seed Vault availability', () async {
    when(apiHost.isAvailable(any)).thenAnswer((_) async => true);

    final result = await SeedVault.instance.isAvailable(false);

    expect(result, true);
    verify(apiHost.isAvailable(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Check and ask for Seed Vault permission', () async {
    when(apiHost.checkPermission()).thenAnswer((_) async => true);

    final result = await SeedVault.instance.checkPermission();

    expect(result, true);
    verify(apiHost.checkPermission()).called(1);
    verifyNoMoreInteractions(apiHost);
  });
}
