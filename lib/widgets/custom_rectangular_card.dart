import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';

class CustomRectangularCard extends StatelessWidget {
  const CustomRectangularCard(
      {super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: 158,
      height: 282,
      decoration: BoxDecoration(
        color: GlobalVariables.secondary_color,
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
          Image(
            image: AssetImage(image),
            width: 140,
            height: 140,
          ),
          Text(text, style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18
          ),)
        ],
      ),
    );
  }
}
