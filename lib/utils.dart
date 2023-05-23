import 'package:flutter/material.dart';
import '/storage/storage.dart';
// class UtilsThe
  
class StateNotifier extends ChangeNotifier {
  MyAppState() {
    loadUserLocal();
  }

  Map<String, dynamic> _currentUser = {};

  bool isLogin() {
    if (_currentUser.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // connect a user 
  Future<void> login(Map<String, dynamic> currentUser) async {
    _currentUser = currentUser;
    await Storage.addUser(_currentUser);
    // avertir que le current user a changer
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser.clear();
    await Storage.delUser();
    notifyListeners();//package provider 
  }

  Map<String, dynamic> getUser() {
    return _currentUser;
  }

  // changer user connecter en local
  Future<void> loadUserLocal() async {
    Map<String, dynamic> user = await Storage.getUser();
    login(user);
  }
}


// johnd    m38rmF$