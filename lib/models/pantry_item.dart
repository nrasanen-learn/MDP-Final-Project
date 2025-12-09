class PantryItem {
  final String id;
  final String name;
  int quantity;
  final DateTime? expirationDate;

  PantryItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.expirationDate,
  });
}
