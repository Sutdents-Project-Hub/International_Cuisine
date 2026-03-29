import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/repositories/auth_repository.dart';
import '../../../core/utils/error_utils.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio _dio;
  late final AuthRepository _repository;

  String? _token;
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._dio) {
    _repository = AuthRepository(_dio);
    _loadToken();
  }

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  Map<String, dynamic>? get user => _userProfile;

  Future<void> _loadToken() async {
    _token = await _storage.read(key: 'jwt_token');
    if (_token != null) {
      _setAuthHeader(_token!);
      await fetchProfile();
    }
    notifyListeners();
  }

  void _setAuthHeader(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void _clearAuthHeader() {
    _dio.options.headers.remove('Authorization');
  }

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _repository.login(email: email, password: password);
      final token = data['accessToken']?.toString();

      if (token == null || token.isEmpty) {
        _error = 'Invalid login response: missing token';
      } else {
        _token = token;
        await _storage.write(key: 'jwt_token', value: token);
        _setAuthHeader(token);

        if (data['user'] is Map) {
          _userProfile = Map<String, dynamic>.from(data['user'] as Map);
        } else {
          await fetchProfile();
        }
      }
    } catch (e) {
      _error = parseApiError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.register(
        email: email,
        password: password,
        username: username,
      );
      await login(email: email, password: password);
    } catch (e) {
      _error = parseApiError(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _userProfile = null;
    await _storage.delete(key: 'jwt_token');
    _clearAuthHeader();
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    try {
      _userProfile = await _repository.fetchProfile();
      notifyListeners();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await logout();
      }
    } catch (e) {
      debugPrint('Failed to fetch profile: $e');
    }
  }
}
