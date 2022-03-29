import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/details_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/value_views.dart';
import 'package:flutter/widgets.dart';

class BasicTransactionInformation extends StatelessWidget {
  const BasicTransactionInformation({
    Key? key,
    required DateTime? dateTime,
    required TransactionStatus status,
  })  : _dateTime = dateTime,
        _status = status,
        super(key: key);

  @override
  Widget build(BuildContext context) => DetailsView(
        fields: <String, Widget>{
          context.l10n.date: DetailsDateValue(dateTime: _dateTime),
          context.l10n.status: DetailsStatusValue(status: _status),
        },
        title: '',
      );

  final DateTime? _dateTime;
  final TransactionStatus _status;
}
