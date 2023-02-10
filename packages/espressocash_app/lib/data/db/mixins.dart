import 'package:drift/drift.dart';

mixin AmountMixin on Table {
  IntColumn get amount => integer()();
  TextColumn get token => text()();
}

mixin EntityMixin on Table {
  TextColumn get id => text()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
