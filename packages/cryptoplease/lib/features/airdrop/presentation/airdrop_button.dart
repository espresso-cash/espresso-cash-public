import 'package:cryptoplease/features/airdrop/bl/airdrop_bloc.dart';
import 'package:cryptoplease/features/profile/components/profile_button.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirdropButton extends StatelessWidget {
  const AirdropButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<AirdropBloc, AirdropState>(
        buildWhen: (s1, s2) => s1.runtimeType != s2.runtimeType,
        builder: (context, state) => ProfileButton(
          label: context.l10n.airdrop,
          onPressed: state is AirdropStateRequesting
              ? null
              : () => context
                  .read<AirdropBloc>()
                  .add(const AirdropEvent.requested()),
        ),
      );
}
