
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/screens/expiring_soon_screen.dart';
import 'package:pantry_pro/screens/home_screen.dart';
import 'package:pantry_pro/screens/main_screen.dart';
import 'package:pantry_pro/screens/recipe_details_screen.dart';
import 'package:pantry_pro/screens/recipes_screen.dart';
import 'package:pantry_pro/screens/settings_screen.dart';
import 'package:pantry_pro/screens/splash_screen.dart';
import 'package:pantry_pro/screens/suggested_recipes_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
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
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
