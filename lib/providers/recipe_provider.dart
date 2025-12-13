import 'dart:convert';
import 'dart:developer' as developer;

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Add this import
import 'package:flutter/material.dart';
import 'package:pantry_pro/models/pantry_item.dart';
import 'package:pantry_pro/models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> generateRecipes(List<PantryItem> pantryItems) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Sort pantry items by expiration date
      pantryItems.sort((a, b) => a.expirationDate!.compareTo(b.expirationDate!));

      final pantryItemNames = pantryItems.map((item) => item.name).toList();
      final prompt =
          'Generate a list of recipes based on the following ingredients, prioritizing the ones listed first: ${pantryItemNames.join(', ')}. Return the response as a JSON object with a key of "recipes" and a value of a list of recipes. Each recipe should have the following keys: "id", "name", "ingredients", "instructions", and "imageUrl".';

      // Use FirebaseAI.vertexAI() to get the instance, then call generativeModel
      final vertexAI = FirebaseAI.vertexAI(auth: FirebaseAuth.instance);
      final model = vertexAI.generativeModel(model: 'gemini-1.5-flash');
      
      final response = await model.generateContent([Content.text(prompt)]);

      if (response.text != null) {
        // Clean the response to ensure it is valid JSON
        String cleanedJson = response.text!
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();
        final decodedResponse = jsonDecode(cleanedJson) as Map<String, dynamic>;
        final recipeList = decodedResponse['recipes'] as List<dynamic>;

        _recipes = recipeList
            .map((recipeData) => Recipe.fromJson(recipeData))
            .toList();
      } else {
        _error = 'No response from model.';
      }
    } catch (e, s) {
      _error = 'Error generating recipes: $e';
      developer.log(
        'An error occurred while generating recipes',
        name: 'pantry_pro.recipe_provider',
        level: 900, // WARNING
        error: e,
        stackTrace: s,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}