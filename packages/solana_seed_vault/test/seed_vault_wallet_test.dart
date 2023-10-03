import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

import 'seed_vault_wallet_test.mocks.dart';

@GenerateMocks([WalletApiHost])
void main() {
  late MockWalletApiHost apiHost;

  setUp(() {
    apiHost = MockWalletApiHost();
    SeedVault.instance = SeedVault(apiHost);
  });

  AuthToken createFakeAuthToken() => Random(1).nextInt(200);

  test('Check for Seed Vault availability', () async {
    when(apiHost.isAvailable(any)).thenAnswer((_) async => true);

    final result = await SeedVault.instance.isAvailable(allowSimulated: false);

    expect(result, false);

    // Called on Android only
    verifyNever(apiHost.isAvailable(any));
    verifyNoMoreInteractions(apiHost);
  });

  test('Check and ask for Seed Vault permission', () async {
    when(apiHost.checkPermission()).thenAnswer((_) async => true);

    final result = await SeedVault.instance.checkPermission();

    expect(result, true);
    verify(apiHost.checkPermission()).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Get Implementation Limits for Purpose', () async {
    when(
      apiHost.getImplementationLimitsForPurpose(any),
    ).thenAnswer(
      (_) async => {},
    );

    final result = await SeedVault.instance
        .getImplementationLimitsForPurpose(Purpose.signSolanaTransaction);

    expect(result, isA<CursorData>());
    verify(apiHost.getImplementationLimitsForPurpose(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Get Authorized Seed', () async {
    when(
      apiHost.getAuthorizedSeeds(any, any, any),
    ).thenAnswer(
      (_) async => [],
    );

    final result = await SeedVault.instance.getAuthorizedSeeds();

    expect(result, isA<List<CursorData>>());
    verify(apiHost.getAuthorizedSeeds(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Get Accounts', () async {
    final authToken = createFakeAuthToken();

    when(
      apiHost.getAccounts(any, any, any, any),
    ).thenAnswer(
      (_) async => [],
    );

    final result = await SeedVault.instance.getAccounts(authToken: authToken);

    expect(result, isA<List<CursorData>>());
    verify(apiHost.getAccounts(any, any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Resolve Derivation Path', () async {
    when(
      apiHost.resolveDerivationPath(any, any),
    ).thenAnswer(
      (_) async => 'bip32:/m',
    );

    final result = await SeedVault.instance.resolveDerivationPath(
      derivationPath: Uri(),
      purpose: Purpose.signSolanaTransaction,
    );

    expect(result, isA<Uri>());
    verify(apiHost.resolveDerivationPath(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account Name', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountName(any, any, any)).thenAnswer(Future.value);

    await SeedVault.instance.updateAccountName(
      authToken: authToken,
      accountId: 0,
      name: '',
    );

    verify(apiHost.updateAccountName(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account IsUserWallet', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountIsUserWallet(any, any, any))
        .thenAnswer(Future.value);

    await SeedVault.instance.updateAccountIsUserWallet(
      authToken: authToken,
      accountId: 0,
      isUserWallet: true,
    );

    verify(apiHost.updateAccountIsUserWallet(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Update Account IsValid', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.updateAccountIsValid(any, any, any)).thenAnswer(Future.value);

    await SeedVault.instance.updateAccountIsValid(
      authToken: authToken,
      accountId: 0,
      isValid: true,
    );

    verify(apiHost.updateAccountIsValid(any, any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Deauthorize Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.deauthorizeSeed(any)).thenAnswer(Future.value);

    await SeedVault.instance.deauthorizeSeed(authToken);

    verify(apiHost.deauthorizeSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Check for unauthorized seeds for sign purpose', () async {
    when(
      apiHost.hasUnauthorizedSeedsForPurpose(any),
    ).thenAnswer(
      (_) async => true,
    );

    final result = await SeedVault.instance
        .hasUnauthorizedSeedsForPurpose(Purpose.signSolanaTransaction);

    expect(result, true);
    verify(apiHost.hasUnauthorizedSeedsForPurpose(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Authorize Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.authorizeSeed(any)).thenAnswer((_) async => authToken);

    final result =
        await SeedVault.instance.authorizeSeed(Purpose.signSolanaTransaction);

    expect(result, authToken);
    verify(apiHost.authorizeSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Create Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.createSeed(any)).thenAnswer((_) async => authToken);

    final result =
        await SeedVault.instance.createSeed(Purpose.signSolanaTransaction);

    expect(result, authToken);
    verify(apiHost.createSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Import Seed', () async {
    final authToken = createFakeAuthToken();

    when(apiHost.importSeed(any)).thenAnswer((_) async => authToken);

    final result =
        await SeedVault.instance.importSeed(Purpose.signSolanaTransaction);

    expect(result, authToken);
    verify(apiHost.importSeed(any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Request Public Keys', () async {
    final authToken = createFakeAuthToken();
    final uris = ['bip32:/m/0', 'bip32:/m/1'].map(Uri.parse).toList();

    when(
      apiHost.requestPublicKeys(any, any),
    ).thenAnswer(
      (_) async =>
          List.generate(uris.length, (_) => FakePublicKeyResponseDto()),
    );

    final result = await SeedVault.instance.requestPublicKeys(
      authToken: authToken,
      derivationPaths: uris,
    );

    expect(result, isA<List<PublicKeyResponse>>());
    expect(result.length, uris.length);
    verify(apiHost.requestPublicKeys(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  Uint8List createFakePayload() => Uint8List(512);

  test('Sign Messages', () async {
    final authToken = createFakeAuthToken();
    final uris = ['bip32:/m/0', 'bip32:/m/1'].map(Uri.parse).toList();

    final requests = [
      SigningRequest(
        payload: createFakePayload(),
        requestedSignatures: uris,
      ),
    ];

    when(
      apiHost.signMessages(any, any),
    ).thenAnswer(
      (_) async => requests
          .map((it) => FakeSigningResponseDto(it.requestedSignatures))
          .toList(),
    );

    final result = await SeedVault.instance.signMessages(
      authToken: authToken,
      signingRequests: requests,
    );

    expect(result, isA<List<SigningResponse>>());
    expect(result.length, requests.length);
    verify(apiHost.signMessages(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });

  test('Sign Transactions', () async {
    final authToken = createFakeAuthToken();
    final uris = ['bip32:/m/0', 'bip32:/m/1'].map(Uri.parse).toList();

    final requests = [
      SigningRequest(
        payload: createFakePayload(),
        requestedSignatures: uris,
      ),
    ];

    when(
      apiHost.signTransactions(any, any),
    ).thenAnswer(
      (_) async => requests
          .map((it) => FakeSigningResponseDto(it.requestedSignatures))
          .toList(),
    );

    final result = await SeedVault.instance.signTransactions(
      authToken: authToken,
      signingRequests: requests,
    );

    expect(result, isA<List<SigningResponse>>());
    expect(result.length, requests.length);
    verify(apiHost.signTransactions(any, any)).called(1);
    verifyNoMoreInteractions(apiHost);
  });
}

class FakePublicKeyResponseDto extends PublicKeyResponseDto {
  FakePublicKeyResponseDto()
      : super(
          resolvedDerivationPath: '',
          publicKey: Uint8List(1),
          publicKeyEncoded: '',
        );
}

class FakeSigningResponseDto extends SigningResponseDto {
  FakeSigningResponseDto(List<Uri> signers)
      : super(
          resolvedDerivationPaths: signers.map((it) => it.toString()).toList(),
          signatures: signers.map((_) => Uint8List(512)).toList(),
        );
}
