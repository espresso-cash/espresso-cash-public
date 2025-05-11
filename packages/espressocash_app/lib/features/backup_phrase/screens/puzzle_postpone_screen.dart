import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/message_info_widget.dart';
import '../../../utils/routing.dart';
import '../services/puzzle_reminder_bloc.dart';
import '../widgets/puzzle_screen.dart';

class PuzzlePostponeScreen extends StatefulWidget {
  const PuzzlePostponeScreen({super.key});

  static void push(BuildContext context) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (context) => const PuzzlePostponeScreen()));

  @override
  State<PuzzlePostponeScreen> createState() => _PuzzlePostponeScreenState();
}

class _PuzzlePostponeScreenState extends State<PuzzlePostponeScreen> {
  bool _checked = false;
  Duration _duration = const Duration(days: 1);

  List<DropdownMenuItem<Duration?>> get _dropdownItems => [
    DropdownMenuItem(value: const Duration(days: 1), child: Text(context.l10n.tomorrow)),
    DropdownMenuItem(value: const Duration(days: 7), child: Text(context.l10n.oneWeek)),
    DropdownMenuItem(value: const Duration(days: 30), child: Text(context.l10n.oneMonth)),
  ];

  String get _textDuration => switch (_duration.inDays) {
    1 => context.l10n.tomorrow.toUpperCase(),
    7 => context.l10n.oneWeek.toUpperCase(),
    30 => context.l10n.oneMonth.toUpperCase(),
    _ => '',
  };

  void _handleOkPressed(BuildContext context) {
    sl<PuzzleReminderBloc>().add(PuzzleReminderEvent.postponed(postponedBy: _duration));

    context.openFirstScreen();
  }

  @override
  Widget build(BuildContext context) => PuzzleScreen(
    title: context.l10n.protectWalletTitle,
    backButton: const CpBackButton(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          CpMessageInfoWidget(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.all(32),
            content: _Checkbox(
              title: context.l10n.iUnderstandIfLoseMySecret,
              value: _checked,
              onChanged: (bool? value) {
                setState(() {
                  _checked = value ?? false;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: DropdownButton<Duration?>(
                isExpanded: true,
                items: _dropdownItems,
                dropdownColor: CpColors.deepGreyColor,
                icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                selectedItemBuilder:
                    (context) =>
                        _dropdownItems
                            .map(
                              (e) => Center(
                                child: Text(
                                  context.l10n.setReminder(_textDuration),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                            .toList(),
              ),
            ),
          ),
          const SizedBox(height: 36),
          CpButton(
            text: context.l10n.ok,
            size: CpButtonSize.big,
            minWidth: 300,
            onPressed: _checked ? () => _handleOkPressed(context) : null,
          ),
        ],
      ),
    ),
  );
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.title, required this.value, required this.onChanged});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      onChanged(!value);
    },
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: value ? CpColors.yellowColor : const Color(0xff696666),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Transform.scale(
              scale: 1.2,
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Colors.transparent),
                child: Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      onChanged(newValue);
                    }
                  },
                  activeColor: CpColors.yellowColor,
                  checkColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
