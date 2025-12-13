import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/widgets/recipe_list_item.dart';
import 'package:provider/provider.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return recipeProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : recipeProvider.recipes.isEmpty
        ? const Center(
            child: Text(
              'No recipes found. Try adding more items to your pantry!',
            ),
          )
        : ListView.builder(
            itemCount: recipeProvider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeProvider.recipes[index];
              return RecipeListItem(recipe: recipe);
            },
          );
  }
}
