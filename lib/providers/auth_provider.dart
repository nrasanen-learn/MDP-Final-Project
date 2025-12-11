
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  uninitialized,
  authenticating,
  authenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  AuthStatus _status = AuthStatus.uninitialized;
  String? _errorMessage;

  User? get user => _user;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        _status = AuthStatus.uninitialized;
      } else {
        _user = user;
        _status = AuthStatus.authenticated;
      }
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = AuthStatus.uninitialized;
    notifyListeners();
  }
}
