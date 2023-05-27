import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/bordered_row.dart';
import '../../../../../ui/bottom_button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/theme.dart';

abstract class NoteSetter {
  const NoteSetter();

  void onNoteSubmitted(String name);
}

class RequestNoteScreen extends StatefulWidget {
  const RequestNoteScreen({super.key, required this.amount});

  final Amount amount;

  @override
  State<RequestNoteScreen> createState() => _RequestNoteScreenState();
}

class _RequestNoteScreenState extends State<RequestNoteScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            leading: CpBackButton(onPressed: () => context.router.pop()),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CpBorderedRow(
                title: Text(context.l10n.requestNoteRequesting),
                content: BorderedRowChip(
                  child: Text(
                    widget.amount.format(DeviceLocale.localeOf(context)),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              CpBorderedRow(
                title: Text(context.l10n.requestNoteFor),
                content: Expanded(
                  child: CupertinoTextField(
                    autofocus: true,
                    decoration: const BoxDecoration(),
                    cursorColor: CpColors.yellowColor,
                    placeholder: context.l10n.requestNotePlaceholder,
                    placeholderStyle: const TextStyle(color: Colors.white),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.5,
                      color: Colors.white,
                    ),
                    controller: _controller,
                  ),
                ),
              ),
              const Spacer(),
              CpContentPadding(child: _BottomButton(controller: _controller)),
            ],
          ),
        ),
      );
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) => CpBottomButton(
          text: context.l10n.next,
          onPressed: value.text.isEmpty
              ? null
              : () => context.read<NoteSetter>().onNoteSubmitted(value.text),
        ),
      );
}
