import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  // username values

  String username = "";

  ///function that gets username
  ///
  ///

  String get getUsername => username;

  //set username

  void setUsername(String name) {
    username = name;

    notifyListeners();
  }

  ///email values
  ///

  String email = "";

//get email function
  String get getEmail => email;

  //set email function

  void setEmail(String input) {
    email = input;
    notifyListeners();
  }
}
