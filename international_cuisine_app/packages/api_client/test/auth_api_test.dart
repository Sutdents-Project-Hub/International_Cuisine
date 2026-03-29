import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AuthApi
void main() {
  final instance = ApiClient().getAuthApi();

  group(AuthApi, () {
    // Get current user profile
    //
    //Future authControllerGetProfile() async
    test('test authControllerGetProfile', () async {
      // TODO
    });

    // Login with email and password
    //
    //Future authControllerLogin(LoginDto loginDto) async
    test('test authControllerLogin', () async {
      // TODO
    });

    // Register a new user
    //
    //Future authControllerRegister(RegisterDto registerDto) async
    test('test authControllerRegister', () async {
      // TODO
    });

  });
}
