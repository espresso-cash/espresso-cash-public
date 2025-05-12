import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../data/kyc_repository.dart';
import '../utils/kyc_exception.dart';

@injectable
class KycAccessService extends ChangeNotifier {
  KycAccessService(this._kycRepository);

  final KycRepository _kycRepository;

  List<PartnerModel>? _partners;
  bool _loading = false;

  List<PartnerModel>? get partners => _partners;
  bool get loading => _loading;

  Future<void> fetchPartners() async {
    _loading = true;
    notifyListeners();
    try {
      _partners = await _kycRepository.fetchGrantedAccessPartners();
    } on Exception catch (exception) {
      throw exception.toKycException();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> grantPartnerAccess(String partnerPk) async {
    await _kycRepository.grantPartnerAccess(partnerPk);
    await fetchPartners();
  }

  Future<void> revokePartnerAccess(String partnerPk) async {
    await _kycRepository.revokePartnerAccess(partnerPk);
    await fetchPartners();
  }

  Future<bool> hasGrantedAccess(String partnerPk) => _kycRepository.hasGrantedAccess(partnerPk);
}
