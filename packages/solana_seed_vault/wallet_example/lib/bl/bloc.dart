import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:request_permission/request_permission.dart';
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
  SeedVaultBloc(
    this._seedVault,
    this._permissions,
  ) : super(const SeedVaultState.none()) {
    _permissions.results.listen(
      (e) => e.isGranted(WalletPermission.accessSeedVault) ? refresh() : null,
    );
  }

  final Wallet _seedVault;
  final RequestPermission _permissions;

  int? authToken;

  Future<void> init() async {
    final isInstalled = await _seedVault.isAvailable(true);

    if (!isInstalled) {
      return emit(const SeedVaultState.error('Seed vault not installed'));
    }

    await _permissions
        .hasAndroidPermission(WalletPermission.accessSeedVault)
        .then(
          (granted) => granted
              ? refresh()
              : _permissions.requestAndroidPermission(
                  WalletPermission.accessSeedVault,
                  0,
                ),
        );
  }

  Future<void> refresh() async {
    const purpose = Purpose.signSolanaTransaction;
    final limits = await _seedVault.getImplementationLimitsForPurpose(purpose);
    final firstRequestedPublicKey =
        await _seedVault.getAccountByLevel(_firstRequestedPublicKeyIndex);
    final lastRequestedPublicKey = await _seedVault.getAccountByLevel(
      _firstRequestedPublicKeyIndex + limits.maxRequestedPublicKeys - 1,
    );

    emit(
      SeedVaultState.loaded(
        seeds: await _seedVault.getAuthorizedSeeds(),
        limits: limits,
        firstRequestedPublicKey: firstRequestedPublicKey,
        lastRequestedPublicKey: lastRequestedPublicKey,
        hasUnauthorizedSeeds:
            await _seedVault.hasUnauthorizedSeedsForPurpose(purpose),
      ),
    );
  }
}

const _firstRequestedPublicKeyIndex = 1000;
