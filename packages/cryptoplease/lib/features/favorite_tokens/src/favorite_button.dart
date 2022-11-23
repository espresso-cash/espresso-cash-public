import 'package:flutter/material.dart';

import '../../../core/tokens/token.dart';
import '../../../gen/assets.gen.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 26,
        child: IconButton(
          onPressed: () {},
          icon: true
              ? Assets.icons.favorite.svg()
              : Assets.icons.unfavorite.svg(),
          padding: EdgeInsets.zero,
        ),
      );
}
