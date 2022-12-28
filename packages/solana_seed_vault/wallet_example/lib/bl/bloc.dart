import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

part 'bloc.freezed.dart';

@freezed
class SeedVaultState with _$SeedVaultState {
  const factory SeedVaultState.none() = _None;
  const factory SeedVaultState.error(String err) = _Error;
  const factory SeedVaultState.unauthorized() = _Unauthorized;
  const factory SeedVaultState.loaded({
    required List<Seed> seeds,
    required ImplementationLimits limits,
    required bool hasUnauthorizedSeeds,
    required Uri? firstRequestedPublicKey,
    required Uri? lastRequestedPublicKey,
  }) = _Loaded;
}

class SeedVaultBloc extends Cubit<SeedVaultState> {
  SeedVaultBloc() : super(const SeedVaultState.none());

  int? authToken;

  Future<void> init() async {
    final isInstalled = await SeedVault.instance.isAvailable(true);

    if (!isInstalled) {
      return emit(const SeedVaultState.error('Seed vault not installed'));
    }

    final granted = await SeedVault.instance.checkPermission();

    if (granted) {
      return refresh();
    } else {
      return emit(const SeedVaultState.error('You need to allow Seed vault'));
    }
  }

  Future<void> authorizeSeed() async {
    await Wallet.instance.authorizeSeed(Purpose.signSolanaTransaction);
  }

  Future<void> signMessage(Seed seed, int messageCount) async {
    final signingRequests = List.generate(
      messageCount,
      (_) => SigningRequest(
        payload: Uint8List(_messageSize),
        requestedSignatures: [seed.accounts.first.derivationPath],
      ),
    );

    await Wallet.instance.signPayload(
      authToken: seed.authToken,
      signingRequests: signingRequests,
      payloadType: PayloadType.transaction,
    );
  }

  Future<void> deathorizeSeed(Seed seed) async {
    await Wallet.instance.deauthorizeSeed(seed.authToken);
    await refresh();
  }

  Future<void> refresh() async {
    const purpose = Purpose.signSolanaTransaction;
    final limits =
        await Wallet.instance.getImplementationLimitsForPurpose(purpose);
    final firstRequestedPublicKey =
        await _getRequestedPublicKeyByIndex(_firstRequestedPublicKeyIndex);
    final lastRequestedPublicKey = await _getRequestedPublicKeyByIndex(
      _firstRequestedPublicKeyIndex + limits.maxRequestedPublicKeys - 1,
    );

    emit(
      SeedVaultState.loaded(
        seeds: await Wallet.instance.getAuthorizedSeeds(),
        limits: limits,
        firstRequestedPublicKey: firstRequestedPublicKey,
        lastRequestedPublicKey: lastRequestedPublicKey,
        hasUnauthorizedSeeds:
            await Wallet.instance.hasUnauthorizedSeedsForPurpose(purpose),
      ),
    );
  }

  Future<Uri> _getRequestedPublicKeyByIndex(int index) =>
      Bip32DerivationPath.instance.toUri(
        Bip32Data(levels: [BipLevel(index: index, hardened: true)]),
      );
}

const _firstRequestedPublicKeyIndex = 1000;
const _messageSize = 512;
