import 'package:espressocash_app/features/balances/services/refresh_balance.dart';

class StubRefreshBalance implements RefreshBalance {
  const StubRefreshBalance();

  @override
  Future<void> call() async {}
}
