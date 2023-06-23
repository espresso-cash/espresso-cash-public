import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../backup_phrase/data/mnemonic_getter.dart';

class OnboardingModule extends SingleChildStatelessWidget {
  const OnboardingModule({
    super.key,
    super.child,
    required this.mnemonic,
  });

  final Future<String> mnemonic;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<MnemonicGetter>(create: (_) => MnemonicGetter(mnemonic)),
        ],
        child: child,
      );
}
