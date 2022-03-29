import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/onboarding_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/sign_up_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class NoEmailAndPasswordScreen extends StatelessWidget {
  const NoEmailAndPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => OnboardingScreen(
        title: context.l10n.noEmailInCryptoTitle,
        nextLabel: context.l10n.iUnderstand,
        onNextPressed: () =>
            context.read<SignUpRouter>().onExplainNoEmailAndPasswordCompleted(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) => Markdown(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                styleSheet: MarkdownStyleSheet(
                  p: DefaultTextStyle.of(context).style,
                  textAlign: WrapAlignment.center,
                ),
                data: context.l10n.noEmailInCryptoParagraph,
              ),
            ),
          ],
        ),
      );
}
