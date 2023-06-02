import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../data/db/db.dart';
import '../../models/transaction.dart';

@injectable
class TxUpdaterRepository {
  const TxUpdaterRepository(this._db, this._client);

  final MyDatabase _db;
  final SolanaClient _client;

  Future<void> update(Ed25519HDPublicKey publicKey) async {
    final mostRecentTx = await _mostRecentTx();
    final mostRecentSignature = mostRecentTx?.tx.id;

    const fetchLimit = 100;

    final details = await _client.rpcClient.getTransactionsList(
      limit: fetchLimit,
      publicKey,
      until: mostRecentSignature,
      encoding: Encoding.base64,
      commitment: Commitment.confirmed,
    );

    if (details.isNotEmpty) {
      final txs = details.map((it) => it.toFetched());

      final hasGap = mostRecentSignature != null && txs.length == fetchLimit;

      if (hasGap) {
        await _db.transaction(() async {
          await _db.delete(_db.transactionRows).go();
          await _saveAll(txs);
        });
      } else {
        await _saveAll(txs);
      }
    }
  }

  Future<void> clear() => _db.delete(_db.transactionRows).go();

  Future<TxCommon?> _mostRecentTx() async {
    final query = _db.select(_db.transactionRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toModel();
  }

  Future<void> _saveAll(Iterable<TxCommon> txs) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionRows,
          txs.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );
}

class TransactionRows extends Table {
  const TransactionRows();

  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TxCommonStatus>()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

extension TransactionRowExt on TransactionRow {
  TxCommon toModel() => TxCommon(
        SignedTx.decode(encodedTx),
        created: created,
        status: status,
      );
}

extension on TxCommon {
  TransactionRow toRow() => TransactionRow(
        id: tx.id,
        created: created,
        encodedTx: tx.encode(),
        status: status,
      );
}

extension on TransactionDetails {
  TxCommon toFetched() {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);

    return TxCommon(
      tx,
      status:
          meta?.err == null ? TxCommonStatus.success : TxCommonStatus.failure,
      created: blockTime
          ?.let((it) => DateTime.fromMillisecondsSinceEpoch(1000 * it)),
    );
  }
}
