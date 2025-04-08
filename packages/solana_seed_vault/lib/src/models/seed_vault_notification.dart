import 'package:freezed_annotation/freezed_annotation.dart';

part 'seed_vault_notification.freezed.dart';

@freezed
class SeedVaultNotification with _$SeedVaultNotification {
  const factory SeedVaultNotification({required List<Uri> uris, required int flags}) =
      _SeedVaultNotification;
}
