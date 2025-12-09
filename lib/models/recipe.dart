class Recipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final String instructions;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
  });
}
