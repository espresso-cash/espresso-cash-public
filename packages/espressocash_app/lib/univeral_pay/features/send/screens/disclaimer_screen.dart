// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import '../../../../ui/button.dart';
import '../../../core/disclaimer.dart';
import '../../../core/page.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import 'send_screen.dart';

@RoutePage()
class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  static const route = DisclaimerRoute.new;

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  bool _isAccepted = false;
  @override
  Widget build(BuildContext context) => PageWidget(
        children: [
          DisclaimerCheckbox(
            value: _isAccepted,
            onChanged: (value) {
              setState(() {
                _isAccepted = value;
              });
            },
          ),
          const SizedBox(height: 32),
          CpButton(
            onPressed: _isAccepted
                ? () {
                    final uri = Uri.parse(html.window.location.toString());
                    final solanaPay = tryParseUniversalPayRequest(uri);

                    context.router.replace(
                      SenderInitialScreen.route(
                        request: solanaPay!,
                      ),
                    );
                  }
                : null,
            text: 'Continue',
            size: CpButtonSize.big,
            width: 450,
          ),
        ],
      );
}
