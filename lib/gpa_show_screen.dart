// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';


class GPA_Show_Screen extends StatelessWidget {
  final double gpa;

  const GPA_Show_Screen({Key? key, required this.gpa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 128, 128),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 128, 128),
      ),
      body: Center(
        child: Column(
          
          children: [
            Text(
              'Your GPA is:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              gpa.toStringAsFixed(2), // Format GPA to display only two decimal places
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}
