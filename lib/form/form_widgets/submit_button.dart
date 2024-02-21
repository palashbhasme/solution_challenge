import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.0),
        borderRadius: BorderRadius.circular(24),
        color: GlobalVariables.selected_app_bar_color,
      ),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black12.withOpacity(0.03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 24),
        ),
      ),
    );
  }
}
