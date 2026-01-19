import 'package:ecommerce_app/firebase/database.dart';
import 'package:ecommerce_app/firebase/model_users.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserInfo userInfo = UserInfo(name: '', email: '');
  final DatabaseUsers _database = DatabaseUsers();
  List _users = [];

  void loaduserinfo(String email) async {
    _users = await _database.getUser();
    for (var user in _users) {
      UserInfo userInfo1 = UserInfo.fromJson(user);
      if (userInfo1.email == email) {
        userInfo = UserInfo.fromJson(user);
        notifyListeners();
        break;
      }
    }
  }
}
