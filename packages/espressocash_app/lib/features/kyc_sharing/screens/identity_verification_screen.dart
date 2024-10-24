import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/theme.dart';
import '../../../ui/timeline.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const IdentityVerificationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text('Identity verification'.toUpperCase()),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Assets.images.profileGraphic.image(height: 80),
                  const SizedBox(height: 20),
                  const Text(
                    'For security purposes, we need you to take a quick selfie to verify your identity.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 21 / 16,
                      letterSpacing: .19,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Expanded(child: _Timeline()),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CpButton(
                      width: double.infinity,
                      text: 'Start Selfie Verification',
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    const items = [
      CpTimelineItem(
        subtitle: 'Make sure your face is clearly visible.',
      ),
      CpTimelineItem(
        subtitle: 'Avoid hats, sunglasses, or other facial coverings.',
      ),
      CpTimelineItem(
        subtitle: 'Good lighting helps us verify your identity quickly!',
      ),
    ];

    return CpTimeline(
      status: CpTimelineStatus.inProgress,
      items: items,
      active: items.length - 1,
      animated: false,
    );
  }
}
