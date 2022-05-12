import 'package:cryptoplease/bl/activities/activity.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/empty_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/activities/components/activity_list.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<ActivitiesScreen> {
  late final Stream<IList<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = watchActivities(
      outgoingRepository: context.read<OutgoingTransferRepository>(),
      incomingRepository: context.read<SplitKeyIncomingRepository>(),
      paymentRequestRepository: context.read<PaymentRequestRepository>(),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<Activity>>(
        stream: _activities,
        builder: (context, snapshot) {
          final data = snapshot.data ?? const IListConst<Activity>([]);

          return Scaffold(
            appBar: CpAppBar(
              title: Text(context.l10n.activitiesTitle.toUpperCase()),
            ),
            body: data.isEmpty
                ? EmptyWidget(message: context.l10n.emptyActivitiesMessage)
                : ActivityList(activities: data),
          );
        },
      );
}
