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

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'recipe/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return RecipeDetailsScreen(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/recipes',
          builder: (context, state) => const RecipesScreen(),
        ),
        GoRoute(
          path: '/suggested-recipes',
          builder: (context, state) => const SuggestedRecipesScreen(),
        ),
        GoRoute(
          path: '/expiring-soon',
          builder: (context, state) => const ExpiringSoonScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
