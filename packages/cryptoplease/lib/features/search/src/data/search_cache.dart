import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';

@injectable
class SearchCache {
  final _cache = <String, IList<Token>>{};

  IList<Token>? get(String term) => _cache[term];

  void set(String term, IList<Token> result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
