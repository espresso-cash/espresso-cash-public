import 'package:cryptoplease/data/db/open_connection.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_repository.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/transaction/bl/repository.dart';
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

const int latestVersion = 18;

const _tables = [
  OutgoingTransferRows,
  PaymentRequestRows,
  ODPRows,
  OSKPRows,
  ISKPRows,
  TransactionActivityRows,
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
          if (from < 18) {
            await m.createTable(transactionActivityRows);
          }
        },
      );
}
