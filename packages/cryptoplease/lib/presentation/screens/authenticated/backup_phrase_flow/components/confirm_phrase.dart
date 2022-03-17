import 'package:cryptoplease/presentation/components/recovery_phrase_text_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/components/grid_phrase.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class ConfirmPhrase extends StatefulWidget {
  const ConfirmPhrase({
    Key? key,
    required this.correctPhrase,
    required this.currentPhrase,
    required this.onPhraseChanged,
  }) : super(key: key);

  final String correctPhrase;
  final String currentPhrase;
  final void Function(String value) onPhraseChanged;

  @override
  _ConfirmPhraseState createState() => _ConfirmPhraseState();
}

class _ConfirmPhraseState extends State<ConfirmPhrase> {
  void _handleGridClick(String phrase) {
    widget.onPhraseChanged(phrase);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          RecoveryPhraseTextView(
            phrase: widget.currentPhrase,
            backgroundColor: CpColors.lightGreyBackground,
            hasCopyButton: false,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: GridPhrase(
                correctPhrase: widget.correctPhrase,
                callback: _handleGridClick,
              ),
            ),
          ),
        ],
      );
}
