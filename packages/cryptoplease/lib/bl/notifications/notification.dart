import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  factory Notification.splitKeyIncoming({
    required SplitKeyIncomingFirstPart firstPart,
  }) = SplitKeyIncomingNotification;

  factory Notification.outgoingTransfer(OutgoingTransfer transfer) =
      OutgoingTransferNotification;

  const Notification._();
}

Stream<IList<Notification>> watchNotifications({
  required OutgoingTransferRepository outgoingRepository,
  required SplitKeyIncomingRepository incomingRepository,
}) {
  final outgoing = outgoingRepository
      .watchPayments()
      .map((ps) => ps.map(Notification.outgoingTransfer));

  final incoming = incomingRepository.watch().map(
        (v) => v == null
            ? <Notification>[]
            : [Notification.splitKeyIncoming(firstPart: v)],
      );

  return CombineLatestStream.combine2(
    incoming,
    outgoing,
    (Iterable<Notification> i, Iterable<Notification> o) =>
        [...i, ...o].toIList(),
  );
}
