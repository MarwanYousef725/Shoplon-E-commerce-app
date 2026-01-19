import 'package:flutter/material.dart';
import 'package:ecommerce_app/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
  bool passwordVisible = true;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await AuthService().signInWithEmailAndPassword(
        email,
        password,
      );
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
