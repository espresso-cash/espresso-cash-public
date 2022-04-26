import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/data/db/open_connection.dart';
import 'package:drift/drift.dart';

part 'db.g.dart';

class OutgoingTransferRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get data => text()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

class PaymentRequestRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();
  TextColumn get payerName => text()();
  TextColumn get dynamicLink => text()();
  IntColumn get state => intEnum<PaymentRequestState>()();

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

const int latestVersion = 13;

@DriftDatabase(tables: [OutgoingTransferRows, PaymentRequestRows])
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
        },
      );
}
