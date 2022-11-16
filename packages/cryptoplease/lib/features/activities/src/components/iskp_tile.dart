import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../activity.dart';
import 'styles.dart';

class ISKPTile extends StatelessWidget {
  const ISKPTile({super.key, required this.activity});

  final ISKPActivity activity;

  // TODO(rhbrunetto): not ready
  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: const [
            Expanded(
              child: Text(
                'Received via link',
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              context.formatDate(activity.created),
              style: subtitleStyle,
            ),
          ],
        ),
        leading: Assets.icons.outgoing.svg(),
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}
