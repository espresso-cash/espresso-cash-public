import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/item/transaction_item_bloc.dart';
import 'package:cryptoplease/bl/transactions/list/transactions_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/app_bar.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/header_buttons.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transactions_screen/components/crypto_balance_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transactions_screen/components/transaction_item.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  _TransactionsScreenState();

  late final TransactionsBloc _transactionsBloc;

  Future<void> _refresh() async {
    _transactionsBloc.add(const TransactionsEvent.loadRequested());
    await _transactionsBloc.stream
        .map((s) => s.loadingState)
        .where((s) => s is LoadingError || s is Success)
        .first;
  }

  @override
  void initState() {
    super.initState();
    _transactionsBloc = TransactionsBloc(
      solanaClient: context.read<SolanaClient>(),
      account: context.read<MyAccount>(),
      token: widget.token,
    );
    _transactionsBloc.add(const TransactionsEvent.loadRequested());
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: BlocBuilder<TransactionsBloc, TransactionsState>(
            bloc: _transactionsBloc,
            builder: (context, state) => CpHeaderedList(
              onRefresh: _refresh,
              allowBackNavigation: true,
              headerAppBar: const HomeScreenAppBar(),
              headerButtons: [
                if (widget.token == Token.sol) const AddFundsButton(),
                SendButton(token: widget.token),
                ReceiveButton(token: widget.token),
              ],
              headerContent: CryptoBalanceWidget(token: widget.token),
              child: CpHeaderedListContent(
                itemBuilder: (context, index) =>
                    BlocProvider<TransactionItemBloc>(
                  key: ValueKey(state.transactions[index].hash),
                  create: (context) => TransactionItemBloc(
                    account: context.read<MyAccount>(),
                  ),
                  child: TransactionItem(
                    transaction: state.transactions[index],
                    token: widget.token,
                  ),
                ),
                itemCount: state.transactions.length,
                emptyWidget: Material(
                  child: CpEmptyMessageWidget(
                    message: state.loadingState is InProgress
                        ? context.l10n.loading
                        : context.l10n.noDataPullToRefresh,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
