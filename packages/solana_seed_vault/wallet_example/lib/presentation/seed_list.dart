import 'package:flutter/material.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

class SeedList extends StatelessWidget {
  const SeedList({
    Key? key,
    required this.seedList,
    required this.onDeauthorize,
  }) : super(key: key);

  final List<Seed> seedList;
  final ValueSetter<Seed> onDeauthorize;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: seedList.length,
        itemBuilder: (context, i) {
          final seed = seedList.elementAt(i);

          return ListTile(          
            leading: Text(seed.authToken.toString()),
            title: Text(seed.name),
            subtitle: Text('Accounts: ${seed.accounts.length}'),
            trailing: IconButton(
              onPressed: () => onDeauthorize(seed),
              icon: const Icon(Icons.delete),
            ),
          );
        },
      );
}
