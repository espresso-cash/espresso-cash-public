import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_fetched.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

@injectable
class TransactionFetchedRepository {
  TransactionFetchedRepository(this._db, this._client);

  final MyDatabase _db;
  final SolanaClient _client;

  Future<void> clear() => _db.delete(_db.transactionFetchedRows).go();

  Future<IList<TransactionFetched>> fetch(String publicKey) async {
    final mostRecentTx = await _mostRecentTx();
    final mostRecentSignature = mostRecentTx?.id;

    final signatures = await _client.rpcClient.getSignaturesForAddress(
      limit: 100,
      publicKey,
      until: mostRecentSignature,
    );

    if (signatures.isNotEmpty) {
      final transactions = await _client.rpcClient.getMultipleTransactions(
        signatures,
        commitment: Commitment.finalized,
        encoding: Encoding.base64,
      );

      final fetched = transactions.map(_toFetched);
      await _saveAll(fetched);

      final hasGap = mostRecentSignature != null && fetched.length == 100;

      if (hasGap) {
        await _discardAndMarkAllAsDownloaded();
      } else {
        await _markAllAsDownloaded();
      }
    }

    return readAll();
  }

  Future<IList<TransactionFetched>> readAll() async {
    final query = _db.select(_db.transactionFetchedRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    final result = await query.get();

    return result.map((e) => e.toTransactionFetched()).toIList();
  }

  Future<TransactionFetched?> _mostRecentTx() async {
    final query = _db.select(_db.transactionFetchedRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toTransactionFetched();
  }

  Future<void> _discardAndMarkAllAsDownloaded() => _db.transaction(() async {
        final deleteQuery = _db.delete(_db.transactionFetchedRows)
          ..where(
            (t) => t.status.equalsValue(TransactionFetchedStatusDto.downloaded),
          );
        await deleteQuery.go();
        await _markAllAsDownloaded();
      });

  Future<void> _markAllAsDownloaded() =>
      _db.update(_db.transactionFetchedRows).write(
            const TransactionFetchedRowsCompanion(
              status: Value(TransactionFetchedStatusDto.downloaded),
            ),
          );

  Future<void> _saveAll(Iterable<TransactionFetched> fetched) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionFetchedRows,
          fetched.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );
}

enum TransactionFetchedStatusDto { pending, downloaded }

class TransactionFetchedRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TransactionFetchedStatusDto>()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

extension on TransactionFetchedRow {
  TransactionFetched toTransactionFetched() => TransactionFetched(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toModel(),
      );
}

extension on TransactionFetched {
  TransactionFetchedRow toRow() => TransactionFetchedRow(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toEnum(),
      );
}

extension on TransactionFetchedStatus {
  TransactionFetchedStatusDto toEnum() => when(
        pending: always(TransactionFetchedStatusDto.pending),
        downloaded: always(TransactionFetchedStatusDto.downloaded),
      );
}

extension on TransactionFetchedStatusDto {
  TransactionFetchedStatus toModel() {
    switch (this) {
      case TransactionFetchedStatusDto.pending:
        return const TransactionFetchedStatus.pending();
      case TransactionFetchedStatusDto.downloaded:
        return const TransactionFetchedStatus.downloaded();
    }
  }
}

TransactionFetched _toFetched(TransactionDetails details) {
  final rawTx = details.transaction as RawTransaction;
  final tx = SignedTx.fromBytes(rawTx.data);

  return TransactionFetched(
    id: tx.id,
    status: const TransactionFetchedStatus.pending(),
    encodedTx: tx.encode(),
    created: details.blockTime?.let(
      (blockTime) => DateTime.fromMillisecondsSinceEpoch(1000 * blockTime),
    ),
  );
}
