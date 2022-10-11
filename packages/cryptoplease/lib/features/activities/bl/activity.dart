import 'package:collection/collection.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  factory Activity.paymentRequest(
    String id, {
    required DateTime created,
  }) = PaymentRequestActivity;

  const Activity._();
}

Stream<IList<Activity>> watchActivities({
  required PaymentRequestRepository paymentRequestRepository,
}) {
  final paymentRequests = paymentRequestRepository.watchAllIds().map(
        (ids) =>
            ids.map((p) => Activity.paymentRequest(p.item1, created: p.item2)),
      );

  return paymentRequests.map(
    (event) => event
        .toIList()
        .sortedBy((element) => element.created)
        .reversed
        .toIList(),
  );
}
