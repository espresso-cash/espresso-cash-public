import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/activities/activity.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    Key? key,
    required this.activities,
  }) : super(key: key);

  final IList<Activity> activities;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, i) => activities[i].map(
          outgoingTransfer: (n) => _SKOutgoingTile(transfer: n.transfer),
          splitKeyIncoming: (n) => _SKIncomingTile(activitiy: n),
        ),
        itemCount: activities.length,
      );
}

class _SKIncomingTile extends StatelessWidget {
  const _SKIncomingTile({
    Key? key,
    required this.activitiy,
  }) : super(key: key);

  final SplitKeyIncomingActivity activitiy;

  void _onTap(BuildContext context) {
    final event = SplitKeyIncomingPaymentEvent.firstPartAdded(
      firstPart: activitiy.firstPart,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.splitKeyIncomingNotificationTitle;
    final subTitle = context.l10n.splitKeyIncomingNotificationSubtitle;

    return ListTile(
      onTap: () => _onTap(context),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: CpColors.yellowColor,
        child: Assets.icons.incoming.svg(),
      ),
      title: Text(title, style: _titleStyle),
      subtitle: Text(
        subTitle,
        style:
            const TextStyle(fontSize: 13, color: CpColors.secondaryTextColor),
      ),
    );
  }
}

class _SKOutgoingTile extends StatelessWidget {
  const _SKOutgoingTile({Key? key, required this.transfer}) : super(key: key);

  final OutgoingTransfer transfer;

  void _onTap(BuildContext context) =>
      context.router.navigate(OutgoingTransferFlowRoute(id: transfer.id));

  @override
  Widget build(BuildContext context) {
    final amount = transfer.tokenType == OutgoingTransferTokenType.fungibleToken
        ? transfer.toAmount().format(DeviceLocale.localeOf(context))
        : 'NFT';
    final title = transfer.state.map(
      draft: always(
        context.l10n.splitKeyOutgoingDraftNotificationTitle(amount),
      ),
      ready: always(context.l10n.splitKeyOutgoingSentNotificationTitle(amount)),
    );
    final subtitle = transfer.map(
      splitKey: always(context.l10n.splitKeyOutgoingNotificationSubtitle),
      direct: always(context.l10n.directOutgoingNotificationSubtitle),
    );

    return ListTile(
      onTap: () => _onTap(context),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: CpColors.purple,
        child: Assets.icons.outgoing.svg(),
      ),
      title: Text(title, style: _titleStyle),
      subtitle: Text(subtitle, style: _subtitleStyle),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 18,
  color: CpColors.primaryTextColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 13,
  color: CpColors.secondaryTextColor,
);
