import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/puzzle_reminder/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PuzzleReminderDialogSetupScreen extends StatefulWidget {
  const PuzzleReminderDialogSetupScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleReminderDialogSetupScreen> createState() =>
      _PuzzleReminderDialogSetupScreenState();
}

class _PuzzleReminderDialogSetupScreenState
    extends State<PuzzleReminderDialogSetupScreen> {
  bool _checked = false;
  Duration _duration = const Duration(days: 1);

  List<DropdownMenuItem<Duration?>> get _dropdownItems => [
        DropdownMenuItem(
          value: const Duration(days: 1),
          child: Text(context.l10n.tomorrow),
        ),
        DropdownMenuItem(
          value: const Duration(days: 7),
          child: Text(context.l10n.oneWeek),
        ),
        DropdownMenuItem(
          value: const Duration(days: 30),
          child: Text(context.l10n.oneMonth),
        ),
      ];

  void _setupReminder(BuildContext context) {
    context.read<PuzzleReminderBloc>().add(
          PuzzleReminderEvent.postponed(postponedBy: _duration),
        );

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    final normalTextStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(color: CpColors.primaryTextColor);

    return AlertDialog(
      title: Text(
        context.l10n.skipWalletProtection,
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        CpButton(
          text: context.l10n.ok,
          width: double.infinity,
          onPressed: _checked ? () => _setupReminder(context) : null,
        ),
        const SizedBox(height: 12),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: const StadiumBorder(),
          ),
          onPressed: () =>
              context.router.replace(const PuzzleReminderDialogMessageRoute()),
          child: Text(context.l10n.back),
        )
      ],
      content: Wrap(
        runSpacing: 20,
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: CpColors.primaryColor,
            onChanged: (bool? value) {
              setState(() {
                _checked = value ?? false;
              });
            },
            value: _checked,
            title: Text(
              context.l10n.iUnderstandIfLoseMySecret,
              style: normalTextStyle,
            ),
          ),
          Text(context.l10n.yesRemindMe, style: normalTextStyle),
          DropdownButton<Duration?>(
            isExpanded: true,
            style: normalTextStyle,
            items: _dropdownItems,
            dropdownColor: Colors.white,
            onChanged: (Duration? value) {
              if (value == null) return;
              setState(() {
                _duration = value;
              });
            },
            value: _duration,
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.all(16),
    );
  }
}
