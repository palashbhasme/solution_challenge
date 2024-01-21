import 'package:flutter/material.dart';

class PersonDetails {
  final String imageLink;
  final String name;
  final int age;
  final String address;
  final double height;
  final double weight;

  PersonDetails({
    required this.imageLink,
    required this.name,
    required this.age,
    required this.address,
    required this.height,
    required this.weight,
  });
}