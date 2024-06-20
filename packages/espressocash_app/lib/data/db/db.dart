import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../features/activities/models/transaction.dart';
import '../../features/incoming_link_payments/data/ilp_repository.dart';
import '../../features/outgoing_direct_payments/data/repository.dart';
import '../../features/outgoing_link_payments/data/repository.dart';
import '../../features/payment_request/data/repository.dart';
import '../../features/ramp_partner/models/ramp_partner.dart';
import '../../features/transactions/models/tx_results.dart';
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

const int latestVersion = 54;

const _tables = [
  OutgoingTransferRows,
  PaymentRequestRows,
  ODPRows,
  TransactionRows,
  OLPRows,
  ILPRows,
  OnRampOrderRows,
  OffRampOrderRows,
  OutgoingDlnPaymentRows,
  TransactionRequestRows,
  TokenBalanceRows,
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
          if (from >= 37 && from < 45) {
            await m.addColumn(onRampOrderRows, onRampOrderRows.bankName);
            await m.addColumn(onRampOrderRows, onRampOrderRows.bankAccount);
            await m.addColumn(
              onRampOrderRows,
              onRampOrderRows.bankTransferExpiry,
            );
            await m.addColumn(
              onRampOrderRows,
              onRampOrderRows.bankTransferAmount,
            );
            await m.addColumn(onRampOrderRows, onRampOrderRows.fiatSymbol);
          }
          if (from >= 39 && from < 46) {
            await m.addColumn(iLPRows, iLPRows.feeAmount);
          }
          if (from < 47) {
            await m.createTable(outgoingDlnPaymentRows);
          }
          if (from >= 40 && from < 48) {
            await m.addColumn(offRampOrderRows, offRampOrderRows.feeAmount);
            await m.addColumn(offRampOrderRows, offRampOrderRows.feeToken);
          }
          if (from < 49) {
            await m.createTable(transactionRequestRows);
          }
          if (from < 50) {
            await m.addColumn(
              paymentRequestRows,
              paymentRequestRows.resolvedAt,
            );
            await m.addColumn(paymentRequestRows, paymentRequestRows.shortLink);
          }
          if (from < 51) {
            await m.addColumn(transactionRows, transactionRows.amount);
          }

          if (from < 52) {
            await m.createTable(tokenBalanceRows);
          }

          if (from < 53) {
            await m.addColumn(onRampOrderRows, onRampOrderRows.authToken);
            await m.addColumn(onRampOrderRows, onRampOrderRows.moreInfoUrl);
            await m.addColumn(onRampOrderRows, onRampOrderRows.stellarTxHash);
          }

          if (from < 54) {
            await m.addColumn(offRampOrderRows, offRampOrderRows.authToken);
            await m.addColumn(offRampOrderRows, offRampOrderRows.moreInfoUrl);
            await m.addColumn(offRampOrderRows, offRampOrderRows.withdrawMemo);
            await m.addColumn(offRampOrderRows, offRampOrderRows.withdrawUrl);
            await m.addColumn(
              offRampOrderRows,
              offRampOrderRows.withdrawAnchorAccount,
            );
            await m.addColumn(
              offRampOrderRows,
              offRampOrderRows.solanaBridgeTx,
            );
          }
        },
      );
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
  TextColumn get bankName => text().nullable()();
  TextColumn get bankAccount => text().nullable()();
  DateTimeColumn get bankTransferExpiry => dateTime().nullable()();
  IntColumn get bankTransferAmount => integer().nullable()();
  TextColumn get fiatSymbol => text().nullable()();

  // Moneygram
  TextColumn get authToken => text().nullable()();
  TextColumn get moreInfoUrl => text().nullable()();
  TextColumn get stellarTxHash => text().nullable()();
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
  IntColumn get feeAmount => integer().nullable()();
  TextColumn get feeToken => text().nullable()();

  // Moneygram
  TextColumn get authToken => text().nullable()();
  TextColumn get withdrawAnchorAccount => text().nullable()();
  TextColumn get withdrawMemo => text().nullable()();
  TextColumn get withdrawUrl => text().nullable()();
  TextColumn get moreInfoUrl => text().nullable()();

  TextColumn get solanaBridgeTx => text().nullable()();
}

enum OnRampOrderStatus {
  pending,
  preProcessing,
  waitingForDeposit,
  depositExpired,
  waitingForPartner,
  postProcessing,
  failure,
  completed,
}

enum OffRampOrderStatus {
  preProcessing,
  postProcessing,
  depositTxRequired,
  creatingDepositTx,
  depositTxReady,
  sendingDepositTx,
  depositError,
  depositTxConfirmError,
  waitingForPartner,
  failure,
  refunded,
  completed,
  cancelled,
  insufficientFunds,
}

class OutgoingDlnPaymentRows extends Table with EntityMixin, TxStatusMixin {
  const OutgoingDlnPaymentRows();

  TextColumn get receiverBlockchain => textEnum<BlockchainDto>()();
  TextColumn get receiverAddress => text()();
  IntColumn get amount => integer()();
  IntColumn get status => intEnum<ODLNPaymentStatusDto>()();

  TextColumn get orderId => text().nullable()();
}

enum BlockchainDto {
  solana,
  arbitrum,
  polygon,
  ethereum,
}

enum ODLNPaymentStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  fulfilled,
  unfulfilled,
}

class TransactionRows extends Table {
  const TransactionRows();

  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TxCommonStatus>()();
  IntColumn get amount => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TransactionRequestRows extends Table with AmountMixin, EntityMixin {
  const TransactionRequestRows();

  TextColumn get label => text()();
  TextColumn get transaction => text()();
  Int64Column get slot => int64()();
  TextColumn get status => textEnum<TRStatusDto>()();
}

enum TRStatusDto {
  created,
  sent,
  success,
  failure,
}

class TokenBalanceRows extends Table with AmountMixin {
  const TokenBalanceRows();

  @override
  Set<Column> get primaryKey => {token};
}
