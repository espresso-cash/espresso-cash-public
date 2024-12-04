import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../models/activity.dart';
import '../services/pending_activities_repository.dart';
import 'kyc_tile.dart';
import 'no_activity.dart';
import 'odp_tile.dart';
import 'off_ramp_tile.dart';
import 'olp_tile.dart';
import 'on_ramp_tile.dart';
import 'outgoing_dln_tile.dart';
import 'payment_request_tile.dart';
import 'tr_tile.dart';

class PendingActivitiesList extends StatefulWidget {
  const PendingActivitiesList({
    super.key,
    this.padding,
    required this.onSendMoneyPressed,
  });

  final EdgeInsetsGeometry? padding;
  final VoidCallback onSendMoneyPressed;

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
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, userData, _) => StreamBuilder<IList<Activity>>(
          stream: _stream,
          builder: (context, snapshot) {
            final data = snapshot.data;
            final showKyc = sl<KycSharingService>().showKycTile;

            if (data == null) {
              return NoActivity(onSendMoneyPressed: widget.onSendMoneyPressed);
            }

            return data.isEmpty
                ? Center(
                    child: NoActivity(
                      onSendMoneyPressed: widget.onSendMoneyPressed,
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: widget.padding,
                    itemBuilder: (context, index) {
                      if (showKyc && index == 0) {
                        return const KycTile(title: 'KYC');
                      }

                      // ignore: avoid-non-null-assertion, cannot be null here
                      final item = snapshot.data![showKyc ? index - 1 : index];

                      return item.map(
                        outgoingPaymentRequest: (p) => PaymentRequestTile(
                          key: ValueKey(p.id),
                          id: p.id,
                        ),
                        outgoingDirectPayment: (p) => ODPTile(
                          key: ValueKey(p.id),
                          activity: p,
                        ),
                        outgoingLinkPayment: (p) => OLPTile(
                          key: ValueKey(p.id),
                          activity: p,
                        ),
                        onRamp: (it) => OnRampTile(
                          key: ValueKey(it.id),
                          activity: it,
                        ),
                        offRamp: (it) => OffRampTile(
                          key: ValueKey(it.id),
                          activity: it,
                        ),
                        outgoingDlnPayment: (it) => OutgoingDlnTile(
                          key: ValueKey(it.id),
                          activity: it,
                        ),
                        transactionRequest: (it) => TrTile(
                          key: ValueKey(it.id),
                          activity: it,
                        ),
                      );
                    },
                    itemCount: data.length + (showKyc ? 1 : 0),
                  );
          },
        ),
      );
}
