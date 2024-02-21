import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future pickImage() async {
  final selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return selectedImage;
}
