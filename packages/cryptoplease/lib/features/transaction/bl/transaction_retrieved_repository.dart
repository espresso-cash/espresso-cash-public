import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/transaction/transaction_retrieved.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransactionRetrievedRepository {
  TransactionRetrievedRepository(this._db);

  final MyDatabase _db;

  Future<TransactionRetrieved?> mostRecentTx() async {
    final query = _db.select(_db.transactionRetrievedRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toTransactionRetrieved();
  }

  Future<void> discardAndMarkAllAsFetched() => _db.transaction(() async {
        final deleteQuery = _db.delete(_db.transactionRetrievedRows)
          ..where(
            (t) => t.status.equalsValue(TransactionRetrievedStatusDto.fetched),
          );
        await deleteQuery.go();
        await markAllAsFetched();
      });

  Future<void> markAllAsFetched() =>
      _db.update(_db.transactionRetrievedRows).write(
            const TransactionRetrievedRowsCompanion(
              status: Value(TransactionRetrievedStatusDto.fetched),
            ),
          );

  Future<void> saveAll(Iterable<TransactionRetrieved> activities) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionRetrievedRows,
          activities.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );

  Future<void> clear() => _db.delete(_db.transactionRetrievedRows).go();
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
