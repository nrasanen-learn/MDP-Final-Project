import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:pantry_pro/providers/theme_provider.dart';
import 'package:pantry_pro/router.dart';

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
      routerConfig: router,
    );
  }
}
