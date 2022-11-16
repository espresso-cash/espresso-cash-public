import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../activity.dart';

class ISKPTile extends StatelessWidget {
  const ISKPTile({super.key, required this.activity});

  final ISKPActivity activity;

  // TODO(rhbrunetto): not ready
  @override
  Widget build(BuildContext context) => ActivityTile(
        title: 'Received via link',
        subtitle: context.formatDate(activity.created),
        icon: Assets.icons.outgoing.svg(),
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}
