import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String _overrideBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: '');

  static String get baseUrl {
    if (_overrideBaseUrl.trim().isNotEmpty) return _overrideBaseUrl.trim();
    if (kIsWeb) return 'http://localhost:3000';
    if (Platform.isAndroid) return 'http://10.0.2.2:3000';
    return 'http://localhost:3000';
  }

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Add logging interceptor for debug
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }

  static AuthApi createAuthApi(Dio dio) => AuthApi(dio, standardSerializers);
  static RecipesApi createRecipesApi(Dio dio) =>
      RecipesApi(dio, standardSerializers);
  static UsersApi createUsersApi(Dio dio) => UsersApi(dio, standardSerializers);
  static FavoritesApi createFavoritesApi(Dio dio) =>
      FavoritesApi(dio, standardSerializers);
  static ShoppingListsApi createShoppingListsApi(Dio dio) =>
      ShoppingListsApi(dio, standardSerializers);
  static RatingsApi createRatingsApi(Dio dio) =>
      RatingsApi(dio, standardSerializers);
  static AnalyticsApi createAnalyticsApi(Dio dio) =>
      AnalyticsApi(dio, standardSerializers);
}
