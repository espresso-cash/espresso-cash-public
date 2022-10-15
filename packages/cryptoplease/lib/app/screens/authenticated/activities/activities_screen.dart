import 'package:cryptoplease/features/pending_activities/components/pending_activities_list.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart' hide Notification;

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: Text(context.l10n.activitiesTitle.toUpperCase()),
        ),
        body: const PendingActivitiesList(),
      );
}
