import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    name: '',
    gender: '',
    email: '',
    picture: '',
    dob: '',
    phone: '',
    volunteer: false,
    userName: '',
    password: '',
    token: '',
  );

  UserModel get user => _user;

  set user(UserModel newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners when user data changes
  }
}
