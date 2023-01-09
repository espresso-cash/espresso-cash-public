import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bl/bloc.dart';

extension RefreshFavorites on BuildContext {
  Future<void> refreshFavorites() => read<FavoritesBloc>().refresh();
}
