import 'package:cryptoplease/data/db/db.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

void main() {
  for (int i = 9; i < latestVersion; i++) {
    test('upgrade from v$i to v$latestVersion', () async {
      final SchemaVerifier verifier = SchemaVerifier(GeneratedHelper());
      final connection = await verifier.startAt(i);
      final db = MyDatabase.connect(connection);
      await verifier.migrateAndValidate(db, latestVersion);
      await db.close();
    });
  }
}
