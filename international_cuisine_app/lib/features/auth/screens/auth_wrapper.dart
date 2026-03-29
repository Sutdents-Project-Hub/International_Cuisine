import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/screens/app_shell.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          return const AppShell();
        }
        return const LoginScreen();
      },
    );
  }
}
