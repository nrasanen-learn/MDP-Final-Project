import 'package:flutter/material.dart';
import 'package:pantry_pro/models/pantry_item.dart';

class PantryProvider with ChangeNotifier {
  final List<PantryItem> _items = [
    PantryItem(id: '1', name: 'Apples', quantity: 2, expirationDate: DateTime.now().add(const Duration(days: 7))),
    PantryItem(id: '2', name: 'Bread', quantity: 1, expirationDate: DateTime.now().add(const Duration(days: 3))),
    PantryItem(id: '3', name: 'Milk', quantity: 1, expirationDate: DateTime.now().add(const Duration(days: 5))),
    PantryItem(id: '4', name: 'Chicken Breast', quantity: 1, expirationDate: DateTime.now().add(const Duration(days: 25))),

  ];

  List<PantryItem> get items => _items;

  List<PantryItem> get expiringSoonItems {
    final now = DateTime.now();
    final aMonthFromNow = now.add(const Duration(days: 30));
    return _items.where((item) {
      return item.expirationDate != null &&
             item.expirationDate!.isAfter(now) &&
             item.expirationDate!.isBefore(aMonthFromNow);
    }).toList();
  }

  void addItem(PantryItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateItemQuantity(PantryItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }
}
