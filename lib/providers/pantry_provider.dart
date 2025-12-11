import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_pro/models/pantry_item.dart';

class PantryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'pantry_items';
  List<PantryItem> _items = [];

  PantryProvider() {
    _loadItems();
  }

  List<PantryItem> get items => _items;

  Future<void> _loadItems() async {
    final snapshot = await _firestore.collection(_collectionPath).get();
    _items = snapshot.docs.map((doc) => PantryItem.fromFirestore(doc)).toList();
    notifyListeners();
  }

  List<PantryItem> get expiringSoonItems {
    final now = DateTime.now();
    final aMonthFromNow = now.add(const Duration(days: 30));
    return _items.where((item) {
      return item.expirationDate != null &&
          item.expirationDate!.isAfter(now) &&
          item.expirationDate!.isBefore(aMonthFromNow);
    }).toList();
  }

  Future<void> addItem({
    required String name,
    required int quantity,
    DateTime? expirationDate,
  }) async {
    await _firestore.collection(_collectionPath).add({
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate != null ? Timestamp.fromDate(expirationDate) : null,
    });
    _loadItems();
  }

  Future<void> removeItem(String id) async {
    await _firestore.collection(_collectionPath).doc(id).delete();
    _loadItems();
  }

  Future<void> updateItemQuantity(PantryItem item, int quantity) async {
    await _firestore
        .collection(_collectionPath)
        .doc(item.id)
        .update({'quantity': quantity});
    _loadItems();
  }
}
