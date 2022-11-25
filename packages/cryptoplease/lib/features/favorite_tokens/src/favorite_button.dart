import 'package:flutter/material.dart';

import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import 'bl/repository.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: sl<FavoriteTokenRepository>().isFavorite(token), //TODO
        builder: (context, data) {
          final isFavorite = data.data ?? false;

          return SizedBox.square(
            dimension: 26,
            child: IconButton(
              onPressed: () {
                sl<FavoriteTokenRepository>().add(token);
              },
              icon: isFavorite
                  ? Assets.icons.favorite.svg()
                  : Assets.icons.unfavorite.svg(),
              padding: EdgeInsets.zero,
            ),
          );
        },
      );
}
