import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/nft_image.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/non_fungible_token/send_flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/metaplex.dart' hide Image;

class NftDetailsScreen extends StatefulWidget {
  const NftDetailsScreen({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final Metadata metadata;

  @override
  State<NftDetailsScreen> createState() => _NftDetailsScreenState();
}

class _NftDetailsScreenState extends State<NftDetailsScreen> {
  late final Future<OffChainMetadata> _future;

  @override
  void initState() {
    super.initState();
    _future =
        context.read<OffchainMetadataRepository>().getMetadata(widget.metadata);
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: CpAppBar(title: Text(widget.metadata.name)),
            body: FutureBuilder<OffChainMetadata>(
              future: _future,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0x80ffffff)),
                  );
                }

                return _Content(data: data, metadata: widget.metadata);
              },
            ),
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.data,
    required this.metadata,
  }) : super(key: key);

  final OffChainMetadata data;
  final Metadata metadata;

  @override
  Widget build(BuildContext context) {
    final propertiesTextStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        );

    final groupTitleTextStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        );

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) => NftImage(
                    metadata: metadata,
                    size: constraints.maxWidth,
                  ),
                ),
              ),
              CpButton(
                text: context.l10n.send,
                onPressed: () {
                  final token = NonFungibleToken(
                    address: metadata.mint,
                    metadata: metadata,
                  );

                  context.navigateToSendNft(token);
                },
                width: 200,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: CpColors.primaryColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.nftDescription,
                      textAlign: TextAlign.start,
                      style: groupTitleTextStyle,
                    ),
                    const SizedBox(height: 13),
                    Text(
                      data.description,
                      textAlign: TextAlign.start,
                      style: propertiesTextStyle,
                    ),
                    const SizedBox(height: 52),
                    Text(
                      context.l10n.nftProperties,
                      textAlign: TextAlign.start,
                      style: groupTitleTextStyle,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final attribute = data.attributes[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 7,
                ),
                color: CpColors.primaryColor,
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Color(0xffd5523c),
                    shape: StadiumBorder(),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        attribute.traitType,
                        style: propertiesTextStyle,
                      ),
                      Text(
                        attribute.value.toString(),
                        style: propertiesTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: data.attributes.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: CpColors.primaryColor,
            height: 10,
          ),
        )
      ],
    );
  }
}
