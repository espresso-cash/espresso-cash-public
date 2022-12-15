import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../di.dart';
import '../../../outgoing_split_key_payments/module.dart';
import '../../../outgoing_tip_payments/module.dart';
import '../activity.dart';
import '../pending_activities_repository.dart';
import 'no_activity.dart';
import 'odp_tile.dart';
import 'oksp_tile.dart';
import 'ot_tile.dart';
import 'payment_request_tile.dart';

class PendingActivitiesList extends StatefulWidget {
  const PendingActivitiesList({
    Key? key,
    this.padding,
  }) : super(key: key);

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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<OSKPVerifier>(
            lazy: false,
            create: (_) => sl<OSKPVerifier>(
              param1: context.read<MyAccount>().wallet.publicKey,
            )..init(),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<OTVerifier>(
            lazy: false,
            create: (_) => sl<OTVerifier>()..init(),
            dispose: (_, value) => value.dispose(),
          ),
        ],
        child: StreamBuilder<IList<Activity>>(
          stream: _stream,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) return const SizedBox.shrink();

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
                        outgoingTipPayment: (p) => OTTile(
                          key: ValueKey(p.id),
                          activity: p,
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  );
          },
        ),
      );
}
