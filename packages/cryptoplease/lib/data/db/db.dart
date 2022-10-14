import 'package:cryptoplease/data/db/open_connection.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_repository.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'db.g.dart';

class OutgoingTransferRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

enum PaymentRequestStateDto { initial, completed, error }

class PaymentRequestRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get payerName => text()();
  TextColumn get dynamicLink => text()();
  IntColumn get state => intEnum<PaymentRequestStateDto>()();
  TextColumn get transactionId => text().nullable()();

  // SolanaPayRequest columns
  TextColumn get recipient => text()();
  TextColumn get amount => text().nullable()();
  TextColumn get spltToken => text().nullable()();
  TextColumn get reference => text().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get message => text().nullable()();
  TextColumn get memo => text().nullable()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

const int latestVersion = 17;

const _tables = [
  OutgoingTransferRows,
  PaymentRequestRows,
  ODPRows,
  OSKPRows,
  ISKPRows,
];

@lazySingleton
@DriftDatabase(tables: _tables)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(openConnection());

  MyDatabase.connect(DatabaseConnection connection)
      : super(connection.executor);

  @override
  int get schemaVersion => latestVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 12) {
            await m.createTable(outgoingTransferRows);
          }
          if (from < 13) {
            await m.createTable(paymentRequestRows);
          }
          if (from >= 13 && from < 14) {
            await m.addColumn(
              paymentRequestRows,
              paymentRequestRows.transactionId,
            );
          }
          if (from < 15) {
            await m.createTable(oDPRows);
          }
          if (from < 16) {
            await m.createTable(oSKPRows);
          }
          if (from < 17) {
            await m.createTable(iSKPRows);
          }
        },
      );
}
