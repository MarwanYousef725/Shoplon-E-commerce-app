import 'package:flutter/material.dart';
import 'package:ecommerce_app/firebase/database.dart';

class SliderProvider extends ChangeNotifier {
  List products = [];
  bool isLoading = false;

  final DatabaseSliders sliderbase = DatabaseSliders();

  Future<void> loadSlider() async {
    isLoading = true;
    notifyListeners();

    products = await sliderbase.getSliders();

    isLoading = false;
    notifyListeners();
  }
}
