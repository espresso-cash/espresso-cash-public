import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_test/bloc_test.dart';
import 'package:espressocash_app/core/wallet.dart';
import 'package:espressocash_app/features/accounts/data/account_repository.dart';
import 'package:espressocash_app/features/accounts/models/account.dart';
import 'package:espressocash_app/features/accounts/models/mnemonic.dart';
import 'package:espressocash_app/features/accounts/services/accounts_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import 'accounts_bloc_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage, SeedVault])
Future<void> main() async {
  final seedVault = MockSeedVault();
  final storage = MockFlutterSecureStorage();
  final mnemonic = bip39.generateMnemonic();
  final wallet = await createLocalWallet(mnemonic: mnemonic);
  final testAccount = MyAccount(
    wallet: wallet,
    accessMode: const AccessMode.loaded(),
  );
  final repository = AccountRepository(storage);

  tearDown(() {
    reset(storage);
  });

  AccountsBloc createBloc() => AccountsBloc(
        storage: storage,
        seedVault: seedVault,
        repository: repository,
      );

  blocTest<AccountsBloc, AccountsState>(
    'Tries to load account from storage',
    setUp: () {
      when(storage.read(key: anyNamed('key'), iOptions: anyNamed('iOptions')))
          .thenAnswer((_) async => null);
      when(storage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});
    },
    build: createBloc,
    act: (b) {
      b.add(const AccountsEvent.initialize());
    },
    expect: () => [
      const AccountsState(isProcessing: true),
      const AccountsState(),
    ],
    verify: (_) {
      verify(storage.read(key: anyNamed('key'), iOptions: anyNamed('iOptions')))
          .called(2);
      verifyNever(
        storage.write(key: anyNamed('key'), value: anyNamed('value')),
      );
    },
  );

  blocTest<AccountsBloc, AccountsState>(
    'Loads account from storage if it exists',
    setUp: () {
      when(
        storage.read(key: authTokenKey, iOptions: anyNamed('iOptions')),
      ).thenAnswer((_) async => null);
      when(
        storage.read(key: mnemonicKey, iOptions: anyNamed('iOptions')),
      ).thenAnswer((_) async => mnemonic);
      when(storage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});
    },
    build: createBloc,
    act: (b) {
      b.add(const AccountsEvent.initialize());
    },
    expect: () => [
      const AccountsState(isProcessing: true),
      allOf(
        predicate(
          (AccountsState a) => a.account?.address == testAccount.address,
          'has correct account address',
        ),
        predicate((AccountsState a) => !a.isProcessing, 'is not processing'),
      ),
    ],
  );

  blocTest<AccountsBloc, AccountsState>(
    'Saves account when created',
    setUp: () {
      when(storage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});
    },
    build: createBloc,
    act: (b) {
      b.add(
        AccountsEvent.created(
          source: AccountSource.local(Mnemonic.generated(mnemonic)),
          account: testAccount,
        ),
      );
    },
    expect: () => [
      const AccountsState(isProcessing: true),
      allOf(
        predicate(
          (AccountsState a) => a.account?.address == testAccount.address,
          'has correct account address',
        ),
        predicate((AccountsState a) => !a.isProcessing, 'is not processing'),
      ),
    ],
    verify: (_) {
      verify(
        storage.write(
          key: mnemonicKey,
          value: mnemonic,
          iOptions: anyNamed('iOptions'),
        ),
      ).called(1);
    },
  );
}
