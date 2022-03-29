import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

void showClipboardSnackbar(BuildContext context) => showCpSnackbar(
      context,
      message: context.l10n.copiedToClipboard,
      icon: const Icon(Icons.check, color: Colors.green),
    );
