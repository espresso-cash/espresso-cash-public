import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';

const _maxAge = Duration(minutes: 1);

@injectable
class SearchCache {
  SearchCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<List<Token>?> get(String id, {required TokenList tokenList}) async {
    final query = _db.select(_db.tokenSearchRows)
      ..where((p) => p.id.equals(id));

    final row = await query.getSingleOrNull();

    if (row != null) {
      final now = DateTime.now();

      if (now.difference(row.created) <= _maxAge) {
        return row.toModel(tokenList);
      } else {
        await remove(id);
      }
    }
  }

  Future<void> set(String id, IList<Token> result) => _db
      .into(_db.tokenSearchRows)
      .insert(result.toList().toDto(id), mode: InsertMode.replace);

  Future<void> remove(String id) =>
      (_db.delete(_db.tokenSearchRows)..where((t) => t.id.equals(id))).go();

  Future<void> clear() => _db.delete(_db.tokenSearchRows).go();
}

class TokenSearchRows extends Table with EntityMixin {
  TextColumn get data => text()();
}

extension on List<Token> {
  TokenSearchRow toDto(String id) => TokenSearchRow(
        id: id,
        created: DateTime.now(),
        data: json.encode(map((e) => e.toJson()).toList()),
      );
}

extension on Token {
  Map<String, dynamic> toJson() => {
        'id': extensions?.coingeckoId ?? name,
        'name': name,
        'symbol': symbol,
        'image': logoURI,
      };
}

extension on TokenSearchRow {
  List<Token> toModel(TokenList tokenList) {
    final data = json.decode(this.data) as List;

    return data.map((e) {
      e as Map<String, dynamic>;

      final symbol = e['symbol'] as String;

      if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

      return tokenList.fromCoingecko(
        coingeckoId: e['id'] as String,
        symbol: symbol,
        name: e['name'] as String,
        image: e['image'] as String,
      );
    }).toList();
  }
}
