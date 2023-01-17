// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../../models/swap.dart';
import '../../models/swap_seed.dart';

@injectable
class SwapRepository {
  SwapRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<Swap?> load(String id) {
    final query = _db.select(_db.swapRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<List<Swap>> watchAllPending() {
    final query = _db.select(_db.swapRows)
      ..where((p) => p.status.equalsValue(SwapStatusDto.success).not());

    return query.watch().map(
          (rows) => rows.map((row) => row.toModel(_tokens)).toList(),
        );
  }

  Stream<Swap?> watch(String id) {
    final query = _db.select(_db.swapRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel(_tokens));
  }

  Future<void> save(Swap payment) async =>
      _db.into(_db.swapRows).insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.swapRows).go();
}

class SwapRows extends Table with EntityMixin {
  IntColumn get status => intEnum<SwapStatusDto>()();
  IntColumn get amount => integer()();
  TextColumn get token => text()();
  TextColumn get inputMint => text()();
  TextColumn get outputMint => text()();
  IntColumn get slippage => intEnum<SlippageDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum SwapStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
}

enum SlippageDto {
  zpOne,
  zpFive,
  onePercent,
}

extension SwapRowExt on SwapRow {
  Swap toModel(TokenList tokens) => Swap(
        id: id,
        status: status.toModel(this),
        created: created,
        seed: SwapSeed(
          amount: CryptoAmount(
            value: amount,
            currency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
          ),
          inputToken: tokens.findTokenByMint(inputMint)!,
          outputToken: tokens.findTokenByMint(outputMint)!,
          slippage: slippage.toModel(),
        ),
      );
}

extension on SwapStatusDto {
  SwapStatus toModel(SwapRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case SwapStatusDto.txCreated:
        return SwapStatus.txCreated(tx!);
      case SwapStatusDto.txSent:
        return SwapStatus.txSent(tx!);
      case SwapStatusDto.success:
        return SwapStatus.success(tx!);
      case SwapStatusDto.txFailure:
        return const SwapStatus.txFailure();
      case SwapStatusDto.txSendFailure:
        return SwapStatus.txSendFailure(tx!);
      case SwapStatusDto.txWaitFailure:
        return SwapStatus.txWaitFailure(tx!);
    }
  }
}

extension on SlippageDto {
  Slippage toModel() {
    switch (this) {
      case SlippageDto.zpOne:
        return Slippage.zpOne;
      case SlippageDto.zpFive:
        return Slippage.zpFive;
      case SlippageDto.onePercent:
        return Slippage.onePercent;
    }
  }
}

extension on Swap {
  Future<SwapRow> toDto() async => SwapRow(
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        amount: seed.amount.value,
        token: seed.amount.token.address,
        inputMint: seed.inputToken.address,
        outputMint: seed.outputToken.address,
        slippage: seed.slippage.toDto(),
      );
}

extension on SwapStatus {
  SwapStatusDto toDto() => this.map(
        txCreated: always(SwapStatusDto.txCreated),
        txSent: always(SwapStatusDto.txSent),
        success: always(SwapStatusDto.success),
        txFailure: always(SwapStatusDto.txFailure),
        txSendFailure: always(SwapStatusDto.txSendFailure),
        txWaitFailure: always(SwapStatusDto.txWaitFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
        success: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.tx.id,
        txWaitFailure: (it) => it.tx.id,
      );
}

extension on Slippage {
  SlippageDto toDto() {
    switch (this) {
      case Slippage.zpOne:
        return SlippageDto.zpOne;
      case Slippage.zpFive:
        return SlippageDto.zpFive;
      case Slippage.onePercent:
        return SlippageDto.onePercent;
    }
  }
}
