// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../../models/swap.dart';
import '../../models/swap_seed.dart';

@injectable
class SwapRepository {
  const SwapRepository(this._db, this._tokens);

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

  Stream<IList<Swap>> watchTxCreated() => _watchWithStatuses([
        SwapStatusDto.txCreated,
        SwapStatusDto.txSendFailure,
      ]);

  Stream<IList<Swap>> watchTxSent() => _watchWithStatuses([
        SwapStatusDto.txSent,
        SwapStatusDto.txWaitFailure,
      ]);

  Stream<IList<Swap>> _watchWithStatuses(
    Iterable<SwapStatusDto> statuses,
  ) {
    final query = _db.select(_db.swapRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap((rows) => rows.map((row) => row.toModel(_tokens)))
        .map((it) => it.toIList());
  }
}

class SwapRows extends Table with EntityMixin, TxStatusMixin {
  const SwapRows();

  IntColumn get status => intEnum<SwapStatusDto>()();
  IntColumn get amount => integer()();
  TextColumn get token => text()();
  TextColumn get inputMint => text()();
  TextColumn get outputMint => text()();
  IntColumn get slippage => intEnum<SlippageDto>()();
}

enum SwapStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure, // Legacy
  txWaitFailure, // Legacy
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
            cryptoCurrency:
                CryptoCurrency(token: tokens.findTokenByMint(token)!),
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
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case SwapStatusDto.txCreated:
      case SwapStatusDto.txSendFailure:
        return SwapStatus.txCreated(tx!, slot: slot ?? BigInt.zero);
      case SwapStatusDto.txSent:
      case SwapStatusDto.txWaitFailure:
        return SwapStatus.txSent(tx!, slot: slot ?? BigInt.zero);
      case SwapStatusDto.success:
        return SwapStatus.success(tx!);
      case SwapStatusDto.txFailure:
        return SwapStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
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
        slot: status.toSlot()?.toString(),
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on SwapStatus {
  SwapStatusDto toDto() => this.map(
        txCreated: always(SwapStatusDto.txCreated),
        txSent: always(SwapStatusDto.txSent),
        success: always(SwapStatusDto.success),
        txFailure: always(SwapStatusDto.txFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        success: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.tx.id,
        txCreated: (it) => it.tx.id,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
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
