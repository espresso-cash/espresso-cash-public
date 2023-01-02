// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import 'odp_request.dart';

@injectable
class ODPRequestRepository {
  ODPRequestRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<ODPRequest?> load(String id) {
    final query = _db.select(_db.oDPRequestRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<ODPRequest?> watch(String id) {
    final query = _db.select(_db.oDPRequestRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().map((row) => row?.toModel(_tokens));
  }

  Future<void> save(ODPRequest request) =>
      _db.into(_db.oDPRequestRows).insertOnConflictUpdate(request.toDto());

  Future<void> delete(ODPRequest request) => (_db.delete(_db.oDPRequestRows)
        ..where((tbl) => tbl.id.equals(request.id)))
      .go();

  Future<void> clear() => _db.delete(_db.oDPRequestRows).go();
}

class ODPRequestRows extends Table with AmountMixin, EntityMixin {
  TextColumn get receiver => text()();
  TextColumn get reference => text().nullable()();
  TextColumn get label => text().nullable()();
}

extension ODPRequestRowExt on ODPRequestRow {
  ODPRequest toModel(TokenList tokens) => ODPRequest(
        id: id,
        receiver: Ed25519HDPublicKey.fromBase58(receiver),
        reference: reference?.let(Ed25519HDPublicKey.fromBase58),
        amount: CryptoAmount(
          value: amount,
          currency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        created: created,
        label: label,
      );
}

extension on ODPRequest {
  ODPRequestRow toDto() => ODPRequestRow(
        id: id,
        receiver: receiver.toBase58(),
        reference: reference?.toBase58(),
        amount: amount.value,
        token: amount.currency.token.address,
        created: created,
        label: label,
      );
}
