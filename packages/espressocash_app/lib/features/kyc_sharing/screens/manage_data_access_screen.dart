import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/theme.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_access_service.dart';

class ManageDataAccessScreen extends StatefulWidget {
  const ManageDataAccessScreen({super.key});

  static void push(BuildContext context) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (_) => const ManageDataAccessScreen()));

  @override
  State<ManageDataAccessScreen> createState() => _ManageDataAccessScreenState();
}

class _ManageDataAccessScreenState extends State<ManageDataAccessScreen> {
  // ignore: dispose-fields, false positive
  final _kycAccessService = sl<KycAccessService>();

  @override
  void initState() {
    super.initState();
    _kycAccessService.fetchPartners();
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.blackGreyColor,
      appBar: CpAppBar(title: Text(context.l10n.manageDataAccess.toUpperCase())),
      body: ListenableBuilder(
        listenable: _kycAccessService,
        builder: (context, _) => _Content(service: _kycAccessService),
      ),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.service});

  final KycAccessService service;

  void _handleOnDeleteAllDataPress(BuildContext context) => showConfirmationDialog(
    context,
    title: context.l10n.confirmDeleteAllDataTitle,
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    message: context.l10n.confirmDeleteAllDataText,
    messageStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
    onConfirm: () async {
      await runWithLoader<void>(context, () async {
        try {
          await sl<KycRepository>().deleteAllUserData();
          if (!context.mounted) return;
          Navigator.of(context).pop();
        } on Exception {
          if (!context.mounted) return;
          showCpErrorSnackbar(context, message: context.l10n.tryAgainLater);
        }
      });
    },
  );

  void _handleRevokeAccess(BuildContext context, String partnerPk) => showConfirmationDialog(
    context,
    title: context.l10n.confirmRevokeAccessTitle,
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    message: context.l10n.confirmRevokeAccessText,
    onConfirm: () async {
      await runWithLoader<void>(context, () async {
        try {
          await service.revokePartnerAccess(partnerPk);
        } on Exception {
          if (!context.mounted) return;
          showCpErrorSnackbar(context, message: context.l10n.tryAgainLater);
        }
      });
    },
  );

  @override
  Widget build(BuildContext context) => Padding(
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
          child: Text(
            context.l10n.networkPartners.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: () {
            if (service.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final partners = service.partners ?? [];

            return partners.isEmpty
                ? Center(child: Text(context.l10n.noPartnersWithAccess))
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

class _PartnerListItem extends StatelessWidget {
  const _PartnerListItem({required this.partner, required this.onRevokeAccess});

  final PartnerModel partner;
  final VoidCallback onRevokeAccess;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(
            partner.name,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 24),
          onPressed: onRevokeAccess,
        ),
      ],
    ),
  );
}
