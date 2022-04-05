import 'package:amity_sdk/lib.dart';
import 'package:flutter_application_1_example/core/route/app_route.dart';
import 'package:flutter_application_1_example/dashboar_screen.dart';
import 'package:flutter_application_1_example/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.homeRoute,
    routes: [
      GoRoute(
        name: AppRoute.home,
        path: AppRoute.homeRoute,
        redirect: (_) => AmityCoreClient.isUserLoggedIn() ? null : '/login',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        name: AppRoute.login,
        path: AppRoute.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    debugLogDiagnostics: true,
  );
}
