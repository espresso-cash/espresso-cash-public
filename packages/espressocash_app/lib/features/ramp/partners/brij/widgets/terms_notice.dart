import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/web_view_screen.dart';

Future<bool> showTermsAndPolicyDialog(
  BuildContext context, {
  required String termsUrl,
  required String privacyUrl,
}) async =>
    await showCustomDialog<bool?>(
      context,
      title: Text(
        context.l10n.brijTermsAndPolicyTitle,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      message: MarkdownBody(
        data: context.l10n.brijTermsAndPolicyMessage,
        styleSheet: MarkdownStyleSheet(
          textAlign: WrapAlignment.center,
          a: _markdownStyle.copyWith(color: CpColors.yellowColor, fontWeight: FontWeight.w700),
          p: _markdownStyle,
        ),
        onTapLink: (_, href, _) {
          final url = switch (href) {
            'partner-terms' => termsUrl,
            'data-sharing-agreement' => privacyUrl,
            _ => null,
          };

          if (url == null) return;

          WebViewScreen.push(context, url: Uri.parse(url));
        },
      ),
      actions: Row(
        children: [
          Expanded(
            child: CpButton(
              text: context.l10n.core_btnCancel,
              width: 150,
              variant: CpButtonVariant.muted,
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CpButton(
              text: context.l10n.iAgree_btn,
              width: 150,
              onPressed: () => Navigator.pop(context, true),
            ),
          ),
        ],
      ),
    ) ??
    false;

final _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  height: 1,
);
