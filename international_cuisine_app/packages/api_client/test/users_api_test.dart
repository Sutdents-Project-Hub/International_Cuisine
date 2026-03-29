import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for UsersApi
void main() {
  final instance = ApiClient().getUsersApi();

  group(UsersApi, () {
    // Get user achievements (badges, unlocked recipes)
    //
    //Future usersControllerGetAchievements() async
    test('test usersControllerGetAchievements', () async {
      // TODO
    });

    // Get user level info and XP progress
    //
    //Future usersControllerGetLevelInfo() async
    test('test usersControllerGetLevelInfo', () async {
      // TODO
    });

    // Update user profile
    //
    //Future usersControllerUpdateProfile(UpdateProfileDto updateProfileDto) async
    test('test usersControllerUpdateProfile', () async {
      // TODO
    });

  });
}
