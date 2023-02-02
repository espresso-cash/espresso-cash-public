import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../core/file_manager.dart';
import '../../di.dart';
import '../backup_phrase/mnemonic_getter.dart';
import 'src/bl/onboarding_bloc.dart';

class OnboardingModule extends SingleChildStatelessWidget {
  const OnboardingModule({
    Key? key,
    Widget? child,
    required this.mnemonic,
  }) : super(key: key, child: child);

  final Future<String> mnemonic;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => OnboardingBloc(
              sl<FileManager>(),
              context.read<AccountsBloc>(),
            ),
          ),
          Provider<MnemonicGetter>(create: (_) => MnemonicGetter(mnemonic)),
        ],
        child: child,
      );
}
