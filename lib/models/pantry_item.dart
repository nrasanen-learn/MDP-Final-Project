import 'package:cloud_firestore/cloud_firestore.dart';

class PantryItem {
  final String? id;
  final String name;
  final int quantity;
  final DateTime? expirationDate;

  PantryItem({
    this.id,
    required this.name,
    required this.quantity,
    this.expirationDate,
  });

  factory PantryItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PantryItem(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      expirationDate: data['expirationDate'] != null
          ? (data['expirationDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      if (expirationDate != null) 'expirationDate': expirationDate,
    };
  }
}
