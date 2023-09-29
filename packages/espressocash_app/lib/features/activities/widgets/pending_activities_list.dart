import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;

import '../../../di.dart';
import '../data/pending_activities_repository.dart';
import '../models/activity.dart';
import 'no_activity.dart';
import 'odp_tile.dart';
import 'olp_tile.dart';
import 'on_ramp_tile.dart';
import 'oskp_tile.dart';
import 'payment_request_tile.dart';
import 'swap_tile.dart';

class PendingActivitiesList extends StatefulWidget {
  const PendingActivitiesList({
    super.key,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;

  @override
  State<PendingActivitiesList> createState() => _PendingActivitiesListState();
}

class _PendingActivitiesListState extends State<PendingActivitiesList> {
  late final Stream<IList<Activity>> _stream;

  @override
  void initState() {
    super.initState();

    _stream = sl<PendingActivitiesRepository>().watchAll();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<Activity>>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) return const NoActivity();

          return data.isEmpty
              ? const Center(child: NoActivity())
              : ListView.builder(
                  padding: widget.padding,
                  itemBuilder: (context, i) {
                    // ignore: avoid-non-null-assertion, cannot be null here
                    final item = snapshot.data![i];

                    return item.map(
                      outgoingPaymentRequest: (p) => PaymentRequestTile(
                        key: ValueKey(p.id),
                        id: p.id,
                      ),
                      outgoingDirectPayment: (p) => ODPTile(
                        key: ValueKey(p.id),
                        activity: p,
                      ),
                      outgoingSplitKeyPayment: (p) => OSKPTile(
                        key: ValueKey(p.id),
                        activity: p,
                      ),
                      outgoingLinkPayment: (p) => OLPTile(
                        key: ValueKey(p.id),
                        activity: p,
                      ),
                      swap: (p) => SwapTile(
                        key: ValueKey(p.id),
                        activity: p,
                      ),
                      onRamp: (it) => OnRampTile(
                        key: ValueKey(it.id),
                        activity: it,
                      ),
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0,
                );
        },
      );
}
