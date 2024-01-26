import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage() async {
  final selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return selectedImage;
}
