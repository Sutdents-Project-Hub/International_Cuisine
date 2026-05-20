import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../api/api_shape.dart';
import '../api/api_config.dart';

class AuthRepository {
  final AuthApi _api;

  AuthRepository(Dio dio) : _api = ApiConfig.createAuthApi(dio);

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final dto = RegisterDto(
      (b) => b
        ..email = email
        ..password = password
        ..username = username,
    );

    await _api.authControllerRegister(registerDto: dto);
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final dto = LoginDto(
      (b) => b
        ..email = email
        ..password = password,
    );

    final response = await _api.authControllerLogin(loginDto: dto);
    return ApiShapeGuard.asMap((response as dynamic).data, at: 'auth.login');
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    final response = await _api.authControllerGetProfile();
    return ApiShapeGuard.asMap((response as dynamic).data, at: 'auth.profile');
  }
}
