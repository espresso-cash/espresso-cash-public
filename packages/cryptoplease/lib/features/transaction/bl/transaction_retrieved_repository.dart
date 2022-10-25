import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/transaction/transaction_retrieved.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

@injectable
class TransactionRetrievedRepository {
  TransactionRetrievedRepository(this._db, this._client);

  final MyDatabase _db;
  final SolanaClient _client;

  Future<void> clear() => _db.delete(_db.transactionRetrievedRows).go();

  Future<void> fetchFromWalletAddress(String walletAddress) async {
    final mostRecentActivity = await _mostRecentTx();
    final mostRecentSignature = mostRecentActivity?.id;

    final signatures = await _client.rpcClient.getSignaturesForAddress(
      limit: 100,
      walletAddress,
      until: mostRecentSignature,
    );

    if (signatures.isNotEmpty) {
      final transactions = await _client.rpcClient.getMultipleTransactions(
        signatures,
        commitment: Commitment.finalized,
        encoding: Encoding.base64,
      );

      final activities = transactions.map(_toRetrieved);
      await _saveAll(activities);

      final hasGap = mostRecentSignature != null && activities.length == 100;

      if (hasGap) {
        await _discardAndMarkAllAsFetched();
      } else {
        await _markAllAsFetched();
      }
    }
  }

  Future<TransactionRetrieved?> _mostRecentTx() async {
    final query = _db.select(_db.transactionRetrievedRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toTransactionRetrieved();
  }

  Future<void> _discardAndMarkAllAsFetched() => _db.transaction(() async {
        final deleteQuery = _db.delete(_db.transactionRetrievedRows)
          ..where(
            (t) => t.status.equalsValue(TransactionRetrievedStatusDto.fetched),
          );
        await deleteQuery.go();
        await _markAllAsFetched();
      });

  Future<void> _markAllAsFetched() =>
      _db.update(_db.transactionRetrievedRows).write(
            const TransactionRetrievedRowsCompanion(
              status: Value(TransactionRetrievedStatusDto.fetched),
            ),
          );

  Future<void> _saveAll(Iterable<TransactionRetrieved> retrieved) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionRetrievedRows,
          retrieved.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );
}

enum TransactionRetrievedStatusDto { pending, fetched }

class TransactionRetrievedRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TransactionRetrievedStatusDto>()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

extension on TransactionRetrievedRow {
  TransactionRetrieved toTransactionRetrieved() => TransactionRetrieved(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toModel(),
      );
}

extension on TransactionRetrieved {
  TransactionRetrievedRow toRow() => TransactionRetrievedRow(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toEnum(),
      );
}

extension on TransactionRetrievedStatus {
  TransactionRetrievedStatusDto toEnum() => when(
        pending: always(TransactionRetrievedStatusDto.pending),
        fetched: always(TransactionRetrievedStatusDto.fetched),
      );
}

extension on TransactionRetrievedStatusDto {
  TransactionRetrievedStatus toModel() {
    switch (this) {
      case TransactionRetrievedStatusDto.pending:
        return const TransactionRetrievedStatus.pending();
      case TransactionRetrievedStatusDto.fetched:
        return const TransactionRetrievedStatus.fetched();
    }
  }
}

TransactionRetrieved _toRetrieved(TransactionDetails details) {
  final rawTx = details.transaction as RawTransaction;
  final tx = SignedTx.fromBytes(rawTx.data);

  return TransactionRetrieved(
    id: tx.id,
    status: const TransactionRetrievedStatus.pending(),
    encodedTx: tx.encode(),
    created: details.blockTime?.let(
      (blockTime) => DateTime.fromMillisecondsSinceEpoch(1000 * blockTime),
    ),
  );
}
