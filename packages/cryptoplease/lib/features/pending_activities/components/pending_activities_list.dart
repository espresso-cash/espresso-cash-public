import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/pending_activities/components/oksp_tile.dart';
import 'package:cryptoplease/features/pending_activities/components/payment_request_tile.dart';
import 'package:cryptoplease/features/pending_activities/components/styles.dart';
import 'package:cryptoplease/features/pending_activities/pending_activities_repository.dart';
import 'package:cryptoplease/features/pending_activities/pending_activity.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;

class PendingActivitiesList extends StatefulWidget {
  const PendingActivitiesList({
    Key? key,
  }) : super(key: key);

  @override
  State<PendingActivitiesList> createState() => _PendingActivitiesListState();
}

class _PendingActivitiesListState extends State<PendingActivitiesList> {
  late final Stream<IList<PendingActivity>> _stream;

  @override
  void initState() {
    super.initState();

    _stream = sl<PendingActivitiesRepository>().watchAll();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<PendingActivity>>(
        stream: _stream,
        initialData: const IListConst([]),
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, i) {
            // ignore: avoid-non-null-assertion, cannot be null here
            final item = snapshot.data![i];

            return item.map(
              outgoingPaymentRequest: (p) => PaymentRequestTile(id: p.id),
              outgoingDirectPayment: (p) => ListTile(
                title: const Text('Direct payment', style: titleStyle),
                subtitle: Text(p.created.toString(), style: subtitleStyle),
                leading: CircleAvatar(
                  radius: 21,
                  child: Assets.icons.outgoing.svg(),
                ),
              ),
              outgoingSplitKeyPayment: (item) => OSKPTile(activity: item),
            );
          },
          itemCount: snapshot.data?.length ?? 0,
        ),
      );
}
