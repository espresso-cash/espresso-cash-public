// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart' as _i19;
import 'package:cryptoplease/core/analytics/analytics_manager.dart' as _i3;
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart' as _i22;
import 'package:cryptoplease/core/conversion_rates/bl/conversion_rates_bloc.dart'
    as _i23;
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart' as _i5;
import 'package:cryptoplease/core/conversion_rates/data/coingecko_client.dart'
    as _i4;
import 'package:cryptoplease/core/dynamic_links_notifier.dart' as _i24;
import 'package:cryptoplease/core/tokens/token_list.dart' as _i17;
import 'package:cryptoplease/core/transactions/tx_sender.dart' as _i18;
import 'package:cryptoplease/data/db/db.dart' as _i10;
import 'package:cryptoplease/di.dart' as _i35;
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart' as _i31;
import 'package:cryptoplease/features/add_funds/bl/repository.dart' as _i20;
import 'package:cryptoplease/features/app_lock/bl/app_lock_bloc.dart' as _i21;
import 'package:cryptoplease/features/backup_phrase/bl/puzzle_reminder_bloc.dart'
    as _i30;
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_bloc.dart'
    as _i32;
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_repository.dart'
    as _i25;
import 'package:cryptoplease/features/incoming_split_key_payments/bl/pending_iskp_repository.dart'
    as _i13;
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart'
    as _i33;
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart'
    as _i26;
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/bloc.dart'
    as _i34;
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/link_shortener.dart'
    as _i9;
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart'
    as _i27;
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart'
    as _i29;
import 'package:cryptoplease/features/payment_request/bl/payment_request_verifier/bloc.dart'
    as _i28;
import 'package:cryptoplease/features/payment_request/bl/repository.dart'
    as _i11;
import 'package:cryptoplease/features/pending_activities/pending_activities_repository.dart'
    as _i12;
import 'package:cryptoplease/features/qr_scanner/qr_scanner_bloc.dart' as _i14;
import 'package:cryptoplease_api/cryptoplease_api.dart' as _i6;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i16;
import 'package:solana/solana.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.AnalyticsManager>(() => _i3.AnalyticsManager());
  gh.factory<_i4.CoingeckoClient>(() => _i4.CoingeckoClient());
  gh.lazySingleton<_i5.ConversionRatesRepository>(() =>
      _i5.ConversionRatesRepository(
          coingeckoClient: get<_i4.CoingeckoClient>()));
  gh.lazySingleton<_i6.CryptopleaseClient>(() => appModule.cryptopleaseClient);
  gh.lazySingleton<_i7.FirebaseDynamicLinks>(
      () => appModule.firebaseDynamicLinks);
  gh.lazySingleton<_i8.FlutterSecureStorage>(() => appModule.secureStorage);
  gh.factory<_i9.LinkShortener>(() => _i9.LinkShortener());
  gh.lazySingleton<_i10.MyDatabase>(() => _i10.MyDatabase());
  gh.factory<_i11.PaymentRequestRepository>(
      () => _i11.PaymentRequestRepository(get<_i10.MyDatabase>()));
  gh.factory<_i12.PendingActivitiesRepository>(
      () => _i12.PendingActivitiesRepository(get<_i10.MyDatabase>()));
  gh.factory<_i13.PendingISKPRepository>(() => _i13.PendingISKPRepository());
  gh.factory<_i14.QrScannerBloc>(() => _i14.QrScannerBloc());
  gh.lazySingleton<_i15.RpcClient>(() => appModule.rpcClient);
  await gh.factoryAsync<_i16.SharedPreferences>(() => appModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i15.SolanaClient>(() => appModule.solanaClient);
  gh.lazySingleton<_i17.TokenList>(() => appModule.tokenList);
  gh.factory<_i18.TxSender>(
      () => _i18.TxSender(client: get<_i15.SolanaClient>()));
  gh.factory<_i19.AccountsBloc>(
      () => _i19.AccountsBloc(storage: get<_i8.FlutterSecureStorage>()));
  gh.factory<_i20.AddFundsRepository>(
      () => _i20.AddFundsRepository(get<_i6.CryptopleaseClient>()));
  gh.factory<_i21.AppLockBloc>(
      () => _i21.AppLockBloc(secureStorage: get<_i8.FlutterSecureStorage>()));
  gh.factory<_i22.BalancesBloc>(() => _i22.BalancesBloc(
      solanaClient: get<_i15.SolanaClient>(), tokens: get<_i17.TokenList>()));
  gh.factory<_i23.ConversionRatesBloc>(() => _i23.ConversionRatesBloc(
      repository: get<_i5.ConversionRatesRepository>()));
  gh.factory<_i24.DynamicLinksNotifier>(
      () => _i24.DynamicLinksNotifier(get<_i7.FirebaseDynamicLinks>()));
  gh.factory<_i25.ISKPRepository>(
      () => _i25.ISKPRepository(get<_i10.MyDatabase>()));
  gh.factory<_i26.ODPRepository>(
      () => _i26.ODPRepository(get<_i10.MyDatabase>(), get<_i17.TokenList>()));
  gh.factory<_i27.OSKPRepository>(
      () => _i27.OSKPRepository(get<_i10.MyDatabase>(), get<_i17.TokenList>()));
  gh.factoryParam<_i28.PaymentRequestVerifierBloc, _i29.PaymentRequest,
          dynamic>(
      (request, _) => _i28.PaymentRequestVerifierBloc(
          solanaClient: get<_i15.SolanaClient>(),
          request: request,
          repository: get<_i11.PaymentRequestRepository>()));
  gh.factory<_i30.PuzzleReminderBloc>(
      () => _i30.PuzzleReminderBloc(get<_i16.SharedPreferences>()));
  gh.factory<_i31.AddFundsBloc>(
      () => _i31.AddFundsBloc(repository: get<_i20.AddFundsRepository>()));
  gh.factoryParam<_i32.ISKPBloc, _i15.Ed25519HDKeyPair, dynamic>((account, _) =>
      _i32.ISKPBloc(
          repository: get<_i25.ISKPRepository>(),
          client: get<_i6.CryptopleaseClient>(),
          account: account,
          txSender: get<_i18.TxSender>()));
  gh.factoryParam<_i33.ODPBloc, _i15.Ed25519HDKeyPair, dynamic>((account, _) =>
      _i33.ODPBloc(
          repository: get<_i26.ODPRepository>(),
          client: get<_i6.CryptopleaseClient>(),
          account: account,
          txSender: get<_i18.TxSender>()));
  gh.factoryParam<_i34.OSKPBloc, _i15.Ed25519HDKeyPair, dynamic>((account, _) =>
      _i34.OSKPBloc(
          account: account,
          client: get<_i6.CryptopleaseClient>(),
          repository: get<_i27.OSKPRepository>(),
          txSender: get<_i18.TxSender>(),
          linkShortener: get<_i9.LinkShortener>()));
  return get;
}

class _$AppModule extends _i35.AppModule {}
