import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class AccountEdit extends StatefulWidget {
  const AccountEdit({
    super.key,
    required this.authToken,
    required this.account,
  });

  final AuthToken authToken;
  final Account account;

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final _controller = TextEditingController();

  void _onSubmit() {
    context
        .read<SeedVaultBloc>()
        .updateAccountName(
          authToken: widget.authToken,
          account: widget.account,
          name: _controller.text,
        )
        .then(
      (it) {
        Navigator.of(context).pop();
        showSnackBar(context, it.map(always('Account name updated')));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Name this account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
