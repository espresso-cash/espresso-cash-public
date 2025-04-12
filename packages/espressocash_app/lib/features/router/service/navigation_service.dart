import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';
import '../models/activities_tab.dart';

@Singleton(scope: authScope)
class HomeNavigationService {
  final tabNotifier = ValueNotifier<int>(0);
  final activitiesTabNotifier = ValueNotifier<ActivitiesTab>(ActivitiesTab.pending);

  void openWalletTab(BuildContext context) {
    tabNotifier.value = 1;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void openActivitiesTab(BuildContext context, {ActivitiesTab tab = ActivitiesTab.pending}) {
    tabNotifier.value = 2;
    activitiesTabNotifier.value = tab;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
