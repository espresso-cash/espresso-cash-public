import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../features/activities/data/tx_updater_repository.dart';
import '../../features/activities/models/transaction.dart';
import '../../features/favorite_tokens/data/repository.dart';
import '../../features/incoming_link_payments/data/ilp_repository.dart';
import '../../features/outgoing_direct_payments/data/repository.dart';
import '../../features/outgoing_link_payments/data/repository.dart';
import '../../features/payment_request/data/repository.dart';
import '../../features/popular_tokens/data/popular_token_cache.dart';
import '../../features/ramp/models/ramp_partner.dart';
import '../../features/swap/data/swap_repository.dart';
import '../../features/transactions/models/tx_results.dart';
import 'deprecated.dart';
import 'mixins.dart';
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

const int latestVersion = 44;

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
  OLPRows,
  ILPRows,
  OnRampOrderRows,
  OffRampOrderRows,
];

@lazySingleton
@DriftDatabase(tables: _tables)
class MyDatabase extends _$MyDatabase {
  @factoryMethod
  MyDatabase() : super(openConnection());

  MyDatabase.withExecutor(super.e);

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
          if (from < 37) {
            await m.createTable(onRampOrderRows);
          }
          if (from < 38) {
            await m.alterTable(TableMigration(paymentRequestRows));
          }
          if (from < 39) {
            await m.createTable(oLPRows);
            await m.createTable(iLPRows);
          }
          if (from < 40) {
            await m.createTable(offRampOrderRows);
          }
          if (from >= 37 && from < 41) {
            await m.addColumn(onRampOrderRows, onRampOrderRows.partner);
          }
          if (from >= 40 && from < 42) {
            await m.addColumn(offRampOrderRows, offRampOrderRows.partner);
          }
          if (from >= 40 && from < 43) {
            await m.addColumn(offRampOrderRows, offRampOrderRows.resolvedAt);
            await m.addColumn(offRampOrderRows, offRampOrderRows.receiveAmount);
            await m.addColumn(offRampOrderRows, offRampOrderRows.fiatSymbol);
          }
          if (from >= 37 && from < 44) {
            await m.addColumn(onRampOrderRows, onRampOrderRows.status);
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

class OnRampOrderRows extends Table with AmountMixin, EntityMixin {
  const OnRampOrderRows();

  BoolColumn get isCompleted => boolean()();
  TextColumn get humanStatus => text()();
  TextColumn get machineStatus => text()();
  TextColumn get partnerOrderId => text()();
  IntColumn get receiveAmount => integer().nullable()();
  TextColumn get txHash => text()();
  TextColumn get partner =>
      textEnum<RampPartner>().withDefault(const Constant('kado'))();
  TextColumn get status => textEnum<OnRampOrderStatus>()();
}

class OffRampOrderRows extends Table with AmountMixin, EntityMixin {
  const OffRampOrderRows();

  TextColumn get status => textEnum<OffRampOrderStatus>()();
  TextColumn get humanStatus => text()();
  TextColumn get machineStatus => text()();
  TextColumn get partnerOrderId => text()();
  TextColumn get transaction => text()();
  TextColumn get depositAddress => text()();
  Int64Column get slot => int64()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  IntColumn get receiveAmount => integer().nullable()();
  TextColumn get fiatSymbol => text().nullable()();
  TextColumn get partner =>
      textEnum<RampPartner>().withDefault(const Constant('kado'))();
}

enum OnRampOrderStatus {
  waitingForPartner,
  failure,
  completed,
}

enum OffRampOrderStatus {
  depositTxRequired,
  creatingDepositTx,
  depositTxReady,
  sendingDepositTx,
  depositError,
  depositTxConfirmError,
  waitingForPartner,
  failure,
  completed,
  cancelled,
}
