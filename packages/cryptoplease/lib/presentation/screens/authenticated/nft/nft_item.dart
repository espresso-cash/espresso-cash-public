import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/components/nft_image.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:solana/metaplex.dart' hide Image;

class NftItem extends StatelessWidget {
  const NftItem({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final Metadata metadata;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () =>
            context.router.navigate(NftDetailsRoute(metadata: metadata)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
}
