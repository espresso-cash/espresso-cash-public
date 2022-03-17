import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LegalDocumentView(
        content: Assets.markdowns.privacyPolicy,
        title: context.l10n.privacyPolicy,
      );
}

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LegalDocumentView(
        content: Assets.markdowns.termsOfService,
        title: context.l10n.termsOfService,
      );
}

class LegalDocumentView extends StatefulWidget {
  const LegalDocumentView({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  final String content;
  final String title;

  @override
  State<LegalDocumentView> createState() => _LegalDocumentViewState();
}

class _LegalDocumentViewState extends State<LegalDocumentView> {
  late final Future<String> _futureMarkdown =
      rootBundle.loadString(widget.content);

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: _futureMarkdown,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _Content(
              markdown: context.l10n.failToLoadTerms,
              title: widget.title,
            );
          }

          return snapshot.data?.let(
                (data) => _Content(
                  markdown: data,
                  title: widget.title,
                ),
              ) ??
              const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: CpColors.yellowColor,
                  ),
                ),
              );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.markdown,
    required this.title,
  }) : super(key: key);

  final String markdown;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(title: Text(title)),
        body: Markdown(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          data: markdown,
        ),
      );
}
