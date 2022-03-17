import 'package:cryptoplease/bl/notifications/notification.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/empty_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/notifications/components/notification_list.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsScreen> {
  late final Stream<IList<Notification>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = watchNotifications(
      outgoingRepository: context.read<OutgoingTransferRepository>(),
      incomingRepository: context.read<SplitKeyIncomingRepository>(),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<Notification>>(
        stream: _notifications,
        builder: (context, snapshot) {
          final data = snapshot.data ?? const IListConst<Notification>([]);

          return Scaffold(
            appBar: CpAppBar(
              title: Text(context.l10n.activitiesTitle.toUpperCase()),
            ),
            body: data.isEmpty
                ? EmptyWidget(message: context.l10n.emptyNotificationsMessage)
                : NotificationList(notifications: data),
          );
        },
      );
}
