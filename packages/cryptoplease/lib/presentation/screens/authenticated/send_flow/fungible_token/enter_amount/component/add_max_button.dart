import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/token/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMaxButton extends StatelessWidget {
  const AddMaxButton({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => CpButton(
        text: 'MAX',
        variant: CpButtonVariant.light,
        onPressed: () => context
            .read<FtCreateOutgoingTransferBloc>()
            .add(const FtCreateOutgoingTransferEvent.maxRequested()),
      );
}
