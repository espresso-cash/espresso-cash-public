import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/dialogs.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/web_view_screen.dart';
import '../../accounts/services/account_service.dart';
import '../screens/manage_profile_screen.dart';
import 'profile_button.dart';

part 'danger_section.dart';
part 'edit_profile_section.dart';
part 'share_section.dart';
part 'version_section.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    this.title,
    required this.actions,
    this.color = CpColors.blackGreyColor,
    required this.padding,
  });

  final String? title;
  final List<Widget> actions;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final title = this.title;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20, bottom: 10),
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Material(
              color: color,
              child: Padding(
                padding: padding,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: actions),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
