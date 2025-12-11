import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_pro/models/pantry_item.dart';

class DatabaseService {
  final FirebaseFirestore _db;
  final String uid;

  DatabaseService({required this.uid, FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get pantryCollection => _db.collection('users').doc(uid).collection('pantry');

  // Add pantry item
  Future<void> addPantryItem(PantryItem item) {
    return pantryCollection.doc(item.id).set(item.toMap());
  }

  // Get pantry items stream
  Stream<List<PantryItem>> get pantryItems {
    return pantryCollection.snapshots().map(_pantryItemListFromSnapshot);
  }

  // Delete pantry item
  Future<void> deletePantryItem(String id) {
    return pantryCollection.doc(id).delete();
  }

  // Helper function to create a list of PantryItems from a snapshot
  List<PantryItem> _pantryItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PantryItem.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
