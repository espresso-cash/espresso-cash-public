import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

import 'bip_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([Bip32ApiHost, Bip44ApiHost])
Future<void> main() async {
  group(
    'Bip32DerivationPath',
    () {
      late MockBip32ApiHost apiHost;

      setUp(
        () {
          apiHost = MockBip32ApiHost();
          Bip32DerivationPath.instance = Bip32DerivationPath(apiHost);
        },
      );

      test('Convert Bip32Data to Uri', () async {
        when(apiHost.toUri(any)).thenAnswer((_) async => 'bip32:/m/1000\'');

        final result = await Bip32DerivationPath.instance.toUri(
          const Bip32Data(levels: [BipLevel(index: 0, hardened: true)]),
        );

        expect(result, isA<Uri>());
        verify(apiHost.toUri(any)).called(1);
        verifyNoMoreInteractions(apiHost);
      });

      test('Convert Uri to Bip32Data', () async {
        when(apiHost.fromUri(any)).thenAnswer((_) async => [FakeBipLevelDto()]);

        final result = await Bip32DerivationPath.instance.fromUri(
          Uri.parse('bip32:/m/1000\''),
        );

        expect(result, isA<Bip32Data>());
        verify(apiHost.fromUri(any)).called(1);
        verifyNoMoreInteractions(apiHost);
      });
    },
  );

  group(
    'Bip44DerivationPath',
    () {
      late MockBip44ApiHost apiHost;

      setUp(
        () {
          apiHost = MockBip44ApiHost();
          Bip44DerivationPath.instance = Bip44DerivationPath(apiHost);
        },
      );

      test('Convert Bip44Data to Uri', () async {
        when(apiHost.toUri(any)).thenAnswer((_) async => 'bip44:/m/44\'');

        final result = await Bip44DerivationPath.instance.toUri(
          const Bip44Data(account: BipLevel(index: 0, hardened: true)),
        );

        expect(result, isA<Uri>());
        verify(apiHost.toUri(any)).called(1);
        verifyNoMoreInteractions(apiHost);
      });

      test('Convert Uri to Bip44Data', () async {
        when(
          apiHost.fromUri(any),
        ).thenAnswer(
          (_) async => FakeBip44DerivationDto(),
        );

        final result = await Bip44DerivationPath.instance.fromUri(
          Uri.parse('bip44:/m/44\''),
        );

        expect(result, isA<Bip44Data>());
        verify(apiHost.fromUri(any)).called(1);
        verifyNoMoreInteractions(apiHost);
      });
    },
  );
}
