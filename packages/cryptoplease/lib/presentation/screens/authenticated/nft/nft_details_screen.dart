import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:solana/metaplex.dart' hide Image;

class NftDetailsScreen extends StatelessWidget {
  const NftDetailsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Builder(
          builder: (context) {
            final propertiesTextStyle =
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    );

            final groupTitleTextStyle =
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    );

            return Scaffold(
              appBar: CpAppBar(title: Text(data.name)),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 244,
                          child: Center(
                            child: SizedBox(
                              width: 184,
                              height: 184,
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: Image.network(data.image),
                              ),
                            ),
                          ),
                        ),
                        CpButton(
                          text: context.l10n.send,
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
              ),
            );
          },
        ),
      );

  final OffChainMetadata data;
}
