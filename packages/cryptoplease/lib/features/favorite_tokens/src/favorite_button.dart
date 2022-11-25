import 'package:flutter/material.dart';

import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import 'bl/repository.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();

    _isFavoriteFuture = sl<FavoriteTokenRepository>().isFavorite(widget.token);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: _isFavoriteFuture,
        builder: (context, data) {
          final isFavorite = data.data ?? false;

          return SizedBox.square(
            dimension: 26,
            child: IconButton(
              onPressed: () async {
                if (isFavorite) {
                  await sl<FavoriteTokenRepository>().remove(widget.token);
                } else {
                  await sl<FavoriteTokenRepository>().add(widget.token);
                }

                if (!mounted) return;

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showCpSnackbar(
                  context,
                  message: isFavorite
                      ? context.l10n.favoritesRemoveNotice
                      : context.l10n.favoritesAddNotice,
                  icon: const Icon(Icons.check, color: Colors.green),
                );

                setState(() {
                  _isFavoriteFuture =
                      sl<FavoriteTokenRepository>().isFavorite(widget.token);
                });
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
