import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/components/confirm_phrase.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackupConfirmPhraseScreen extends StatefulWidget {
  const BackupConfirmPhraseScreen({
    Key? key,
    required this.correctPhrase,
  }) : super(key: key);

  final String correctPhrase;

  @override
  _BackupConfirmPhraseScreenState createState() =>
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
      hasAppBarBorder: false,
      isScrollable: false,
      backgroundStyle: BackgroundStyle.light,
      title: context.l10n.didYouWriteItDownCorrectly,
      message: context.l10n.completeThePuzzle,
      bottomButton: CpBottomButton(
        text: context.l10n.next,
        onPressed: _currentPhrase == correctPhrase ? _onConfirmed : null,
      ),
      child: CpContentPadding(
        bottom: false,
        child: ConfirmPhrase(
          correctPhrase: correctPhrase,
          currentPhrase: _currentPhrase,
          onPhraseChanged: (phrase) => setState(() => _currentPhrase = phrase),
        ),
      ),
    );
  }
}
