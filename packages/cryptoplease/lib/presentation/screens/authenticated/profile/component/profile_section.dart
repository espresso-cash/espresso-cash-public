import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/puzzle_reminder/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/airdrop_button.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/profile_button.dart';
import 'package:cryptoplease/presentation/utils.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

part 'about_section.dart';
part 'danger_section.dart';
part 'debug_section.dart';
part 'edit_profile_section.dart';
part 'security_section.dart';
part 'version_section.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
    required this.title,
    required this.actions,
    this.color = CpColors.primaryTextColor,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
              textAlign: TextAlign.left,
            ),
          ),
          ...actions,
        ],
      );
}
