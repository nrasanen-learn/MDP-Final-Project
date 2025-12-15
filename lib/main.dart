import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pantry_pro/providers/theme_provider.dart';
import 'package:pantry_pro/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/* notes: this ai was good initially but slowing got itself stuck in loops and became 
/more of a problem to manage then a useful tool */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        StreamProvider<User?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
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
    final router = createRouter();

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
