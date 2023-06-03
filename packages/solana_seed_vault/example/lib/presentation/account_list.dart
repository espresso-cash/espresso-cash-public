import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/account_edit.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class AccountList extends StatelessWidget {
  const AccountList({
    super.key,
    required this.authToken,
    required this.accounts,
  });

  final AuthToken authToken;
  final List<Account> accounts;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accounts.length,
        itemBuilder: (context, index) => AccountItem(
          account: accounts.elementAt(index),
          authToken: authToken,
        ),
      );
}

class AccountItem extends StatefulWidget {
  const AccountItem({
    super.key,
    required this.account,
    required this.authToken,
  });

  final Account account;
  final AuthToken authToken;

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  void _onEditAccount() {
    showDialog<void>(
      context: context,
      builder: (context) => AccountEdit(
        authToken: widget.authToken,
        account: widget.account,
      ),
    );
  }

  void _onSignTransaction() {
    context
        .read<SeedVaultBloc>()
        .signTransactionWithAccount(widget.authToken, widget.account)
        .then((it) => showSnackBar(context, it));
  }

  void _onSignMessage() {
    context
        .read<SeedVaultBloc>()
        .signMessageWithAccount(widget.authToken, widget.account)
        .then((it) => showSnackBar(context, it));
  }

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Account: ${widget.account.name}',
                      style: _style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: _onEditAccount,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'PublicKey: ${widget.account.publicKeyEncoded.shortened}',
                style: _style,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              Text(
                'Path: ${widget.account.derivationPath}',
                style: _style,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sign a: ', style: _style),
                  ElevatedButton(
                    onPressed: _onSignTransaction,
                    child: const Text('Transaction', style: _style),
                  ),
                  ElevatedButton(
                    onPressed: _onSignMessage,
                    child: const Text('Message', style: _style),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

extension on String {
  String get shortened {
    if (length < 16) return this;

    return '${substring(0, 8)}...${substring(length - 8, length)}';
  }
}

const _style = TextStyle(fontSize: 18);
