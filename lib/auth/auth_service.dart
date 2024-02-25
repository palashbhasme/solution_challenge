import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge/common/error_handling.dart';
import 'package:solution_challenge/common/utils.dart';
import 'package:solution_challenge/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge/screens/home_screen.dart';

class AuthServices {
  void registerUser(
      {required phone,
      required BuildContext context,
      required firstName,
      required email,
      required userName,
      required password}) async {
    try {
      UserModel user = UserModel(
        name: firstName,
        gender: 'O',
        email: email,
        picture: '',
        dob: '2024-03-23',
        phone: phone,
        volunteer: false,
        userName: userName,
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('http://10.0.4.104:8000//apis/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print(response.body);
      httpErrorHandler(
          response: response,
          buildContext: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setString(
              'x-auth-token',
              jsonDecode(response.body)['access_token'],
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackbar(context, 'An unexpected error occurred: ${e.toString()}');
    }
  }

  void signInUser(
      {required BuildContext context,
      required userName,
      required password}) async {
    try {
      UserModel user = UserModel(
        name: '',
        gender: 'O',
        email: '',
        picture: '',
        dob: '',
        phone: '',
        volunteer: false,
        userName: userName,
        password: password,
        token: '',
      );
      print(user.toJson());

      http.Response response = await http.post(
        Uri.parse('http://10.0.4.104:8000//apis/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: user.toJson(),
      );
      httpErrorHandler(
          response: response,
          buildContext: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setString(
              'x-auth-token',
              jsonDecode(response.body)['refresh'],
            );

            print(response.body);

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackbar(context, 'An unexpected error occurred: ${e.toString()}');
    }
  }
}
