import 'package:flutter/material.dart';
import 'package:pantry_pro/models/recipe.dart';
import 'package:pantry_pro/screens/recipe_details_screen.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.network(recipe.imageUrl, width: 100, fit: BoxFit.cover),
        title: Text(recipe.name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsScreen(recipe: recipe),
            ),
          );
        },
      ),
    );
  }
}
