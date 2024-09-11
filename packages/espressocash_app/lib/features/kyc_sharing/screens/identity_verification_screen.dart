import 'package:flutter/material.dart';

import '../../../ui/button.dart';
import '../../../ui/timeline.dart';
import '../widgets/kyc_page.dart';
import 'kyc_camera_screen.dart';

// TODO(vsumin): fix layout

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  static void push(
    BuildContext context,
  ) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const IdentityVerificationScreen(),
        ),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const IdentityVerificationScreen(),
        ),
      );

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  final _accountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();

  bool get _isValid =>
      _accountNumberController.text.isNotEmpty &&
      _bankCodeController.text.isNotEmpty;

  @override
  void dispose() {
    _accountNumberController.dispose();
    _bankCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Identity verification',
        children: [
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
          const SizedBox(height: 300, child: _Timeline()),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpButton(
              width: double.infinity,
              text: 'Start Selfie Verification',
              onPressed: () {
                KycCameraScreen.pushReplacement(context);
              },
            ),
          ),
        ],
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
