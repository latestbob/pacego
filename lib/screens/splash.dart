import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacegotwo/screens/getstarted.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      // print("5 seconds completed");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GetStarted();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E4854),
      body: Center(
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(
              "https://res.cloudinary.com/edifice-solutions/image/upload/v1680642543/Group_2_1_vo9yzo.png"),
        ),
      ),
    );
  }
}
