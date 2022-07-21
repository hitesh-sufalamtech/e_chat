import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/services/db.dart';

abstract class BaseAuth {
  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String username, String email, String password);

  Future<User> getCurrentUser();

  Future<void> signOut();
}

class Auth with ChangeNotifier implements BaseAuth {
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _fbUser;

  bool get isAuth {
    return _fbUser != null;
  }

  User get getUser {
    return _fbUser;
  }

  void reloadUser() {
    _fbUser.reload();
    notifyListeners();
  }

  @override
  Future<User> getCurrentUser() async {
    _fbUser = _firebaseAuth.currentUser;
    return _fbUser;
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      _fbUser = user;
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<bool> signUp(String username, String email, String password) async {
    // print('email ======> $email password ----------> $password');
    try {
      final db = DB();
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      _fbUser = user;

      notifyListeners();

      db.addNewUser(_fbUser.uid, _fbUser.photoURL, username, email);

      _fbUser.updateDisplayName(username);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<void> signOut() {
    var res = _firebaseAuth.signOut();
    notifyListeners();
    return res;
  }
}
