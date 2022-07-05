import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  factory Activity.splitKeyIncoming({
    required SplitKeyIncomingFirstPart firstPart,
  }) = SplitKeyIncomingActivity;

  factory Activity.outgoingTransfer(OutgoingTransfer transfer) =
      OutgoingTransferActivity;

  factory Activity.paymentRequest(
    String id, {
    required DateTime created,
  }) = PaymentRequestActivity;

  const Activity._();

  DateTime? get created => this.map(
        splitKeyIncoming: always(null),
        outgoingTransfer: (a) => a.transfer.created,
        paymentRequest: (a) => a.created,
      );
}

Stream<IList<Activity>> watchActivities({
  required OutgoingTransferRepository outgoingRepository,
  required SplitKeyIncomingRepository incomingRepository,
  required PaymentRequestRepository paymentRequestRepository,
}) {
  final outgoing = outgoingRepository
      .watchPayments()
      .map((ps) => ps.map(Activity.outgoingTransfer));

  final incoming = incomingRepository.watch().map(
        (v) => v == null
            ? <Activity>[]
            : [Activity.splitKeyIncoming(firstPart: v)],
      );

  final paymentRequests = paymentRequestRepository.watchAllIds().map(
        (ids) =>
            ids.map((p) => Activity.paymentRequest(p.item1, created: p.item2)),
      );

  return CombineLatestStream.combine3(
    incoming,
    paymentRequests,
    outgoing,
    (Iterable<Activity> i, Iterable<Activity> p, Iterable<Activity> o) => [
      ...i,
      // ignore: avoid-non-null-assertion, outgoing payments and requests should have created field
      ...IList([...p, ...o]).sortedBy((e) => e.created!).reversed,
    ].toIList(),
  );
}
