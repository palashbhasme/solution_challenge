import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';
class CustomSquareCard extends StatelessWidget {
  const CustomSquareCard({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      height: 144,
      decoration: BoxDecoration(
        color: GlobalVariables.tertiary_color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(image),),
          Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13
          ),)
        ],
      ),

    );
  }
}
