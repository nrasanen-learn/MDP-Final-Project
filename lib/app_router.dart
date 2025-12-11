
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/screens/auth_screen.dart';
import 'package:pantry_pro/screens/home_screen.dart';
import 'package:pantry_pro/screens/recipe_details_screen.dart';
import 'package:pantry_pro/screens/recipes_screen.dart';
import 'package:pantry_pro/screens/settings_screen.dart';
import 'package:pantry_pro/screens/expiring_soon_screen.dart';
import 'package:pantry_pro/screens/suggested_recipes_screen.dart';
import 'package:pantry_pro/screens/main_screen.dart';
import 'package:pantry_pro/services/auth_service.dart';

final GoRouter router = GoRouter(
  refreshListenable: GoRouterRefreshStream(AuthService().authStateChanges),
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/recipes',
          builder: (context, state) => const RecipesScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  RecipeDetailsScreen(recipeId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/suggested',
          builder: (context, state) => const SuggestedRecipesScreen(),
        ),
        GoRoute(
          path: '/expiring',
          builder: (context, state) => const ExpiringSoonScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authService = AuthService();
    final loggedIn = authService.getCurrentUser() != null;
    final loggingIn = state.matchedLocation == '/auth';
    final isSplash = state.matchedLocation == '/splash';

    if (isSplash) {
      return null;
    }

    if (!loggedIn) {
      return loggingIn ? null : '/auth';
    }

    if (loggingIn) {
      return '/home';
    }

    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final  _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // The redirect logic in GoRouter will handle navigation after the splash screen.
      // No explicit navigation is needed here.
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

