import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/swap.dart';
import '../../models/swap_seed.dart';
import '../route_repository.dart';
import '../swap_route.dart';
import 'swap_repository.dart';

@injectable
class SwapService {
  const SwapService(this._swapRepository, this._routeRepository);

  final SwapRepository _swapRepository;
  final RouteRepository _routeRepository;

  Future<Swap> create({
    required SwapRoute route,
    required ECWallet account,
  }) async {
    final status = await _createTx(route: route, account: account);

    final id = const Uuid().v4();
    final swap = Swap(
      id: id,
      created: DateTime.now(),
      status: status,
      seed: route.seed,
    );

    await _swapRepository.save(swap);

    return swap;
  }

  Future<Swap> retry(
    Swap swap, {
    required ECWallet account,
  }) async {
    final status = await _reCreateTx(seed: swap.seed, account: account);

    final newSwap = swap.copyWith(status: status);

    await _swapRepository.save(newSwap);

    return newSwap;
  }

  Future<SwapStatus> _reCreateTx({
    required SwapSeed seed,
    required ECWallet account,
  }) async {
    try {
      final route = await _routeRepository.findRoute(
        seed: seed,
        userPublicKey: account.address,
      );

      return await _createTx(route: route, account: account);
    } on Exception {
      return const SwapStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<SwapStatus> _createTx({
    required SwapRoute route,
    required ECWallet account,
  }) async {
    try {
      return SwapStatus.txCreated(
        await SignedTx.decode(route.encodedTx).resign(account),
        slot: route.slot,
      );
    } on Exception {
      return const SwapStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
