import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/components/confirm_phrase.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/decorated_window/decorated_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackupConfirmPhraseScreen extends StatefulWidget {
  const BackupConfirmPhraseScreen({
    Key? key,
    required this.correctPhrase,
  }) : super(key: key);

  final String correctPhrase;

  @override
  State<BackupConfirmPhraseScreen> createState() =>
      _BackupConfirmPhraseScreenState();
}

class _BackupConfirmPhraseScreenState extends State<BackupConfirmPhraseScreen> {
  String _currentPhrase = '';

  void _onConfirmed() {
    context.read<BackupPhraseRouter>().onConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    final correctPhrase = widget.correctPhrase;

    return DecoratedWindow(
      isScrollable: false,
      hasLogo: true,
      backgroundStyle: BackgroundStyle.dark,
      message: context.l10n.completeThePuzzle,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: CpContentPadding(
              bottom: false,
              child: ConfirmPhrase(
                correctPhrase: correctPhrase,
                currentPhrase: _currentPhrase,
                onPhraseChanged: (phrase) =>
                    setState(() => _currentPhrase = phrase),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                CpButton(
                  text: context.l10n.next,
                  size: CpButtonSize.big,
                  minWidth: 300,
                  onPressed:
                      _currentPhrase == correctPhrase ? _onConfirmed : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
