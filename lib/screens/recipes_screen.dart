import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: recipeProvider.recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipeProvider.recipes[index];
          return RecipeCard(
            recipe: recipe,
            onTap: () => context.go('/recipe/${recipe.id}'),
          );
        },
      ),
    );
  }
}
