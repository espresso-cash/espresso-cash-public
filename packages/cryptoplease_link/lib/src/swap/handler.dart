import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/swap/amount_converter.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addSwapHandler() =>
    shelf_router.Router()..post('/getSwapFee', _swapFeeHandler);

Future<Response> _swapFeeHandler(Request request) async =>
    processRequest<GetSwapFeeRequestDto, GetSwapFeeResponseDto>(
      request,
      GetSwapFeeRequestDto.fromJson,
      (data) async {
        final totalFeeInSol = data.route.fees?.totalFeeAndDeposits;

        if (totalFeeInSol == null) {
          throw Exception('Route has no fee object');
        }

        return GetSwapFeeResponseDto(
          feeInUsdc: await convertSolToUsdc(totalFeeInSol),
        );
      },
    );
