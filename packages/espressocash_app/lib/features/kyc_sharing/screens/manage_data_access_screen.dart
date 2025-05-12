import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/theme.dart';
import '../data/kyc_repository.dart';
import '../services/partner_access_service.dart';

class ManageDataAccessScreen extends StatelessWidget {
  const ManageDataAccessScreen({super.key});

  static void push(BuildContext context) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (_) => const ManageDataAccessScreen()));

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.blackGreyColor,
      appBar: CpAppBar(title: Text(context.l10n.manageDataAccess.toUpperCase())),
      body: ChangeNotifierProvider<PartnerAccessService>.value(
        value: sl<PartnerAccessService>()..fetchPartners(),
        child: const _Content(),
      ),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  void _handleOnDeleteAllDataPress(BuildContext context) => showConfirmationDialog(
    context,
    title: 'Confirm Delete',
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    message:
        'Are you sure you want to delete all your kyc infomation and revoke access to all partners?',
    messageStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
    onConfirm: () {
      sl<KycRepository>().deleteAllUserData();
      Navigator.of(context).pop();
    },
  );

  void _handleRevokeAccess(BuildContext context, String partnerPk) => showConfirmationDialog(
    context,
    title: 'Confirm Revoke',
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    message: 'Are you sure you want to revoke access to this partner?',
    onConfirm: () => context.read<PartnerAccessService>().revokePartner(partnerPk),
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartnerAccessService>();

    return Padding(
      padding: EdgeInsets.only(
        top: 40,
        left: 40,
        right: 40,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(context.l10n.networkPartners.toUpperCase()),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: () {
              if (provider.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.error != null) {
                return const Center(
                  child: Text(
                    'Error loading partners',
                    style: TextStyle(color: CpColors.alertRedColor),
                  ),
                );
              }
              final partners = provider.partners ?? [];

              return partners.isEmpty
                  ? const Center(child: Text('No partners with access'))
                  : ListView.builder(
                    itemCount: partners.length,
                    itemBuilder: (context, index) {
                      final partner = partners[index];

                      return _PartnerListItem(
                        partner: partner,
                        onRevokeAccess: () => _handleRevokeAccess(context, partner.publicKey),
                      );
                    },
                  );
            }(),
          ),
          const SizedBox(height: 20),
          CpBottomButton(
            horizontalPadding: 0,
            text: context.l10n.deleteAllData,
            onPressed: () => _handleOnDeleteAllDataPress(context),
            variant: CpButtonVariant.danger,
          ),
        ],
      ),
    );
  }
}

class _PartnerListItem extends StatelessWidget {
  const _PartnerListItem({required this.partner, required this.onRevokeAccess});

  final PartnerModel partner;
  final VoidCallback onRevokeAccess;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            partner.name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 24),
          tooltip: 'Revoke Access',
          onPressed: onRevokeAccess,
        ),
      ],
    ),
  );
}
