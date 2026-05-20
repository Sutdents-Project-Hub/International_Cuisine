import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/repositories/user_repository.dart';
import '../../../core/utils/error_utils.dart';
import '../models/user_level_info.dart';
import 'auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  final Dio _dio;
  late UserRepository _repository;

  UserLevelInfo? _levelInfo;
  UserAchievementSummary? _achievementSummary;
  bool _isLoading = false;
  String? _error;
  String? _lastToken;

  UserProvider(this._authProvider, this._dio) {
    _repository = UserRepository(_dio);
    _lastToken = _authProvider.token;
  }

  UserLevelInfo? get levelInfo => _levelInfo;
  UserAchievementSummary? get achievementSummary => _achievementSummary;
  List<dynamic> get badges => _achievementSummary?.badges ?? const [];
  List<dynamic> get unlockedRecipes =>
      _achievementSummary?.unlockedRecipes ?? const [];
  bool get isLoading => _isLoading;
  String? get error => _error;

  void update(AuthProvider auth) {
    if (auth.token != _lastToken) {
      _lastToken = auth.token;
      if (auth.token == null) {
        _levelInfo = null;
        _achievementSummary = null;
        notifyListeners();
      } else {
        fetchUserStats();
      }
    }
  }

  Future<void> fetchUserStats() async {
    if (_authProvider.token == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _levelInfo = await _repository.fetchLevelInfo();
      _achievementSummary = await _repository.fetchAchievements();
    } catch (e) {
      _error = parseApiError(e);
      debugPrint('Error fetching user stats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String? username) async {
    if (_authProvider.token == null) return;

    try {
      await _repository.updateProfile(username: username);
      await _authProvider.fetchProfile();
      await fetchUserStats();
    } catch (e) {
      _error = parseApiError(e);
      notifyListeners();
      rethrow;
    }
  }
}
