import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../country_picker/models/country.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';

class BankAccountListScreen extends StatefulWidget {
  const BankAccountListScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const BankAccountListScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<BankAccountListScreen> createState() => _BankAccountListScreenState();
}

class _BankAccountListScreenState extends State<BankAccountListScreen> {
  List<BankInfo> _bankInfos = [];

  @override
  void initState() {
    super.initState();

    final user = sl<KycSharingService>().value;

    _bankInfos = user?.bankInfos ?? [];
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: context.l10n.bankAccount.toUpperCase(),
        children: [
          for (final bankInfo in _bankInfos) _BankInfoItem(bankInfo),
          const Spacer(),
          CpBottomButton(
            horizontalPadding: 16,
            text: 'Add New Bank Account',
            onPressed: () {},
          ),
        ],
      );
}

class _BankInfoItem extends StatelessWidget {
  const _BankInfoItem(this.bankInfo);

  final BankInfo bankInfo;

  @override
  Widget build(BuildContext context) {
    final country = Country.findByCode(bankInfo.countryCode);
    final countryName = country?.name ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const ShapeDecoration(
        color: CpColors.blackGreyColor,
        shape: StadiumBorder(),
      ),
      child: ListTile(
        title: Text(
          '${bankInfo.bankName} - $countryName',
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }
}
