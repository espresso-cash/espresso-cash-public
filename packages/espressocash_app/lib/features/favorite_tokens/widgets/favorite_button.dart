import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../src/bl/bloc.dart';
import '../src/bl/repository.dart';

enum FavoriteButtonVariant {
  dark,
  light,
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.token,
    this.variant = FavoriteButtonVariant.dark,
  });

  final Token token;
  final FavoriteButtonVariant variant;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late final Stream<bool> _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = sl<FavoriteTokenRepository>().isFavorite(widget.token);
  }

  Future<void> _onPressed({required bool isFavorite}) async {
    if (isFavorite) {
      await sl<FavoriteTokenRepository>().remove(widget.token);
    } else {
      final bloc = context.read<FavoritesBloc>();

      await sl<FavoriteTokenRepository>().add(widget.token);
      bloc.add(const FavoritesEvent.refreshRequested());
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
        stream: _isFavorite,
        builder: (context, data) {
          final isFavorite = data.data ?? false;

          final icon = (() {
            if (isFavorite) return Assets.icons.favorite.svg();

            switch (widget.variant) {
              case FavoriteButtonVariant.dark:
                return Assets.icons.unfavorite.svg();
              case FavoriteButtonVariant.light:
                return Assets.icons.unfavoriteLight.svg();
            }
          })();

          return SizedBox.square(
            dimension: 26,
            child: IconButton(
              onPressed: () => _onPressed(isFavorite: isFavorite),
              icon: icon,
              padding: EdgeInsets.zero,
            ),
          );
        },
      );
}
