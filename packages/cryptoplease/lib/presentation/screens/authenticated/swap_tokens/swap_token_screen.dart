import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/token_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

class SwapTokenScreen extends StatefulWidget {
  const SwapTokenScreen({Key? key}) : super(key: key);

  @override
  _SwapTokenScreenState createState() => _SwapTokenScreenState();
}

class _SwapTokenScreenState extends State<SwapTokenScreen> {
  late final SwapSelectorBloc swapTokenBloc;

  @override
  void initState() {
    super.initState();
    // TODO(rhbrunetto): fix dependency injection
    swapTokenBloc = SwapSelectorBloc(
      jupiterAggregatorClient: context.read<JupiterAggregatorClient>(),
      tokenList: context.read<TokenList>(),
    );
    swapTokenBloc.add(const SwapSelectorEvent.load());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<SwapSelectorBloc, SwapSelectorState>(
          bloc: swapTokenBloc,
          builder: (context, state) => Column(
            children: [
              Flexible(
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    const Text('Input'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.inputTokens.length,
                        itemBuilder: (context, index) => TokenItem(
                          token: state.inputTokens.elementAt(index),
                          onSelected: (token) => swapTokenBloc.add(
                            SwapSelectorEvent.inputSelected(token),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    const Text('Output'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.outputTokens.length,
                        itemBuilder: (context, index) => TokenItem(
                          token: state.outputTokens.elementAt(index),
                          onSelected: print,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
