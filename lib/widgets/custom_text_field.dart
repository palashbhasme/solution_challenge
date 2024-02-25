import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final int maxLines;
  final bool showHint;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.showHint,
    this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            //changing the padding inside the text field
            filled: true,
            fillColor: GlobalVariables.text_field_color,
            hintText: showHint ? hintText : null,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w100,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
                // Set borderSide to none to remove the border not working!
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter ${hintText}';
            }
          },
          maxLines: maxLines,
        ),
      ),
    );
  }
}
