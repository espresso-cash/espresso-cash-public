import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../data/transaction_repository.dart';
import '../models/transaction.dart';

@injectable
class TokenActivitiesRepository {
  const TokenActivitiesRepository(this._repository);

  final TransactionRepository _repository;

  Stream<List<ActivityGroup>> watchTokenActivities(String tokenAddress) =>
      _repository.watchGroupedByDate(tokenAddress).map(_prepareActivityGroups);

  List<ActivityGroup> _prepareActivityGroups(Map<String, IList<TxCommon>> data) {
    final sortedDates = data.keys.toList()..sort((a, b) => b.compareTo(a));

    return sortedDates.map((date) {
      final transactions = data[date] ?? IList<TxCommon>();

      final sortedTxs = transactions.sort((a, b) {
        final aCreated = a.created;
        final bCreated = b.created;

        return (aCreated != null && bCreated != null) ? bCreated.compareTo(aCreated) : 0;
      });

      return ActivityGroup(date: date, transactions: sortedTxs);
    }).toList();
  }
}

class ActivityGroup {
  const ActivityGroup({required this.date, required this.transactions});

  final String date;
  final IList<TxCommon> transactions;
}
