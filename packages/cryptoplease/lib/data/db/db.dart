import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../core/transactions/tx_sender.dart';
import '../../features/activities/db.dart';
import '../../features/activities/models/transaction.dart';
import '../../features/favorite_tokens/db.dart';
import '../../features/incoming_single_link_payments/db.dart';
import '../../features/incoming_split_key_payments/db.dart';
import '../../features/outgoing_direct_payments/db.dart';
import '../../features/outgoing_split_key_payments/db.dart';
import '../../features/payment_request/db.dart';
import '../../features/popular_tokens/db.dart';
import '../../features/swap/db.dart';
import '../deprecated.dart';
import 'open_connection.dart';

part 'db.g.dart';

class OutgoingTransferRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

const int latestVersion = 27;

const _tables = [
  OutgoingTransferRows,
  PaymentRequestRows,
  ODPRows,
  OSKPRows,
  ISKPRows,
  SwapRows,
  TransactionRows,
  FavoriteTokenRows,
  PopularTokenRows,
  OTRows,
  ITRows,
  ISLPRows,
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
          if (from < 21) {
            await m.createTable(swapRows);
          }
          if (from < 22) {
            await m.createTable(oTRows);
            await m.createTable(iTRows);
          }
          if (from < 23) {
            await m.createTable(popularTokenRows);
          }
          if (from < 24) {
            await m.createTable(favoriteTokenRows);
          }
          if (from >= 16 && from < 25) {
            await m.addColumn(oSKPRows, oSKPRows.withdrawTxId);
          }
          if (from >= 16 && from < 26) {
            await m.addColumn(oSKPRows, oSKPRows.cancelTx);
            await m.addColumn(oSKPRows, oSKPRows.cancelTxId);
          }
          if (from >= 22 && from < 26) {
            await m.addColumn(oTRows, oTRows.withdrawTxId);
            await m.addColumn(oTRows, oTRows.cancelTx);
            await m.addColumn(oTRows, oTRows.cancelTxId);
          }
          if (from >= 16 && from < 27) {
            await m.addColumn(oSKPRows, oSKPRows.link3);
          }
        },
      );
}
