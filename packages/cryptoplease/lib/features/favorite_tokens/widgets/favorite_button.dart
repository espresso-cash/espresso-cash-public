import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../src/bl/bloc.dart';
import '../src/bl/repository.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.token,
  });

  final Token token;

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

          return SizedBox.square(
            dimension: 26,
            child: IconButton(
              onPressed: () => _onPressed(isFavorite: isFavorite),
              icon: isFavorite
                  ? Assets.icons.favorite.svg()
                  : Assets.icons.unfavorite.svg(),
              padding: EdgeInsets.zero,
            ),
          );
        },
      );
}
