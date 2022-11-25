import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../core/tokens/token.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';
import '../../../core/conversion_rates/widgets/token_rate_text.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../module.dart';

class FavoriteTokenList extends StatefulWidget {
  const FavoriteTokenList({super.key});

  @override
  State<FavoriteTokenList> createState() => _FavoriteTokenListState();
}

class _FavoriteTokenListState extends State<FavoriteTokenList> {
  late Stream<List<Token>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<FavoriteTokenRepository>().watch();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Token>>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            return const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            sliver: MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Text(
                    context.l10n.following,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.17,
                      color: CpColors.menuPrimaryTextColor,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16),
                  sliver: SliverStack(
                    children: [
                      const SliverPositioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            data.map(_TokenItem.new).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => context.router.push(TokenDetailsRoute(token: token)),
        leading: CpTokenIcon(token: token, size: 37),
        title: Text(
          token.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: TokenRateText(
          token: token,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      );
}
