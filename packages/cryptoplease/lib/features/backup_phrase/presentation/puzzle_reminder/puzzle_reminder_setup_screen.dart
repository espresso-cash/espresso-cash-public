import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/decorated_window.dart';
import 'package:cryptoplease/app/components/info_widget.dart';
import 'package:cryptoplease/features/backup_phrase/bl/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PuzzleReminderSetupScreen extends StatefulWidget {
  const PuzzleReminderSetupScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleReminderSetupScreen> createState() =>
      _PuzzleReminderSetupScreenState();
}

class _PuzzleReminderSetupScreenState extends State<PuzzleReminderSetupScreen> {
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

  String get _getTextDuration {
    switch (_duration.inDays) {
      case 1:
        return context.l10n.tomorrow.toUpperCase();
      case 7:
        return context.l10n.oneWeek.toUpperCase();
      case 30:
        return context.l10n.oneMonth.toUpperCase();
      default:
        return '';
    }
  }

  void _setupReminder(BuildContext context) {
    context.read<PuzzleReminderBloc>().add(
          PuzzleReminderEvent.postponed(postponedBy: _duration),
        );

    context.router.parent<StackRouter>()?.popUntilRoot();
  }

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        title: context.l10n.protectWalletTitle,
        hasLogo: true,
        backButton: BackButton(onPressed: () => context.router.pop()),
        backgroundStyle: BackgroundStyle.dark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              MessageInfoWidget(
                padding: const EdgeInsets.all(32),
                content: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: CpColors.yellowColor,
                  onChanged: (bool? value) {
                    setState(() {
                      _checked = value ?? false;
                    });
                  },
                  value: _checked,
                  checkColor: Colors.black,
                  checkboxShape: const RoundedRectangleBorder(
                    side: BorderSide(width: 20),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  title: Text(
                    context.l10n.iUnderstandIfLoseMySecret,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: CpColors.darkBackground,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Center(
                    child: DropdownButton<Duration?>(
                      isExpanded: true,
                      items: _dropdownItems,
                      dropdownColor: CpColors.darkBackground,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                      ),
                      iconSize: 32,
                      alignment: Alignment.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      underline: const SizedBox(),
                      onChanged: (Duration? value) {
                        if (value == null) return;
                        setState(() {
                          _duration = value;
                        });
                      },
                      value: _duration,
                      selectedItemBuilder: (context) => _dropdownItems
                          .map(
                            (e) => Center(
                              child: Text(
                                'SET A REMINDER FOR $_getTextDuration',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              CpButton(
                text: context.l10n.ok,
                size: CpButtonSize.big,
                minWidth: 300,
                onPressed: _checked ? () => _setupReminder(context) : null,
              ),
            ],
          ),
        ),
      );
}
