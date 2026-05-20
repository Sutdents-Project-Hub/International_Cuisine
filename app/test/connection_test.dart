import 'dart:math';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

const baseUrl = 'http://localhost:3000';

void main() {
  test(
    'backend connection smoke (manual)',
    () async {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      final api = AuthApi(dio, standardSerializers);

      final random = Random();
      final email = 'test_${random.nextInt(10000)}@test.com';
      final password = 'password123';
      final username = 'user_${random.nextInt(10000)}';

      final registerDto = RegisterDto(
        (b) => b
          ..email = email
          ..password = password
          ..username = username,
      );

      final registerResponse = await api.authControllerRegister(
        registerDto: registerDto,
      );
      expect(registerResponse.statusCode, isNotNull);

      final loginDto = LoginDto(
        (b) => b
          ..email = email
          ..password = password,
      );

      final loginResponse = await api.authControllerLogin(loginDto: loginDto);
      expect(loginResponse.statusCode, isNotNull);
    },
    skip: 'Manual local integration test. Enable when backend is running.',
  );
}
