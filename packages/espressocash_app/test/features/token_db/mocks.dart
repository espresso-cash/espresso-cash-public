import 'package:espressocash_app/data/db/db.dart';
import 'package:espressocash_app/features/tokens/data/token_dao.dart';
import 'package:espressocash_app/features/tokens/data/token_repository.dart';
import 'package:espressocash_app/features/tokens/services/token_service.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<MyDatabase>(),
  MockSpec<TokenDao>(),
  MockSpec<TokenListRepository>(),
  MockSpec<TokenService>(),
])
void main() {}
