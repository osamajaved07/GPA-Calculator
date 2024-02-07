// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';


import 'package:flutter/material.dart';

import 'package:gpa_calculator/choice_screen.dart';



class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);



  @override

  State<SplashScreen> createState() => _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen>

    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;



  @override

  void initState() {

    super.initState();



    _animationController = AnimationController(

      vsync: this,

      duration: Duration(seconds: 2),

    );



    _fadeAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(

      CurvedAnimation(

        parent: _animationController,

        curve: Curves.easeInOut,

      ),

    );



    _animationController.forward();



    Timer(Duration(seconds: 4), () {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(builder: (context) => Homescreen()),

      );

    });

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(

          image: DecorationImage(

            image: AssetImage("assets/images/UBITimage.jpg"),

            fit: BoxFit.cover,

          ),

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            FadeTransition(

              opacity: _fadeAnimation,

              child: Center(

                child: Container(

                  width: 250,

                  height: 70,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(16),

                    boxShadow: [

                      BoxShadow(

                        color: Color.fromARGB(255, 158, 158, 158),

                        spreadRadius: 8,

                        blurRadius: 8,

                        offset: Offset(0, 3),

                      ),

                    ],

                    color: Color.fromARGB(255, 0, 128, 128),

                  ),

                  child: Center(
                    child: Text(

                      "GPA CALCULATOR",

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,

                      ),

                    ),

                  ),

                ),

              ),

            )

          ],

        ),

      ),
    );

  }



  @override

  void dispose() {

    _animationController.dispose();

    super.dispose();

  }

}



