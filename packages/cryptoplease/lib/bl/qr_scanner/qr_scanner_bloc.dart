import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc(TokenList tokenList)
      : _tokenList = tokenList,
        super(const QrScannerState.initial()) {
    on<QrScannerEvent>(_eventHandler, transformer: sequential());
  }

  EventHandler<QrScannerEvent, QrScannerState> get _eventHandler =>
      (event, emit) => event.map(
            received: (e) => _onReceived(e, emit),
            initialized: (e) => _onInitialized(e, emit),
          );

  void _onInitialized(
    QrScannerInitializedEvent _,
    Emitter<QrScannerState> emit,
  ) {
    emit(const QrScannerState.initial());
  }

  Future<void> _onReceived(
    QrScannerReceivedEvent event,
    Emitter<QrScannerState> emit,
  ) async {
    final code = event.code;
    if (isValidAddress(code)) {
      emit(QrScannerState.done(QrScannerRequest.address(code)));
    } else {
      final uri = Uri.tryParse(code);
      if (uri != null) {
        emit(_handleUri(uri));
      } else {
        emit(const QrScannerState.error(QrScannerError.invalidQrCode));
      }
    }
  }

  Token? _nullableFindTokenByMint(String? mint) {
    if (mint == null) {
      return Token.sol;
    }

    return _tokenList.findTokenByMint(mint);
  }

  QrScannerState _handleUri(Uri uri) {
    if (uri.scheme == 'solana') {
      try {
        final query = SolanaPayQuery.fromJson(uri.queryParameters);
        final token = _nullableFindTokenByMint(query.splToken);
        if (token == null) {
          return const QrScannerState.error(QrScannerError.tokenNotFound);
        }
        final amount = query.amount;
        final parsedAmount =
            amount == null ? null : Decimal.parse(amount.toString());

        if (parsedAmount != null && parsedAmount.scale > token.decimals) {
          return const QrScannerState.error(
            QrScannerError.solanaPayQueryFailedToParse,
          );
        }

        return QrScannerState.done(
          QrScannerRequest.solanaPay(
            recipient: uri.path,
            reference: query.reference,
            token: token,
            amount: amount != null ? parsedAmount : null,
          ),
        );
      } on Exception {
        return const QrScannerState.error(
          QrScannerError.solanaPayQueryFailedToParse,
        );
      }
    } else {
      return const QrScannerState.error(QrScannerError.unsupportedURIScheme);
    }
  }

  final TokenList _tokenList;
}
