import 'package:drift/drift.dart';

import '../../core/transactions/tx_sender.dart';

mixin AmountMixin on Table {
  IntColumn get amount => integer()();
  TextColumn get token => text()();
}

mixin EntityMixin on Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// TODO(rhbrunetto): use it on other entities
mixin TxStatusMixin on Table {
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get slot => text().nullable()();
}
