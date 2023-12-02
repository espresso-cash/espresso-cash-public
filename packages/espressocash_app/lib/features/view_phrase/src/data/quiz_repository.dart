import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class QuizRepository extends ChangeNotifier {
  QuizRepository(this._storage);

  final SharedPreferences _storage;

  bool get hasCompletedQuiz => _storage.getBool(_quizCompletedKey) ?? false;

  set hasCompletedQuiz(bool value) {
    _storage.setBool(_quizCompletedKey, value);
    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    _storage.remove(_quizCompletedKey);
    super.dispose();
  }
}

const _quizCompletedKey = 'quizCompleted';
