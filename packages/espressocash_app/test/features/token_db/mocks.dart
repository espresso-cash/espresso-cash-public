import 'package:espressocash_app/data/db/db.dart';
import 'package:espressocash_app/features/tokens/data/token_repository.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';

final db = MockMyDatabase();
final repo = MockTokenListRepository();

@GenerateMocks([
  MyDatabase,
  TokenListRepository,
])
void main() {}
