import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
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

  const Activity._();
}

Stream<IList<Activity>> watchActivities({
  required OutgoingTransferRepository outgoingRepository,
  required SplitKeyIncomingRepository incomingRepository,
}) {
  final outgoing = outgoingRepository
      .watchPayments()
      .map((ps) => ps.map(Activity.outgoingTransfer));

  final incoming = incomingRepository.watch().map(
        (v) => v == null
            ? <Activity>[]
            : [Activity.splitKeyIncoming(firstPart: v)],
      );

  return CombineLatestStream.combine2(
    incoming,
    outgoing,
    (Iterable<Activity> i, Iterable<Activity> o) => [...i, ...o].toIList(),
  );
}
