import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class UserModel {
  final String?token;
  final String? picture;
  final String name;
  final String? dob;
  final String email;
  final String phone;
  final String gender;
  final bool volunteer;
  final String userName;
  final String password;

  UserModel({
    required this.name,
    required this.gender,
    required this.email,
    required this.picture,
    required this.dob,
    required this.phone,
    required this.volunteer,
    required this.userName,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'username':this.userName,
      'password' : this.password,
      'name': this.name,
      'gender': this.gender,
      'email':this.email,
      'picture': this.picture,
      'dob': this.dob,
      'phone':this.phone,
      'is_volunteer':this.volunteer,
      'access_token':this.token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      volunteer:json['is_volunteer'] ?? false,
      userName: json['username']??'',
      password: json['password']??'',
      token: json['access_token']??'',


    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

}
