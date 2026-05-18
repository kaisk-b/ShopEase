import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/cart/application/cart_controller.dart';
import '../features/shell/presentation/pages/app_shell.dart';

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  late final CartController _cartController;

  @override
  void initState() {
    super.initState();
    _cartController = CartController();
  }

  @override
  void dispose() {
    _cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      controller: _cartController,
      child: MaterialApp(
        title: 'ShopEase',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routes: {
          AppRoutes.welcome: (_) => const WelcomePage(),
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.signUp: (_) => const SignUpPage(),
          AppRoutes.home: (_) => const AppShell(),
        },
        initialRoute: AppRoutes.welcome,
      ),
    );
  }
}

class AppRoutes {
  static const welcome = '/';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const home = '/home';
}
