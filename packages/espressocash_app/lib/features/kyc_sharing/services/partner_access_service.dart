import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_service.dart';

@injectable
class PartnerAccessService extends ChangeNotifier {
  PartnerAccessService(this._kycRepository);

  final KycRepository _kycRepository;

  List<PartnerModel>? _partners;
  bool _loading = false;
  String? _error;

  List<PartnerModel>? get partners => _partners;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadPartners() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _partners = await sl<KycSharingService>().fetchGrantedAccessPartners();
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> revokePartner(String partnerPk) async {
    await sl<KycRepository>().revokePartnerAccess(partnerPk);
    _partners?.removeWhere((p) => p.publicKey == partnerPk);
    notifyListeners();
  }
}
