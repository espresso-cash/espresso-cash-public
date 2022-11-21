import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/swap/amount_converter.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addSwapHandler() =>
    shelf_router.Router()..post('/getSwapFee', _handler);

Future<Response> _handler(Request request) async =>
    processRequest<GetSwapFeeRequestDto, GetSwapFeeResponseDto>(
      request,
      GetSwapFeeRequestDto.fromJson,
      (data) async => GetSwapFeeResponseDto(
        feeInUsdc: await convertToUsdc(data.routeFee),
      ),
    );
