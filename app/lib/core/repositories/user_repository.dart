import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

import '../../features/auth/models/user_level_info.dart';
import '../api/api_config.dart';
import '../api/api_shape.dart';

class UserRepository {
  final UsersApi _api;

  UserRepository(Dio dio) : _api = ApiConfig.createUsersApi(dio);

  Future<UserLevelInfo> fetchLevelInfo() async {
    final response = await _api.usersControllerGetLevelInfo();
    return UserLevelInfo.fromJson(
      ApiShapeGuard.asMap((response as dynamic).data, at: 'users.level'),
    );
  }

  Future<UserAchievementSummary> fetchAchievements() async {
    final response = await _api.usersControllerGetAchievements();
    return UserAchievementSummary.fromJson(
      ApiShapeGuard.asMap((response as dynamic).data, at: 'users.achievements'),
    );
  }

  Future<void> updateProfile({String? username}) {
    final dto = UpdateProfileDto((b) => b..username = username);
    return _api.usersControllerUpdateProfile(updateProfileDto: dto);
  }
}
