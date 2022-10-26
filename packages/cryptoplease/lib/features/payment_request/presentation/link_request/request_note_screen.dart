import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/bordered_row.dart';
import 'package:cryptoplease/ui/bottom_button.dart';
import 'package:cryptoplease/ui/chip.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class NoteSetter {
  void onNoteSubmitted(String name);
}

class RequestNoteScreen extends StatefulWidget {
  const RequestNoteScreen({Key? key, required this.amount}) : super(key: key);

  final Amount amount;

  @override
  State<RequestNoteScreen> createState() => _RequestNoteScreenState();
}

class _RequestNoteScreenState extends State<RequestNoteScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            leading: BackButton(onPressed: () => context.router.pop()),
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
    Key? key,
    required this.controller,
  }) : super(key: key);

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
