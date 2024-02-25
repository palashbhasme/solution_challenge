import 'package:flutter/material.dart';

import '../../common/global_variables.dart';
class DobPicker extends StatelessWidget {
  const DobPicker({super.key});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        // Open your date picker here
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                // Display the selected date here. Initialize with a default text if necessary.
                'Select Date', // Assume selectedDate is a variable that holds the date
                style: TextStyle(
                  // Adjust your text style
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
