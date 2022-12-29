import 'package:flutter/material.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

class AccountList extends StatelessWidget {
  const AccountList({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accounts.length,
        itemBuilder: (context, index) => AccountItem(
          account: accounts.elementAt(index),
        ),
      );
}

class AccountItem extends StatefulWidget {
  const AccountItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  void _onEditAccount() {}

  void _onSignTransaction() {}

  void _onSignMessage() {}

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('Account: ${widget.account.name}', style: _style),
                  const Spacer(),
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
                'Path: ${widget.account.derivationPath.toString()}',
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
