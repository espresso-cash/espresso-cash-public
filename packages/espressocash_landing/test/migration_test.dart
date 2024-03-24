// ignore: match-lib-folder-structure, false positive
import 'package:drift_dev/api/migrations.dart';
import 'package:espressocash_landing/data/db/db.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

void main() {
  for (int i = 1; i <= latestVersion; i++) {
    test('upgrade from v$i to v$latestVersion', () async {
      final SchemaVerifier verifier = SchemaVerifier(GeneratedHelper());
      final connection = await verifier.startAt(i);
      final db = LandingDatabase.connect(connection);
      await verifier.migrateAndValidate(db, latestVersion);
      await db.close();
    });
  }
}
