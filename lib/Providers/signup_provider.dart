import 'package:ecommerce_app/firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupProvider extends ChangeNotifier {
  bool isLoading = false;
  bool passwordVisible = true;
  bool privacy = false;
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void togglePrivacy() {
    privacy = !privacy;
    notifyListeners();
  }

  signUp(String email, String password, String name) async {
    isLoading = true;

    notifyListeners();

    try {
      final result = await AuthService().registerWithEmailAndPassword(
        email,
        password,
      );
      if (result != null) {
        final DatabaseUsers database = DatabaseUsers();
        await database.createUser(name: name, email: email);
      }
      isLoading = false;
      notifyListeners();
      return result;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }
}
