// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/tokens/token_list.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';

@injectable
class SolanaPayRepository {
  SolanaPayRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<SolanaPayRequest?> load(String id) {
    final query = _db.select(_db.solanaPayRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<SolanaPayRequest?> watch(String id) {
    final query = _db.select(_db.solanaPayRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().map((row) => row?.toModel(_tokens));
  }

  Future<void> save(SolanaPayRequest request) =>
      _db.into(_db.solanaPayRows).insertOnConflictUpdate(request.toDto());

  Future<void> clear() => _db.delete(_db.solanaPayRows).go();
}

class SolanaPayRows extends Table with AmountMixin, EntityMixin {
  TextColumn get receiver => text()();
  TextColumn get url => text()();
}

extension SolanaPayRowExt on SolanaPayRow {
  SolanaPayRequest toModel() => SolanaPayRequest.parse(url);
}


extension on SolanaPayRequest {
  SolanaPayRow toDto() => SolanaPayRow(
        id: id,
        receiver: receiver.toBase58(),
        reference: reference?.toBase58(),
        amount: amount.value,
        token: amount.currency.token.address,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on SolanaPayStatus {
  SolanaPayStatusDto toDto() => this.map(
        txCreated: always(SolanaPayStatusDto.txCreated),
        txSent: always(SolanaPayStatusDto.txSent),
        success: always(SolanaPayStatusDto.success),
        txFailure: always(SolanaPayStatusDto.txFailure),
        txSendFailure: always(SolanaPayStatusDto.txSendFailure),
        txWaitFailure: always(SolanaPayStatusDto.txWaitFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        txWaitFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );
}
