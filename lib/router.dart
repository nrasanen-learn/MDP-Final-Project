import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/providers/auth_provider.dart';
import 'package:pantry_pro/screens/create_account_screen.dart';
import 'package:pantry_pro/screens/expiring_soon_screen.dart';
import 'package:pantry_pro/screens/home_screen.dart';
import 'package:pantry_pro/screens/login_screen.dart';
import 'package:pantry_pro/screens/main_screen.dart';
import 'package:pantry_pro/screens/recipe_details_screen.dart';
import 'package:pantry_pro/screens/recipes_screen.dart';
import 'package:pantry_pro/screens/settings_screen.dart';
import 'package:pantry_pro/screens/suggested_recipes_screen.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authProvider.status == AuthStatus.authenticated;
      final isAuthenticating = state.matchedLocation == '/login' || state.matchedLocation == '/create-account';

      if (!isAuthenticated && !isAuthenticating) {
        return '/login';
      }

      if (isAuthenticated && isAuthenticating) {
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
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/recipes',
            builder: (context, state) => const RecipesScreen(),
            routes: [
              GoRoute(
                path: 'suggested',
                builder: (context, state) => const SuggestedRecipesScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return RecipeDetailsScreen(recipeId: id);
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
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
    ],
  );
}
