import 'package:flutter/material.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

class SeedList extends StatelessWidget {
  const SeedList({
    Key? key,
    required this.seedList,
    required this.onDeauthorize,
    required this.onMessageSigning,
    required this.requestPublicKey,
  }) : super(key: key);

  final List<Seed> seedList;
  final ValueSetter<Seed> onDeauthorize;
  final ValueSetter<Seed> onMessageSigning;
  final ValueSetter<Seed> requestPublicKey;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: seedList.length,
        itemBuilder: (context, i) {
          final seed = seedList.elementAt(i);

          return ListTile(
            leading: Text(seed.authToken.toString()),
            title: Text(seed.name),
            subtitle: Text('Accounts: ${seed.accounts.length}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => onMessageSigning(seed),
                  icon: const Icon(Icons.wb_iridescent),
                ),
                IconButton(
                  onPressed: () => onDeauthorize(seed),
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () => requestPublicKey(seed),
                  icon: const Icon(Icons.key),
                ),
              ],
            ),
          );
        },
      );
}
