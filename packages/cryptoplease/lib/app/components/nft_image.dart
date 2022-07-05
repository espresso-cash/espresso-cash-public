import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/metaplex.dart' hide Image;

class NftImage extends StatefulWidget {
  const NftImage({
    Key? key,
    required this.metadata,
    required this.size,
  }) : super(key: key);

  final Metadata metadata;
  final double size;

  @override
  State<NftImage> createState() => _NftImageState();
}

class _NftImageState extends State<NftImage> {
  late final Future<OffChainMetadata> _future;

  @override
  void initState() {
    super.initState();
    _future =
        context.read<OffchainMetadataRepository>().getMetadata(widget.metadata);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<OffChainMetadata>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox(
              width: widget.size,
              height: widget.size,
            );
          }

          final data = snapshot.data;

          return data != null
              ? _ItemImage(data: data, size: widget.size)
              : SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: const Center(child: _loadingWidget),
                );
        },
      );
}

class _ItemImage extends StatelessWidget {
  const _ItemImage({
    Key? key,
    required this.data,
    required this.size,
  }) : super(key: key);

  final double size;
  final OffChainMetadata data;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(color: Color(0x40ffffff)),
          width: size,
          height: size,
          child: data.properties.maybeMap(
            image: (_) => Image.network(
              data.image,
              loadingBuilder: _loadingBuilder,
              width: size,
            ),
            vr: (_) => Image.network(
              data.image,
              loadingBuilder: _loadingBuilder,
              width: size,
            ),
            orElse: () => Center(child: Text(context.l10n.unsupportedNft)),
          ),
        ),
      );
}

const _loadingWidget = FractionallySizedBox(
  widthFactor: 0.4,
  heightFactor: 0.4,
  child: CircularProgressIndicator(color: Color(0x80ffffff)),
);

Widget _loadingBuilder(
  BuildContext _,
  Widget child,
  ImageChunkEvent? loadingProgress,
) =>
    loadingProgress == null ? child : _loadingWidget;
