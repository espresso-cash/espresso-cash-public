import 'package:cryptoplease/bl/nft/nft_collection/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/empty_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/nft/nft_item.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NftScreen extends StatefulWidget {
  const NftScreen({Key? key}) : super(key: key);

  @override
  State<NftScreen> createState() => _NftScreenState();
}

class _NftScreenState extends State<NftScreen> {
  @override
  void initState() {
    super.initState();

    _update();
  }

  Future<void> _update() async {
    final bloc = context.read<NftCollectionBloc>()
      ..add(const NftCollectionEvent.updated());

    await bloc.stream.firstWhere(
      (state) => state.processingState.maybeWhen(
        none: T,
        error: T,
        orElse: F,
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<NftCollectionBloc, NftCollectionState>(
        listener: (context, state) => state.processingState.maybeWhen(
          error: (_) => showCpErrorSnackbar(
            context,
            message: context.l10n.errorLoadingPullToRefresh,
          ),
          orElse: ignore,
        ),
        builder: (context, state) => CpTheme.dark(
          child: RefreshIndicator(
            onRefresh: _update,
            backgroundColor: CpColors.lightButtonBackgroundColor,
            child: Scaffold(
              appBar: CpAppBar(title: Text(context.l10n.yourNfts)),
              body: state.processingState.maybeMap(
                processing: (_) {
                  if (state.nftCollection.isEmpty) {
                    return const _NftScreenLoader();
                  } else {
                    return _NftListView(collection: state.nftCollection);
                  }
                },
                none: (_) {
                  if (state.nftCollection.isEmpty) {
                    return EmptyWidget(
                      message: context.l10n.noNftsCollectedYet,
                    );
                  } else {
                    return _NftListView(collection: state.nftCollection);
                  }
                },
                orElse: () => const SliverToBoxAdapter(child: SizedBox()),
              ),
            ),
          ),
        ),
      );
}

class _NftScreenLoader extends StatelessWidget {
  const _NftScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: const SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              color: Color(0x80ffffff),
              strokeWidth: 8,
            ),
          ),
        ),
      );
}

class _NftListView extends StatelessWidget {
  const _NftListView({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Iterable<NonFungibleToken> collection;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, index) {
          final token = collection.elementAt(index);

          return Material(
            key: ValueKey(token.metadata.uri),
            color:
                index.isEven ? const Color(0xfffd6f49) : CpColors.primaryColor,
            child: NftItem(metadata: token.metadata),
          );
        },
        itemCount: collection.length,
      );
}
