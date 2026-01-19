import 'package:flutter/material.dart';
import 'package:ecommerce_app/firebase/database.dart';

class ProductProvider extends ChangeNotifier {
  List products = [];
  bool isLoading = false;

  final DatabaseProducts productbase = DatabaseProducts();

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    products = await productbase.getProducts();

    isLoading = false;
    notifyListeners();
  }
}

class Productpro extends ChangeNotifier {
  int selectedind = 0;
  void ChangeInd(int ind) {
    selectedind = ind;
    notifyListeners();
  }
}
