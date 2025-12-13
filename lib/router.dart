import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/screens/expiring_soon_screen.dart';
import 'package:pantry_pro/screens/home_screen.dart';
import 'package:pantry_pro/screens/login_screen.dart';
import 'package:pantry_pro/screens/main_screen.dart';
import 'package:pantry_pro/screens/recipe_details_screen.dart';
import 'package:pantry_pro/screens/register_screen.dart';
import 'package:pantry_pro/screens/settings_screen.dart';
import 'package:pantry_pro/widgets/recipe_list.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = FirebaseAuth.instance.currentUser != null;
      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/recipes',
            builder: (context, state) => const RecipeList(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
                  final recipe = recipeProvider.getRecipeById(id);
                  return RecipeDetailsScreen(recipe: recipe!);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/expiring-soon',
            builder: (context, state) => const ExpiringSoonScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
