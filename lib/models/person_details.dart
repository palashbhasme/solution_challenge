import 'dart:convert';

import 'package:flutter/material.dart';

class PersonDetails {
  final String image;
  final String name;
  final String address;
  final double height;
  final double weight;
  final String bloodType;
  final String gender;
  final String isMalnourished;
  final String dob;
  final String allergies;


  PersonDetails({
    required this.name,
    required this.address,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.gender,
    required this.isMalnourished,
    required this.image,
    required this.dob,
    required this.allergies,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'picture': this.image,
      'gender': this.gender,
      'dob': this.dob,
      'height': this.height,
      'weight': this.weight,
      'bloodtype': this.bloodType,
      'address': this.address,
      'ismalnourished': this.isMalnourished,
      'allergies': this.allergies,
    };
  }

  factory PersonDetails.fromMap(Map<String, dynamic> json) {
    return PersonDetails(
      name: json['name']?? '',
      image: json['picture']??'',
      gender:  json['gender']??'',
      dob: json["dob"]??'',
      height: json['height']?? '',
      weight: json['weight']?? '',
      bloodType: json['bloodtype']?? '',
      address: json['address']?? '',
      isMalnourished: json['ismalnourished']?? '',
      allergies: json['allergies']??'',


    );
  }
  String toJson() => jsonEncode(toMap());
  factory PersonDetails.fromJson(String source) => PersonDetails.fromMap(json.decode(source));
//
}