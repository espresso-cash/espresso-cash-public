import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/tx_sender.dart';
import '../../features/activities/module.dart';
import '../../features/incoming_split_key_payments/module.dart';
import '../../features/outgoing_direct_payments/module.dart';
import '../../features/outgoing_split_key_payments/module.dart';
import '../../features/payment_request/module.dart';
import 'open_connection.dart';

part 'db.g.dart';

class OutgoingTransferRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

const int latestVersion = 22;

const _tables = [
  OutgoingTransferRows,
  PaymentRequestRows,
  ODPRows,
  OSKPRows,
  ISKPRows,
  TransactionRows,
  ODPRequestRows,
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

          if (from >= 15 && from < 18) {
            await m.addColumn(oDPRows, oDPRows.reference);
          }

          if (from >= 15 && from < 19) {
            await m.addColumn(oDPRows, oDPRows.txFailureReason);
          }
          if (from >= 16 && from < 19) {
            await m.addColumn(oSKPRows, oSKPRows.txFailureReason);
          }

          if (from < 20) {
            await m.createTable(transactionRows);
          }

          if (from < 22) {
            await m.createTable(oDPRequestRows);
          }
        },
      );
}
