import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../di.dart';
import 'open_connection.dart';

part 'db_landing.g.dart';

const _tables = [
  IncomingDlnPaymentRows,
];

const int latestVersion = 1;

@lazySingleton
@DriftDatabase(tables: _tables)
class LandingDatabase extends _$LandingDatabase {
  @factoryMethod
  LandingDatabase() : super(openConnection());

  @override
  int get schemaVersion => latestVersion;
}

enum BlockchainDto {
  arbitrum,
  polygon,
  ethereum,
}

enum PaymentStatus {
  txSent,
  txFailure,
  success,
  unfulfilled,
}

class IncomingDlnPaymentRows extends Table with EntityMixin {
  const IncomingDlnPaymentRows();

  // EVM
  TextColumn get senderBlockchain => textEnum<BlockchainDto>()();
  TextColumn get senderAddress => text()();
  TextColumn get txId => text()();

  // Solana
  TextColumn get receiverAddress => text()();
  TextColumn get receiverReference => text().nullable()();
  TextColumn get receiverName => text().nullable()();
  IntColumn get requestAmount => integer()();

  // DLN
  TextColumn get orderId => text().nullable()();
  IntColumn get status => intEnum<PaymentStatus>()();
  IntColumn get feeAmount => integer()();
}

mixin EntityMixin on Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
