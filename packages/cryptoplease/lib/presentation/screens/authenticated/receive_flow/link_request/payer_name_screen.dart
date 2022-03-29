import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayerNameScreen extends StatefulWidget {
  const PayerNameScreen({Key? key}) : super(key: key);

  @override
  State<PayerNameScreen> createState() => _PayerNameScreenState();
}

class _PayerNameScreenState extends State<PayerNameScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        isScrollable: false,
        backgroundStyle: BackgroundStyle.light,
        hasAppBarBorder: false,
        backButton: BackButton(onPressed: () => context.router.pop()),
        bottomButton: _BottomButton(controller: _controller),
        child: CpContentPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.receiveFlowPayerNameLabel,
                style: const TextStyle(fontSize: 21),
              ),
              CpTextField(
                placeholder: context.l10n.receiveFlowPayerNamePlaceholder,
                margin: const EdgeInsets.symmetric(vertical: 16),
                border: CpTextFieldBorder.rounded,
                controller: _controller,
              ),
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
              : () => context
                  .read<LinkRequestFlowRouter>()
                  .onNameSubmitted(value.text),
        ),
      );
}
