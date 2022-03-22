import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/nft/nft_metadata/bloc.dart';
import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:cryptoplease/presentation/components/nft_image.dart';
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
            NftMetadataBloc(context.read<OffchainMetadataRepository>())
              ..add(NftMetadataEvent.initialized(metadata)),
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
                NftDetailsRoute(data: data, metadata: metadata),
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
                      child: NftImage(metadata: metadata, size: 90),
                    ),
                    Expanded(
                      child: Text(
                        metadata.name,
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

const _loadingWidget = FractionallySizedBox(
  widthFactor: 0.4,
  heightFactor: 0.4,
  child: CircularProgressIndicator(color: Color(0x80ffffff)),
);
