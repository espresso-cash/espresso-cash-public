import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/nft/nft_metadata/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/metaplex.dart' hide Image;

class NftItem extends StatelessWidget {
  const NftItem({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final Metadata metadata;

  @override
  Widget build(BuildContext context) => BlocProvider<NftMetadataBloc>(
        create: (_) =>
            NftMetadataBloc()..add(NftMetadataEvent.initialized(metadata)),
        child: _Content(metadata: metadata),
      );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final Metadata metadata;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NftMetadataBloc, NftMetadataState>(
        builder: (context, state) => state.processingState.map(
          processing: (_) => const Center(
            child: SizedBox(
              height: 124,
              child: AspectRatio(aspectRatio: 1, child: _loadingWidget),
            ),
          ),
          error: (_) => const SizedBox(),
          none: (_) {
            final data = state.data;
            if (data == null) {
              // TODO(KB): Show an error image
              return const SizedBox();
            }

            // NOTE: vr are 3d models and we are currently
            //       only displaying an image.
            return InkWell(
              onTap: () => context.router.navigate(
                NftDetailsRoute(
                  data: data,
                  metadata: metadata,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _ItemImage(data: data),
                    ),
                    Expanded(
                      child: Text(
                        data.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: 19),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
}

class _ItemImage extends StatelessWidget {
  const _ItemImage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(color: Color(0x40ffffff)),
          width: _imageSize,
          height: _imageSize,
          child: data.properties.maybeMap(
            image: (_) => Image.network(
              data.image,
              loadingBuilder: _loadingBuilder,
              width: _imageSize,
            ),
            vr: (_) => Image.network(
              data.image,
              loadingBuilder: _loadingBuilder,
              width: _imageSize,
            ),
            orElse: () => Center(child: Text(context.l10n.unsupportedNft)),
          ),
        ),
      );

  final OffChainMetadata data;
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

const _imageSize = 90.0;
