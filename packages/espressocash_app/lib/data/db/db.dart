import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../core/transactions/tx_sender.dart';
import '../../features/activities/db.dart';
import '../../features/activities/models/transaction.dart';
import '../../features/favorite_tokens/db.dart';
import '../../features/incoming_split_key_payments/db.dart';
import '../../features/outgoing_direct_payments/db.dart';
import '../../features/outgoing_split_key_payments/db.dart';
import '../../features/payment_request/db.dart';
import '../../features/popular_tokens/db.dart';
import '../../features/swap/db.dart';
import 'deprecated.dart';
import 'open_connection.dart';

part 'db.g.dart';

class OutgoingTransferRows extends Table {
  const OutgoingTransferRows();

  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

const int latestVersion = 36;

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
          if (from >= 22 && from < 28) {
            await _migrateOTP();
          }
          if (from >= 16 && from < 29) {
            await m.addColumn(oSKPRows, oSKPRows.slot);
          }
          if (from >= 15 && from < 30) {
            await m.addColumn(oDPRows, oDPRows.slot);
          }
          if (from >= 21 && from < 31) {
            await m.addColumn(swapRows, swapRows.slot);
            await m.addColumn(swapRows, swapRows.txFailureReason);
          }
          if (from >= 17 && from < 32) {
            await m.addColumn(iSKPRows, iSKPRows.txFailureReason);
            await m.addColumn(iSKPRows, iSKPRows.slot);
          }
          if (from >= 16 && from < 34) {
            await m.addColumn(oSKPRows, oSKPRows.resolvedAt);
            await m.addColumn(oSKPRows, oSKPRows.generatedLinksAt);
          }
          if (from >= 16 && from < 35) {
            await m.addColumn(oSKPRows, oSKPRows.apiVersion);
          }
          if (from >= 17 && from < 35) {
            await m.addColumn(iSKPRows, iSKPRows.apiVersion);
          }
          if (from < 36) {
            await m.deleteTable('i_s_l_p_rows');
          }
        },
      );

  Future<void> _migrateOTP() async {
    final otpRows = await select(oTRows).get();
    for (final row in otpRows) {
      await into(oSKPRows).insert(
        OSKPRow(
          id: row.id,
          created: row.created,
          amount: row.amount,
          token: row.token,
          status: row.status.toOSKPStatus(),
          txFailureReason: row.txFailureReason,
          withdrawTxId: row.withdrawTxId,
          cancelTx: row.cancelTx,
          cancelTxId: row.cancelTxId,
          privateKey: row.privateKey,
          link1: null,
          link2: null,
          link3: row.link,
          tx: row.tx,
          txId: row.txId,
          apiVersion: OskpApiVersionDto.manual,
        ),
      );
    }
  }
}
