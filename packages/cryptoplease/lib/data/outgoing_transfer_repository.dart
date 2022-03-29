import 'dart:convert';

import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class DbOutgoingTransferRepository implements OutgoingTransferRepository {
  DbOutgoingTransferRepository(this.db);

  final MyDatabase db;

  @override
  Future<OutgoingTransfer> getById(String id) async {
    final request = db.select(db.outgoingTransferRows)
      ..where((tbl) => tbl.id.equals(id));
    final value = await request.getSingle();

    return value.toPayment();
  }

  @override
  Future<void> save(OutgoingTransfer payment) async {
    final row = payment.toRow();
    await db.into(db.outgoingTransferRows).insertOnConflictUpdate(row);
  }

  @override
  Stream<OutgoingTransfer> watchPayment(String id) {
    final request = db.select(db.outgoingTransferRows)
      ..where((tbl) => tbl.id.equals(id));

    return request.watchSingle().map((value) => value.toPayment());
  }

  @override
  Stream<IList<OutgoingTransfer>> watchPayments() {
    final request = db.select(db.outgoingTransferRows)
      ..orderBy([
        (u) => OrderingTerm(
              expression: u.created,
              mode: OrderingMode.desc,
            ),
      ]);

    return request
        .watch()
        .map((rows) => rows.map((row) => row.toPayment()).toIList());
  }

  @override
  Future<void> addFirstLink(String id, Uri link) => db.transaction(() async {
        final payment = await getById(id);
        await payment.map(
          splitKey: (payment) => save(payment.copyWith(firstLink: link)),
          direct: (_) async {},
        );
      });

  @override
  Future<void> clear() => db.delete(db.outgoingTransferRows).go();
}

extension on OutgoingTransfer {
  OutgoingTransferRow toRow() => OutgoingTransferRow(
        id: id,
        created: created,
        data: json.encode(toJson()),
      );
}

extension on OutgoingTransferRow {
  OutgoingTransfer toPayment() => OutgoingTransfer.fromJson(
        json.decode(data) as Map<String, dynamic>,
      );
}
