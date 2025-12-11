import 'package:cloud_firestore/cloud_firestore.dart';

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

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate != null ? Timestamp.fromDate(expirationDate!) : null,
    };
  }

  factory PantryItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PantryItem(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      expirationDate: data['expirationDate'] != null
          ? (data['expirationDate'] as Timestamp).toDate()
          : null,
    );
  }
}
