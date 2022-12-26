import 'package:dfunc/dfunc.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/bip.dart';

class Bip32DerivationPath {
  Bip32DerivationPath._(this._platform);

  final Bip32ApiHost _platform;

  static final _instance = Bip32DerivationPath._(Bip32ApiHost());

  static Bip32DerivationPath get instance => _instance;

  Future<Uri> toUri(Bip32Data data) async {
    final levels = data.levels.map((it) => it.toDto()).toList();

    final uri = await _platform.toUri(levels);

    return Uri.parse(uri);
  }

  Future<Bip32Data> fromUri(Uri uri) async {
    final dto = await _platform.fromUri(uri.toString());

    final levels = dto.compact().map((it) => it.toModel()).toList();

    return Bip32Data(levels: levels);
  }
}

class Bip44DerivationPath {
  Bip44DerivationPath._(this._platform);

  final Bip44ApiHost _platform;

  static final _instance = Bip44DerivationPath._(Bip44ApiHost());

  static Bip44DerivationPath get instance => _instance;

  Future<Uri> toUri(Bip44Data data) async {
    final dto = Bip44DerivationDto(
      account: data.account.toDto(),
      addressIndex: data.addressIndex?.toDto(),
      change: data.change?.toDto(),
    );

    final uri = await _platform.toUri(dto);

    return Uri.parse(uri);
  }

  Future<Bip44Data> fromUri(Uri uri) async {
    final dto = await _platform.fromUri(uri.toString());

    return Bip44Data(
      // ignore: avoid-non-null-assertion, account should not be null here
      account: dto.account!.toModel(),
      addressIndex: dto.addressIndex?.toModel(),
      change: dto.change?.toModel(),
    );
  }
}

extension on BipLevel {
  BipLevelDto toDto() => BipLevelDto(hardened: hardened, index: index);
}

extension on BipLevelDto {
  BipLevel toModel() => BipLevel(hardened: hardened, index: index);
}
