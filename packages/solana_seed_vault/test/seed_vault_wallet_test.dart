import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

import 'seed_vault_wallet_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([WalletApiHost])
Future<void> main() async {
  late MockWalletApiHost apiHost;

  setUp(() {
    apiHost = MockWalletApiHost();
    SeedVaultWallet.instance = SeedVaultWallet(apiHost);
  });

  AuthToken createFakeAuthToken() => Random(1).nextInt(200);

  test('Get Implementation Limits for Purpose', () async {
    when(
      apiHost.getImplementationLimitsForPurpose(any),
    ).thenAnswer(
      (_) async => FakeImplementationLimitsDto(),
    );

    final result = await SeedVaultWallet.instance
        .getImplementationLimitsForPurpose(Purpose.signSolanaTransaction);

    expect(result, isA<ImplementationLimits>());
    verify(apiHost.getImplementationLimitsForPurpose(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Get Authorized Seed', () async {
    final authToken = createFakeAuthToken();

    when(
      apiHost.getAuthorizedSeeds(),
    ).thenAnswer(
      (_) async => [FakeSeedDto(authToken)],
    );

    final result = await SeedVaultWallet.instance.getAuthorizedSeeds();

    expect(result, isA<List<Seed>>());
    expect(result.every((it) => it.authToken == authToken), true);
    verify(apiHost.getAuthorizedSeeds()).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Get Accounts', () async {
    final authToken = createFakeAuthToken();

    when(
      apiHost.getAccounts(any, any),
    ).thenAnswer(
      (_) async => List.generate(2, FakeAccountDto.new),
    );

    final result = await SeedVaultWallet.instance.getAccounts(authToken);

    expect(result, isA<AuthorizationResultSuccess<List<Account>>>());
    verify(apiHost.getAccounts(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Resolve Derivation Path', () async {
    final account = FakeAccountDto(0);

    when(
      apiHost.resolveDerivationPath(any, any),
    ).thenAnswer(
      (_) async => account.derivationPath,
    );

    final result = await SeedVaultWallet.instance.resolveDerivationPath(
      derivationPath: account.derivationPath.let(Uri.parse),
      purpose: Purpose.signSolanaTransaction,
    );

    expect(result, isA<Uri>());
    verify(apiHost.resolveDerivationPath(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account Name', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountName(any, any, any)).thenAnswer(Future.value);

    final result = await SeedVaultWallet.instance.updateAccountName(
      authToken: authToken,
      accountId: FakeAccountDto(0).id,
      name: '',
    );

    expect(result, isA<AuthorizationResultSuccess<void>>());
    verify(apiHost.updateAccountName(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account IsUserWallet', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountIsUserWallet(any, any, any))
        .thenAnswer(Future.value);

    final result = await SeedVaultWallet.instance.updateAccountIsUserWallet(
      authToken: authToken,
      accountId: FakeAccountDto(0).id,
      isUserWallet: true,
    );

    expect(result, isA<AuthorizationResultSuccess<void>>());
    verify(apiHost.updateAccountIsUserWallet(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account IsValid', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountIsValid(any, any, any)).thenAnswer(Future.value);

    final result = await SeedVaultWallet.instance.updateAccountIsValid(
      authToken: authToken,
      accountId: FakeAccountDto(0).id,
      isValid: true,
    );

    expect(result, isA<AuthorizationResultSuccess<void>>());
    verify(apiHost.updateAccountIsValid(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Deauthorize Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.deauthorizeSeed(any)).thenAnswer(Future.value);

    await SeedVaultWallet.instance.deauthorizeSeed(authToken);

    verify(apiHost.deauthorizeSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Check for unauthorized seeds for sign purpose', () async {
    when(
      apiHost.hasUnauthorizedSeedsForPurpose(any),
    ).thenAnswer(
      (_) async => true,
    );

    final result = await SeedVaultWallet.instance
        .hasUnauthorizedSeedsForPurpose(Purpose.signSolanaTransaction);

    expect(result, true);
    verify(apiHost.hasUnauthorizedSeedsForPurpose(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Authorize Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.authorizeSeed(any)).thenAnswer((_) async => authToken);

    final result = await SeedVaultWallet.instance
        .authorizeSeed(Purpose.signSolanaTransaction);

    expect(result, isA<AuthorizationResultSuccess<AuthToken>>());
    expect(result.whenOrNull(success: identity), authToken);
    verify(apiHost.authorizeSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Create Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.createSeed(any)).thenAnswer((_) async => authToken);

    final result = await SeedVaultWallet.instance
        .createSeed(Purpose.signSolanaTransaction);

    expect(result, isA<AuthorizationResultSuccess<AuthToken>>());
    expect(result.whenOrNull(success: identity), authToken);
    verify(apiHost.createSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Import Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.importSeed(any)).thenAnswer((_) async => authToken);

    final result = await SeedVaultWallet.instance
        .importSeed(Purpose.signSolanaTransaction);

    expect(result, isA<AuthorizationResultSuccess<AuthToken>>());
    expect(result.whenOrNull(success: identity), authToken);
    verify(apiHost.importSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Request Public Keys', () async {
    final authToken = createFakeAuthToken();
    final uris = FakeSeedDto(authToken)
        .accounts
        .compact()
        .map((it) => Uri.parse(it.derivationPath))
        .toList();

    when(
      apiHost.requestPublicKeys(any, any),
    ).thenAnswer(
      (_) async =>
          List.generate(uris.length, (_) => FakePublicKeyResponseDto()),
    );

    final result = await SeedVaultWallet.instance.requestPublicKeys(
      authToken: authToken,
      derivationPaths: uris,
    );

    expect(result, isA<AuthorizationResultSuccess<List<PublicKeyResponse>>>());
    expect(result.whenOrNull(success: identity)?.length, uris.length);
    verify(apiHost.requestPublicKeys(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  Uint8List createFakePayload() => Uint8List(512);

  test('Sign Messages', () async {
    final authToken = createFakeAuthToken();
    final accounts = FakeSeedDto(authToken).accounts.compact().toList();
    final requests = [
      SigningRequest(
        payload: createFakePayload(),
        requestedSignatures:
            accounts.map((it) => Uri.parse(it.derivationPath)).toList(),
      ),
    ];

    when(
      apiHost.signMessages(any, any),
    ).thenAnswer(
      (_) async =>
          requests.map((it) => FakeSigningResponseDto(accounts)).toList(),
    );

    final result = await SeedVaultWallet.instance.signMessages(
      authToken: authToken,
      signingRequests: requests,
    );

    expect(result, isA<AuthorizationResultSuccess<List<SigningResponse>>>());
    expect(result.whenOrNull(success: identity)?.length, requests.length);
    verify(apiHost.signMessages(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Sign Transactions', () async {
    final authToken = createFakeAuthToken();
    final accounts = FakeSeedDto(authToken).accounts.compact().toList();
    final requests = [
      SigningRequest(
        payload: createFakePayload(),
        requestedSignatures:
            accounts.map((it) => Uri.parse(it.derivationPath)).toList(),
      ),
    ];

    when(
      apiHost.signTransactions(any, any),
    ).thenAnswer(
      (_) async =>
          requests.map((it) => FakeSigningResponseDto(accounts)).toList(),
    );

    final result = await SeedVaultWallet.instance.signTransactions(
      authToken: authToken,
      signingRequests: requests,
    );

    expect(result, isA<AuthorizationResultSuccess<List<SigningResponse>>>());
    expect(result.whenOrNull(success: identity)?.length, requests.length);
    verify(apiHost.signTransactions(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });
}
