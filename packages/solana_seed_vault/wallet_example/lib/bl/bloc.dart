import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dfunc/dfunc.dart';
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
    required List<SeedDto> seeds,
    required bool hasUnauthorizedSeeds,
  }) = _Loaded;
}

class SeedVaultBloc extends Cubit<SeedVaultState> {
  SeedVaultBloc(
    this._apiHost,
    this._permissions,
  ) : super(const SeedVaultState.none()) {
    _permissions.results.listen(
      (e) => e.isGranted(WalletPermission.accessSeedVault) ? refresh() : null,
    );
  }

  final ApiHost _apiHost;
  final RequestPermission _permissions;

  int? authToken;

  Future<void> init() async {
    final isInstalled = await _apiHost.isAvailable(true);

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
    final seeds =
        await _apiHost.getAuthorizedSeeds().letAsync((it) => it.compact());

    final hasUnauthorizedSeeds = await _apiHost
        .hasUnauthorizedSeedsForPurpose(Purpose.signSolanaTransaction);

    emit(
      SeedVaultState.loaded(
        seeds: seeds.toList(),
        hasUnauthorizedSeeds: hasUnauthorizedSeeds,
      ),
    );
  }
}
