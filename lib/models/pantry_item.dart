class PantryItem {
  final String name;
  int quantity;
  final DateTime? expirationDate;

  PantryItem({
    required this.name,
    required this.quantity,
    this.expirationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate?.toIso8601String(),
    };
  }

  factory PantryItem.fromMap(Map<String, dynamic> map) {
    return PantryItem(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      expirationDate: map['expirationDate'] != null
          ? DateTime.parse(map['expirationDate'])
          : null,
    );
  }
}
