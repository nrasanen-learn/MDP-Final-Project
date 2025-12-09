import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailsScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context).getRecipeById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Recipe not found!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            for (final ingredient in recipe.ingredients)
              Text('  - $ingredient'),
            const SizedBox(height: 16.0),
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
