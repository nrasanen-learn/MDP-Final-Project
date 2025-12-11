import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/auth_provider.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:pantry_pro/providers/theme_provider.dart';
import 'package:pantry_pro/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
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
    final router = createRouter(context);

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
