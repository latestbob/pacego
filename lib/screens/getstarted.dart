import 'package:flutter/material.dart';
import 'package:pacegotwo/auth/login.dart';
import 'package:pacegotwo/auth/register.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(
                  "https://res.cloudinary.com/edifice-solutions/image/upload/v1680642543/Group_2_1_vo9yzo.png"),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45.0,
                decoration: BoxDecoration(
                  color: Color(0xFF049FA3),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                child: Text(
                  "Exiting User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterScreen();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45.0,
                decoration: BoxDecoration(
                  color: Color(0xFF049FA3),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                child: Text(
                  "New User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
