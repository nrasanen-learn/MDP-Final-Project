
import 'dart:async';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:pantry_pro/models/recipe.dart';

class RecipeService {
  final FirebaseVertexAI _ai;

  RecipeService({FirebaseVertexAI? ai}) : _ai = ai ?? FirebaseVertexAI.instance;

  Future<Recipe> generateRecipe(List<String> ingredients) async {
    final model = _ai.generativeModel(model: 'gemini-1.5-flash');

    final prompt =
        'Create a recipe using the following ingredients: ${ingredients.join(', ')}. Include a creative name for the recipe, a list of ingredients, and step-by-step instructions. Provide a placeholder image URL.';

    final response = await model.generateContent([Content.text(prompt)]);

    // A basic parsing of the response. This would need to be more robust in a real app.
    final lines = response.text!.split('\n');
    final name = lines.first;
    final ingredientList = lines
        .where((line) => line.startsWith('*'))
        .map((line) => line.substring(2))
        .toList();
    final instructionList = lines
        .where((line) => line.startsWith('1'))
        .map((line) => line.substring(2))
        .toList();

    return Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      ingredients: ingredientList,
      instructions: instructionList,
      imageUrl: 'https://via.placeholder.com/150',
    );
  }

  // In a real app, this would fetch from a database
  Future<List<Recipe>> getRecipes() async {
    return [];
  }
}
