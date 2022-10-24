import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransactionActivityRepository {
  Future<List<TransactionActivity>> readAll() async {
    final query = _db.select(_db.transactionRetrievedRows)
      ..where(
        (t) => t.status.equalsValue(TransactionRetrievedStatusDto.fetched),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    final result = await query.get();

    return result.map((t) => t.toTransactionRetrieved()).toList();
  }
}
