import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransactionRepository {
  TransactionRepository(this._db);

  final MyDatabase _db;

  Future<List<TransactionActivity>> readAll() async {
    final query = _db.select(_db.transactionActivityRows)
      ..where(
        (t) => t.status.equalsValue(TransactionActivityStatusDto.fetched),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    final result = await query.get();

    return result.map((t) => t.toTransactionActivity()).toList();
  }

  Future<TransactionActivity?> mostRecentTx() async {
    final query = _db.select(_db.transactionActivityRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toTransactionActivity();
  }

  Future<void> discardAndMarkAllAsFetched() => _db.transaction(() async {
        final deleteQuery = _db.delete(_db.transactionActivityRows)
          ..where(
            (t) => t.status.equalsValue(TransactionActivityStatusDto.fetched),
          );
        await deleteQuery.go();
        await markAllAsFetched();
      });

  Future<void> markAllAsFetched() =>
      _db.update(_db.transactionActivityRows).write(
            const TransactionActivityRowsCompanion(
              status: Value(TransactionActivityStatusDto.fetched),
            ),
          );

  Future<void> saveAll(Iterable<TransactionActivity> activities) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionActivityRows,
          activities.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );

  Future<void> clear() => _db.delete(_db.transactionActivityRows).go();
}

enum TransactionActivityStatusDto { pending, fetched }

class TransactionActivityRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TransactionActivityStatusDto>()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

extension on TransactionActivityRow {
  TransactionActivity toTransactionActivity() => TransactionActivity(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toModel(),
      );
}

extension on TransactionActivity {
  TransactionActivityRow toRow() => TransactionActivityRow(
        id: id,
        created: created,
        encodedTx: encodedTx,
        status: status.toEnum(),
      );
}

extension on TransactionActivityStatus {
  TransactionActivityStatusDto toEnum() => when(
        pending: always(TransactionActivityStatusDto.pending),
        fetched: always(TransactionActivityStatusDto.fetched),
      );
}

extension on TransactionActivityStatusDto {
  TransactionActivityStatus toModel() {
    switch (this) {
      case TransactionActivityStatusDto.pending:
        return const TransactionActivityStatus.pending();
      case TransactionActivityStatusDto.fetched:
        return const TransactionActivityStatus.fetched();
    }
  }
}
