import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/screens/expiring_soon_screen.dart';
import 'package:pantry_pro/screens/home_screen.dart';
import 'package:pantry_pro/screens/main_screen.dart';
import 'package:pantry_pro/screens/recipes_screen.dart';
import 'package:pantry_pro/screens/settings_screen.dart';
import 'package:pantry_pro/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:pantry_pro/providers/theme_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PantryProvider()),
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
      ],
      child: const PantryPro(),
    ),
  );
}

class PantryPro extends StatelessWidget {
  const PantryPro({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      title: 'Pantry Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      routerConfig: _router,
    );
  }
}
