import 'package:collection/collection.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  factory Activity.outgoingTransfer(OutgoingTransfer transfer) =
      OutgoingTransferActivity;

  factory Activity.paymentRequest(
    String id, {
    required DateTime created,
  }) = PaymentRequestActivity;

  const Activity._();

  DateTime? get created => map(
        outgoingTransfer: (a) => a.transfer.created,
        paymentRequest: (a) => a.created,
      );
}

Stream<IList<Activity>> watchActivities({
  required OutgoingTransferRepository outgoingRepository,
  required PaymentRequestRepository paymentRequestRepository,
}) {
  final outgoing = outgoingRepository
      .watchPayments()
      .map((ps) => ps.map(Activity.outgoingTransfer));

  final paymentRequests = paymentRequestRepository.watchAllIds().map(
        (ids) =>
            ids.map((p) => Activity.paymentRequest(p.item1, created: p.item2)),
      );

  return CombineLatestStream.combine2(
    paymentRequests,
    outgoing,
    (Iterable<Activity> p, Iterable<Activity> o) => [
      // ignore: avoid-non-null-assertion, outgoing payments and requests should have created field
      ...IList([...p, ...o]).sortedBy((e) => e.created!).reversed,
    ].toIList(),
  );
}
