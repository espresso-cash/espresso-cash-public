import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/activities/solana_transaction.dart';
import 'package:cryptoplease/bl/activities/tx_fetcher/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class NewActivitiesScreen extends StatefulWidget {
  const NewActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<NewActivitiesScreen> createState() => _NewActivitiesScreenState();
}

class _NewActivitiesScreenState extends State<NewActivitiesScreen> {
  late final Stream<Iterable<SolanaTransaction>> _txs;

  @override
  void initState() {
    super.initState();
    _txs = context.read<TransactionReaderRepository>().watchTransactions();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        lazy: false,
        create: (context) => TxFetcherBloc(
          repository: context.read<TxFetcherRepository>(),
          client: context.read<RpcClient>(),
          getAllAccounts: () async => [
            context.read<MyAccount>().wallet,
          ],
        )..add(const TxFetcherEvent.fetchRequested()),
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.activitiesTitle.toUpperCase()),
          ),
          body: StreamBuilder<Iterable<SolanaTransaction>>(
            stream: _txs,
            builder: (context, snapshot) {
              final data = snapshot.data?.toList() ?? const [];

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final tx = data[index];

                  return ListTile(
                    title: Text(tx.id),
                    subtitle: Text(tx.blockTime.toString()),
                  );
                },
              );
            },
          ),
        ),
      );
}
