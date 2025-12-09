import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class SuggestedRecipesScreen extends StatelessWidget {
  const SuggestedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryProvider = Provider.of<PantryProvider>(context);
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final suggestedRecipes = recipeProvider.getSuggestedRecipes(pantryProvider.items);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Recipes'),
      ),
      body: suggestedRecipes.isEmpty
          ? const Center(
              child: Text('No suggested recipes found. Add more items to your pantry!'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: suggestedRecipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: suggestedRecipes[index]);
              },
            ),
    );
  }
}
