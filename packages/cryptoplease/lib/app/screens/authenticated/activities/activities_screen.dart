import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/pending_activities/components/pending_activities_list.dart';
import 'package:cryptoplease/features/pending_activities/pending_activities_repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Provider<PendingActivitiesRepository>(
        create: (context) =>
            PendingActivitiesRepository(context.read<MyDatabase>()),
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.activitiesTitle.toUpperCase()),
          ),
          body: const PendingActivitiesList(),
        ),
      );
}
