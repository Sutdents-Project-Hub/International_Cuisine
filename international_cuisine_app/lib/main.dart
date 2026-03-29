import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/api/api_config.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/providers/user_provider.dart';
import 'features/auth/screens/auth_wrapper.dart';
import 'features/cooking/providers/cooking_provider.dart';
import 'features/favorites/providers/favorites_provider.dart';
import 'features/recipe/providers/analytics_provider.dart';
import 'features/recipe/providers/ratings_provider.dart';
import 'features/recipe/providers/recipe_provider.dart';
import 'features/shopping_list/providers/shopping_list_provider.dart';
import 'features/unlock/providers/unlock_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = ApiConfig.createDio();

    return MultiProvider(
      providers: [
        Provider(create: (_) => dio),
        ChangeNotifierProvider(create: (_) => AuthProvider(dio)),
        ChangeNotifierProvider(create: (_) => RecipeProvider(dio)),
        ChangeNotifierProvider(create: (_) => ShoppingListProvider(dio)),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider(dio)),
        ChangeNotifierProvider(create: (_) => CookingProvider()),
        ChangeNotifierProvider(create: (_) => UnlockProvider()),
        ChangeNotifierProxyProvider<AuthProvider, FavoritesProvider>(
          create: (context) => FavoritesProvider(
            Provider.of<AuthProvider>(context, listen: false),
            dio,
          ),
          update: (_, auth, previous) => previous!..update(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(
            Provider.of<AuthProvider>(context, listen: false),
            dio,
          ),
          update: (_, auth, previous) => previous!..update(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, RatingsProvider>(
          create: (context) => RatingsProvider(
            Provider.of<AuthProvider>(context, listen: false),
            dio,
          ),
          update: (_, __, previous) => previous!,
        ),
      ],
      child: MaterialApp(
        title: 'International Cuisine',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}
