import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/firebase/database.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int selectedind = -1;
  bool isselected = false;
  void ChangeInd(int ind) {
    selectedind = ind;
    isselected = true;
    notifyListeners();
  }
}

class productcartprovider extends ChangeNotifier {
  List products = [];
  bool isLoading = false;

  final DatabaseProducts productbase = DatabaseProducts();

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    var snapshot = await FirebaseFirestore.instance
        .collectionGroup('cartProducts')
        .get();
    products = snapshot.docs.toList();

    isLoading = false;
    notifyListeners();
  }
}
