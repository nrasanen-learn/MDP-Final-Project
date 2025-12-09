import 'package:flutter/material.dart';
import 'package:pantry_pro/models/pantry_item.dart';
import 'package:pantry_pro/models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Pancakes',
      ingredients: ['Flour', 'Milk', 'Eggs', 'Sugar'],
      instructions: '1. Mix ingredients. 2. Cook on pan. 3. Serve with syrup.',
      imageUrl: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Recipe(
      id: '2',
      name: 'Omelette',
      ingredients: ['Eggs', 'Cheese', 'Milk'],
      instructions: '1. Whisk eggs and milk. 2. Cook in a pan. 3. Add cheese and fold.',
      imageUrl: 'https://images.unsplash.com/photo-1582719188393-bb718ed7db79?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  List<Recipe> get recipes => _recipes;

  Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Recipe> getSuggestedRecipes(List<PantryItem> pantryItems) {
    final pantryItemNames = pantryItems.map((item) => item.name).toSet();
    return _recipes.where((recipe) {
      return recipe.ingredients.every((ingredient) => pantryItemNames.contains(ingredient));
    }).toList();
  }
}
